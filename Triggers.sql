--Trigggers

--1. Trigger para Actualizar el Total de un Pedido
CREATE OR REPLACE TRIGGER trg_actualizar_total_pedido
AFTER INSERT OR UPDATE ON DetallePedido
FOR EACH ROW
DECLARE
    v_total DECIMAL(10, 2);
BEGIN
    BEGIN
        -- Calcular el total del pedido
        SELECT SUM(d.PrecioTotal)
        INTO v_total
        FROM DetallePedido d
        WHERE d.PedidoID = :NEW.PedidoID;

        -- Actualizar el total del pedido
        UPDATE Pedido
        SET TotalPedido = v_total
        WHERE PedidoID = :NEW.PedidoID;

        DBMS_OUTPUT.PUT_LINE('El total actualizado para el PedidoID ' || :NEW.PedidoID || ' es: ' || v_total);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
    END;
END;

--2. Trigger para Aplicar Descuento de Promoción
CREATE OR REPLACE TRIGGER trg_aplicar_descuento_promocion
AFTER INSERT OR UPDATE ON Pedido
FOR EACH ROW
DECLARE
    v_descuento DECIMAL(5, 2);
BEGIN
    IF :NEW.PromocionID IS NOT NULL THEN
        BEGIN
            -- Obtener el descuento de la promoción
            SELECT COALESCE(p.Descuento, 0)
            INTO v_descuento
            FROM Promocion p
            WHERE p.PromocionID = :NEW.PromocionID;

            -- Aplicar descuento basado en la promoción
            UPDATE Pedido
            SET TotalPedido = TotalPedido - (v_descuento * TotalPedido / 100)
            WHERE PedidoID = :NEW.PedidoID;

            DBMS_OUTPUT.PUT_LINE('Descuento aplicado para el PedidoID ' || :NEW.PedidoID || '. Descuento: ' || v_descuento);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
        END;
    END IF;
END;

--3. Trigger para Actualizar la Información del Cliente
CREATE OR REPLACE TRIGGER trg_actualizar_info_cliente
AFTER INSERT ON Pedido
FOR EACH ROW
DECLARE
    v_cliente_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_cliente_exists
    FROM Cliente
    WHERE ClienteID = :NEW.ClienteID;

    IF v_cliente_exists > 0 THEN
        BEGIN
            -- Actualizar información del cliente
            UPDATE Cliente
            SET UltimoPedido = SYSDATE,
                TotalGastado = COALESCE(TotalGastado, 0) + :NEW.TotalPedido
            WHERE ClienteID = :NEW.ClienteID;

            DBMS_OUTPUT.PUT_LINE('Información del cliente con ClienteID ' || :NEW.ClienteID || ' actualizada exitosamente.');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error inesperado al actualizar la información del cliente: ' || SQLERRM);
        END;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente con ClienteID ' || :NEW.ClienteID || ' no existe. No se realizó ninguna actualización.');
    END IF;
END;

--4. Trigger para Calcular el Total de Ventas por Producto
CREATE OR REPLACE TRIGGER trg_actualizar_total_ventas_producto
AFTER INSERT OR UPDATE ON DetallePedido
FOR EACH ROW
DECLARE
    v_total_ventas DECIMAL(10, 2) := 0;
BEGIN
    BEGIN
        -- Calcular el total de ventas del producto
        SELECT SUM(d.CantidadProductos * d.PrecioUnitario)
        INTO v_total_ventas
        FROM DetallePedido d
        WHERE d.ProductoID = :NEW.ProductoID;

        -- Actualizar el total de ventas del producto
        UPDATE Producto
        SET TotalVentas = v_total_ventas
        WHERE ProductoID = :NEW.ProductoID;

        DBMS_OUTPUT.PUT_LINE('Total de ventas para el ProductoID ' || :NEW.ProductoID || ' actualizado exitosamente a: ' || v_total_ventas);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado al calcular el total de ventas: ' || SQLERRM);
            -- Asegúrate de establecer TotalVentas a 0 si ocurre un error
            UPDATE Producto
            SET TotalVentas = v_total_ventas
            WHERE ProductoID = :NEW.ProductoID;
    END;
