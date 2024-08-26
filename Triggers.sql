--Trigggers

--Trigger para Actualizar el Total de un Pedido
CREATE OR REPLACE TRIGGER trg_actualizar_total_pedido
AFTER INSERT OR UPDATE ON DetallePedido
FOR EACH ROW
DECLARE
    v_total NUMBER;
BEGIN
    -- Calcular el nuevo total del pedido
    SELECT SUM(d.CantidadProductos * p.PrecioUnitario)
    INTO v_total
    FROM DetallePedido d
    JOIN Producto p ON d.IDProducto = p.IDProducto
    WHERE d.IDPedido = :NEW.IDPedido;

    -- Actualizar el total del pedido
    UPDATE Pedido
    SET TotalPedido = v_total
    WHERE IDPedido = :NEW.IDPedido;
END;

--Trigger para Aplicar Descuento de Promoción
CREATE OR REPLACE TRIGGER trg_aplicar_descuento_promocion
AFTER INSERT OR UPDATE ON Pedido
FOR EACH ROW
BEGIN
    IF :NEW.IDPromocion IS NOT NULL THEN
        -- Aplicar descuento basado en la promoción
        UPDATE Pedido
        SET TotalPedido = TotalPedido - (
            SELECT Descuento
            FROM Promocion
            WHERE IDPromocion = :NEW.IDPromocion
        )
        WHERE IDPedido = :NEW.IDPedido;
    END IF;
END;

--Trigger para Actualizar la Información del Cliente
CREATE OR REPLACE TRIGGER trg_actualizar_info_cliente
AFTER INSERT ON Pedido
FOR EACH ROW
BEGIN
    -- Actualizar información del cliente
    UPDATE Cliente
    SET UltimoPedido = SYSDATE,
        TotalGastado = TotalGastado + :NEW.TotalPedido
    WHERE IDCliente = :NEW.IDCliente;
END;

--Trigger para Calcular el Total de Ventas por Producto
CREATE OR REPLACE TRIGGER trg_actualizar_total_ventas_producto
AFTER INSERT OR UPDATE ON DetallePedido
FOR EACH ROW
DECLARE
    v_total_ventas NUMBER;
BEGIN
    -- Calcular el total de ventas del producto
    SELECT SUM(d.CantidadProductos * d.PrecioUnitario)
    INTO v_total_ventas
    FROM DetallePedido d
    WHERE d.IDProducto = :NEW.IDProducto;

    -- Actualizar el total de ventas del producto
    UPDATE Producto
    SET TotalVentas = v_total_ventas
    WHERE IDProducto = :NEW.IDProducto;
END;

--Trigger para Insertar un Registro en la Vista 'HistorialPedidos' al Crear un nuevo Pedido
CREATE OR REPLACE TRIGGER trg_insertar_historial_pedido
AFTER INSERT ON Pedido
FOR EACH ROW
BEGIN
    -- Insertar el nuevo pedido en HistorialPedidos
    INSERT INTO HistorialPedidos (idPedido, idCliente, fechaPedido, total)
    VALUES (:NEW.idPedido, :NEW.idCliente, :NEW.fechaPedido, :NEW.total);
END;

--Trigger para Actualizar la Vista 'ClientesFrecuentes' al Insertar un nuevo Cliente
CREATE OR REPLACE TRIGGER trg_insertar_cliente
AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN
    -- Insertar el nuevo cliente en ClientesFrecuentes
    INSERT INTO ClientesFrecuentes (idCliente, nombre, numeroPedidos)
    VALUES (:NEW.idCliente, :NEW.nombre, 0);
END;

--Trigger para Actualizar la Vista 'PreferenciasClientes' al Modificar un Pedido
CREATE OR REPLACE TRIGGER trg_actualizar_preferencias_clientes
AFTER UPDATE ON DetallePedido
FOR EACH ROW
BEGIN
    -- Actualizar preferencias de los clientes
    INSERT INTO PreferenciasClientes (idCliente, idIngredienteExtra, cantidad)
    VALUES (:NEW.idCliente, :NEW.idIngredienteExtra, :NEW.cantidadProductos)
    ON DUPLICATE KEY UPDATE cantidad = cantidad + :NEW.cantidadProductos;
END;