END;

--5. Trigger para Insertar un Registro en la Vista 'HistorialPedidos' al Crear un nuevo Pedido
CREATE OR REPLACE TRIGGER trg_insertar_historial_pedido
AFTER INSERT ON Pedido
FOR EACH ROW
DECLARE
    v_nombre Cliente.Nombre%TYPE;
    v_apellidos Cliente.Apellidos%TYPE;
BEGIN
    BEGIN
        -- Obtener el nombre y apellidos del cliente basado en el ClienteID del nuevo pedido
        SELECT c.Nombre, c.Apellidos
        INTO v_nombre, v_apellidos
        FROM Cliente c
        WHERE c.ClienteID = :NEW.ClienteID;

        -- Insertar en la vista HistorialPedidos
        INSERT INTO HistorialPedidos (ClienteID, Nombre, Apellidos, PedidoID, Fecha, Hora, SucursalID, MetodoPagoID, PromocionID, TipoVentaID, TotalPedido)
        VALUES (:NEW.ClienteID, v_nombre, v_apellidos, :NEW.PedidoID, :NEW.Fecha, :NEW.Hora, :NEW.SucursalID, :NEW.MetodoPagoID, :NEW.PromocionID, :NEW.TipoVentaID, :NEW.TotalPedido);
        
        DBMS_OUTPUT.PUT_LINE('Nuevo pedido registrado en HistorialPedidos con ID: ' || :NEW.PedidoID);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró información para el ClienteID ' || :NEW.ClienteID);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado al insertar en HistorialPedidos: ' || SQLERRM);
    END;
END;

--6. Trigger para Actualizar la Vista 'ClientesFrecuentes' al Insertar un nuevo Cliente
CREATE OR REPLACE TRIGGER trg_insertar_cliente
AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN
    BEGIN
        INSERT INTO ClientesFrecuentes (ClienteID, Nombre, NumeroPedidos)
        VALUES (:NEW.ClienteID, :NEW.Nombre, 0);
        
        DBMS_OUTPUT.PUT_LINE('Nuevo cliente insertado en ClientesFrecuentes con ID: ' || :NEW.ClienteID);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado al insertar en ClientesFrecuentes: ' || SQLERRM);
    END;
END;

--7. Trigger para Actualizar la Vista 'PreferenciasClientes' al Modificar un Pedido
CREATE OR REPLACE TRIGGER trg_actualizar_preferencias_clientes
AFTER UPDATE ON DetallePedido
FOR EACH ROW
DECLARE
    v_cliente_id Cliente.ClienteID%TYPE;
BEGIN
    BEGIN
        SELECT p.ClienteID
        INTO v_cliente_id
        FROM Pedido p
        WHERE p.PedidoID = :NEW.PedidoID;

        MERGE INTO PreferenciasClientes pc
        USING (SELECT v_cliente_id AS ClienteID, :NEW.IngredienteExtraID AS IngredienteExtraID, :NEW.CantidadProductos AS Cantidad FROM DUAL) src
        ON (pc.ClienteID = src.ClienteID AND pc.IngredienteExtraID = src.IngredienteExtraID)
        WHEN MATCHED THEN
            UPDATE SET pc.Cantidad = pc.Cantidad + src.Cantidad
        WHEN NOT MATCHED THEN
            INSERT (ClienteID, IngredienteExtraID, Cantidad)
            VALUES (src.ClienteID, src.IngredienteExtraID, src.Cantidad);

        DBMS_OUTPUT.PUT_LINE('Preferencias actualizadas para ClienteID: ' || v_cliente_id ||
                             ', IngredienteExtraID: ' || :NEW.IngredienteExtraID);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado al actualizar PreferenciasClientes: ' || SQLERRM);
    END;
END;