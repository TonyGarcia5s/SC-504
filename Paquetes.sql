--Paquetes

--1. Operaciones de clientes

CREATE OR REPLACE PACKAGE pkg_cliente_ops AS
    PROCEDURE MostrarClientes;
    PROCEDURE InsertarCliente(
        p_Nombre IN VARCHAR2, 
        p_Apellidos IN VARCHAR2, 
        p_Email IN VARCHAR2
    );
    FUNCTION ObtenerClientePorID(p_ClienteID IN NUMBER) RETURN SYS_REFCURSOR;
END pkg_cliente_ops;

CREATE OR REPLACE PACKAGE BODY pkg_cliente_ops AS
    PROCEDURE MostrarClientes IS
        CURSOR cur_Clientes IS
            SELECT ClienteID, Nombre, Apellidos, Email FROM Cliente;

        v_ClienteID Cliente.ClienteID%TYPE;
        v_Nombre    Cliente.Nombre%TYPE;
        v_Apellidos Cliente.Apellidos%TYPE;
        v_Email     Cliente.Email%TYPE;
    BEGIN
        OPEN cur_Clientes;
        LOOP
            FETCH cur_Clientes INTO v_ClienteID, v_Nombre, v_Apellidos, v_Email;
            EXIT WHEN cur_Clientes%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_ClienteID || ' | Nombre: ' || v_Nombre || ' | Apellidos: ' || v_Apellidos || ' | Email: ' || v_Email);
        END LOOP;
        CLOSE cur_Clientes;
    END MostrarClientes;

    PROCEDURE InsertarCliente(p_Nombre IN VARCHAR2, p_Apellidos IN VARCHAR2, p_Email IN VARCHAR2) IS
    BEGIN
        INSERT INTO Cliente (Nombre, Apellidos, Email)
        VALUES (p_Nombre, p_Apellidos, p_Email);
        COMMIT;
    END InsertarCliente;

    FUNCTION ObtenerClientePorID(p_ClienteID IN NUMBER) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT Nombre, Apellidos, Email
            FROM Cliente
            WHERE ClienteID = p_ClienteID;
        RETURN v_Cursor;
    END ObtenerClientePorID;
END pkg_cliente_ops;

--2. Manejo de Pedidos

CREATE OR REPLACE PACKAGE pkg_pedido_ops AS
    PROCEDURE MostrarPedidos;
    PROCEDURE InsertarPedido(
        p_ClienteID IN NUMBER, 
        p_Fecha IN DATE, 
        p_Hora IN VARCHAR2
    );
    FUNCTION ObtenerPedidoPorID(p_PedidoID IN NUMBER) RETURN SYS_REFCURSOR;
END pkg_pedido_ops;

CREATE OR REPLACE PACKAGE BODY pkg_pedido_ops AS
    PROCEDURE MostrarPedidos IS
        CURSOR cur_Pedidos IS
            SELECT PedidoID, ClienteID, Fecha, Hora FROM Pedido;

        v_PedidoID  Pedido.PedidoID%TYPE;
        v_ClienteID Pedido.ClienteID%TYPE;
        v_Fecha     Pedido.Fecha%TYPE;
        v_Hora      Pedido.Hora%TYPE;
    BEGIN
        OPEN cur_Pedidos;
        LOOP
            FETCH cur_Pedidos INTO v_PedidoID, v_ClienteID, v_Fecha, v_Hora;
            EXIT WHEN cur_Pedidos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_PedidoID || ' | ClienteID: ' || v_ClienteID || ' | Fecha: ' || v_Fecha || ' | Hora: ' || v_Hora);
        END LOOP;
        CLOSE cur_Pedidos;
    END MostrarPedidos;

    PROCEDURE InsertarPedido(p_ClienteID IN NUMBER, p_Fecha IN DATE, p_Hora IN VARCHAR2) IS
    BEGIN
        INSERT INTO Pedido (ClienteID, Fecha, Hora)
        VALUES (p_ClienteID, p_Fecha, p_Hora);
        COMMIT;
    END InsertarPedido;

    FUNCTION ObtenerPedidoPorID(p_PedidoID IN NUMBER) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT ClienteID, Fecha, Hora
            FROM Pedido
            WHERE PedidoID = p_PedidoID;
        RETURN v_Cursor;
    END ObtenerPedidoPorID;
END pkg_pedido_ops;

--3. Manejos de Productos

CREATE OR REPLACE PACKAGE pkg_producto_ops AS
    PROCEDURE MostrarProductos;
    PROCEDURE InsertarProducto(p_Nombre IN VARCHAR2, p_Precio IN NUMBER);
    FUNCTION ObtenerProductoPorID(p_ProductoID IN NUMBER) RETURN SYS_REFCURSOR;
END pkg_producto_ops;

CREATE OR REPLACE PACKAGE BODY pkg_producto_ops AS
    PROCEDURE MostrarProductos IS
        CURSOR cur_Productos IS
            SELECT ProductoID, Nombre, Precio FROM Producto;

        v_ProductoID Producto.ProductoID%TYPE;
        v_Nombre     Producto.Nombre%TYPE;
        v_Precio     Producto.Precio%TYPE;
    BEGIN
        OPEN cur_Productos;
        LOOP
            FETCH cur_Productos INTO v_ProductoID, v_Nombre, v_Precio;
            EXIT WHEN cur_Productos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_ProductoID || ' | Nombre: ' || v_Nombre || ' | Precio: ' || v_Precio);
        END LOOP;
        CLOSE cur_Productos;
    END MostrarProductos;

    PROCEDURE InsertarProducto(p_Nombre IN VARCHAR2, p_Precio IN NUMBER) IS
    BEGIN
        INSERT INTO Producto (Nombre, Precio)
        VALUES (p_Nombre, p_Precio);
        COMMIT;
    END InsertarProducto;

    FUNCTION ObtenerProductoPorID(p_ProductoID IN NUMBER) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT Nombre, Precio
            FROM Producto
            WHERE ProductoID = p_ProductoID;
        RETURN v_Cursor;
    END ObtenerProductoPorID;
END pkg_producto_ops;

--4. Manejo de ingredientes

CREATE OR REPLACE PACKAGE pkg_ingrediente_ops AS
    PROCEDURE MostrarIngredientes;
    PROCEDURE InsertarIngrediente(p_Nombre IN VARCHAR2, p_Precio IN NUMBER);
    FUNCTION ObtenerIngredientePorID(p_IngredienteID IN NUMBER) RETURN SYS_REFCURSOR;
END pkg_ingrediente_ops;

CREATE OR REPLACE PACKAGE BODY pkg_ingrediente_ops AS
    PROCEDURE MostrarIngredientes IS
        CURSOR cur_Ingredientes IS
            SELECT IngredienteID, Nombre, Precio FROM IngredientesExtra;

        v_IngredienteID IngredientesExtra.IngredienteID%TYPE;
        v_Nombre         IngredientesExtra.Nombre%TYPE;
        v_Precio         IngredientesExtra.Precio%TYPE;
    BEGIN
        OPEN cur_Ingredientes;
        LOOP
            FETCH cur_Ingredientes INTO v_IngredienteID, v_Nombre, v_Precio;
            EXIT WHEN cur_Ingredientes%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_IngredienteID || ' | Nombre: ' || v_Nombre || ' | Precio: ' || v_Precio);
        END LOOP;
        CLOSE cur_Ingredientes;
    END MostrarIngredientes;

    PROCEDURE InsertarIngrediente(p_Nombre IN VARCHAR2, p_Precio IN NUMBER) IS
    BEGIN
        INSERT INTO IngredientesExtra (Nombre, Precio)
        VALUES (p_Nombre, p_Precio);
        COMMIT;
    END InsertarIngrediente;

    FUNCTION ObtenerIngredientePorID(p_IngredienteID IN NUMBER) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT Nombre, Precio
            FROM IngredientesExtra
            WHERE IngredienteID = p_IngredienteID;
        RETURN v_Cursor;
    END ObtenerIngredientePorID;
END pkg_ingrediente_ops;

--5. Operaciones de ventas

CREATE OR REPLACE PACKAGE pkg_venta_ops AS
    PROCEDURE MostrarVentas;
    PROCEDURE InsertarVenta(
        p_ClienteID IN Cliente.ClienteID%TYPE,
        p_SucursalID IN Sucursal.SucursalID%TYPE,
        p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE,
        p_PromocionID IN Promocion.PromocionID%TYPE,
        p_TipoVentaID IN TipoVenta.TipoVentaID%TYPE,
        p_Fecha IN Pedido.Fecha%TYPE,
        p_Hora IN Pedido.Hora%TYPE
    );
    FUNCTION ObtenerVentaPorID(
        p_PedidoID IN Pedido.PedidoID%TYPE
    ) RETURN SYS_REFCURSOR;
END pkg_venta_ops;

CREATE OR REPLACE PACKAGE BODY pkg_venta_ops AS
    PROCEDURE MostrarVentas IS
        CURSOR c_ventas IS
            SELECT p.PedidoID, p.ClienteID, p.SucursalID, p.MetodoPagoID, p.PromocionID, p.TipoVentaID, p.Fecha, p.Hora
            FROM Pedido p;
    BEGIN
        FOR r_venta IN c_ventas LOOP
            DBMS_OUTPUT.PUT_LINE('PedidoID: ' || r_venta.PedidoID ||
                                 ', ClienteID: ' || r_venta.ClienteID ||
                                 ', SucursalID: ' || r_venta.SucursalID ||
                                 ', MetodoPagoID: ' || r_venta.MetodoPagoID ||
                                 ', PromocionID: ' || r_venta.PromocionID ||
                                 ', TipoVentaID: ' || r_venta.TipoVentaID ||
                                 ', Fecha: ' || r_venta.Fecha ||
                                 ', Hora: ' || r_venta.Hora);
        END LOOP;
    END MostrarVentas;

    PROCEDURE InsertarVenta(
        p_ClienteID IN Cliente.ClienteID%TYPE,
        p_SucursalID IN Sucursal.SucursalID%TYPE,
        p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE,
        p_PromocionID IN Promocion.PromocionID%TYPE,
        p_TipoVentaID IN TipoVenta.TipoVentaID%TYPE,
        p_Fecha IN Pedido.Fecha%TYPE,
        p_Hora IN Pedido.Hora%TYPE
    ) IS
    BEGIN
        INSERT INTO Pedido (ClienteID, SucursalID, MetodoPagoID, PromocionID, TipoVentaID, Fecha, Hora)
        VALUES (p_ClienteID, p_SucursalID, p_MetodoPagoID, p_PromocionID, p_TipoVentaID, p_Fecha, p_Hora);
        COMMIT;
    END InsertarVenta;

    FUNCTION ObtenerVentaPorID(p_PedidoID IN Pedido.PedidoID%TYPE) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT ClienteID, SucursalID, MetodoPagoID, PromocionID, TipoVentaID, Fecha, Hora
            FROM Pedido
            WHERE PedidoID = p_PedidoID;
        RETURN v_Cursor;
    END ObtenerVentaPorID;
END pkg_venta_ops;

--6. Manejo de Promociones

CREATE OR REPLACE PACKAGE pkg_promocion_ops AS
    PROCEDURE MostrarPromociones;
    PROCEDURE InsertarPromocion(p_Descripcion IN VARCHAR2, p_Descuento IN NUMBER);
    FUNCTION ObtenerPromocionPorID(p_PromocionID IN NUMBER) RETURN SYS_REFCURSOR;
END pkg_promocion_ops;

CREATE OR REPLACE PACKAGE BODY pkg_promocion_ops AS
    PROCEDURE MostrarPromociones IS
        CURSOR cur_Promociones IS
            SELECT PromocionID, Descripcion, Descuento FROM Promocion;

        v_PromocionID   Promocion.PromocionID%TYPE;
        v_Descripcion   Promocion.Descripcion%TYPE;
        v_Descuento     Promocion.Descuento%TYPE;
    BEGIN
        OPEN cur_Promociones;
        LOOP
            FETCH cur_Promociones INTO v_PromocionID, v_Descripcion, v_Descuento;
            EXIT WHEN cur_Promociones%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_PromocionID || ' | Descripción: ' || v_Descripcion || ' | Descuento: ' || v_Descuento);
        END LOOP;
        CLOSE cur_Promociones;
    END MostrarPromociones;

    PROCEDURE InsertarPromocion(p_Descripcion IN VARCHAR2, p_Descuento IN NUMBER) IS
    BEGIN
        INSERT INTO Promocion (Descripcion, Descuento)
        VALUES (p_Descripcion, p_Descuento);
        COMMIT;
    END InsertarPromocion;

    FUNCTION ObtenerPromocionPorID(p_PromocionID IN NUMBER) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT Descripcion, Descuento
            FROM Promocion
            WHERE PromocionID = p_PromocionID;
        RETURN v_Cursor;
    END ObtenerPromocionPorID;
END pkg_promocion_ops;

--7. Detalle de Ventas

CREATE OR REPLACE PACKAGE pkg_detalle_pedido_ops AS
    PROCEDURE MostrarDetallesPedidos(p_PedidoID IN Pedido.PedidoID%TYPE);
    PROCEDURE InsertarDetallePedido(
        p_PedidoID IN Pedido.PedidoID%TYPE,
        p_ProductoID IN Producto.ProductoID%TYPE,
        p_IngredienteExtraID IN IngredientesExtra.IngredienteID%TYPE,
        p_CantidadProductos IN DetallePedido.CantidadProductos%TYPE,
        p_PrecioUnitario IN DetallePedido.PrecioUnitario%TYPE,
        p_PrecioTotal IN DetallePedido.PrecioTotal%TYPE,
        p_PrecioIva IN DetallePedido.PrecioIva%TYPE,
        p_PrecioTotalDescuento IN DetallePedido.PrecioTotalDescuento%TYPE
    );
    FUNCTION ObtenerDetallePorID(p_DetallePedidoID IN DetallePedido.DetallePedidoID%TYPE) RETURN SYS_REFCURSOR;
END pkg_detalle_pedido_ops;

CREATE OR REPLACE PACKAGE BODY pkg_detalle_pedido_ops AS
    PROCEDURE MostrarDetallesPedidos(p_PedidoID IN Pedido.PedidoID%TYPE) IS
        CURSOR c_detalles IS
            SELECT d.DetallePedidoID, d.PedidoID, d.ProductoID, d.IngredienteExtraID, d.CantidadProductos, d.PrecioUnitario,
                   d.PrecioTotal, d.PrecioIva, d.PrecioTotalDescuento
            FROM DetallePedido d
            WHERE d.PedidoID = p_PedidoID;
    BEGIN
        FOR r_detalle IN c_detalles LOOP
            DBMS_OUTPUT.PUT_LINE('DetallePedidoID: ' || r_detalle.DetallePedidoID ||
                                 ', PedidoID: ' || r_detalle.PedidoID ||
                                 ', ProductoID: ' || r_detalle.ProductoID ||
                                 ', IngredienteExtraID: ' || r_detalle.IngredienteExtraID ||
                                 ', CantidadProductos: ' || r_detalle.CantidadProductos ||
                                 ', PrecioUnitario: ' || r_detalle.PrecioUnitario ||
                                 ', PrecioTotal: ' || r_detalle.PrecioTotal ||
                                 ', PrecioIva: ' || r_detalle.PrecioIva ||
                                 ', PrecioTotalDescuento: ' || r_detalle.PrecioTotalDescuento);
        END LOOP;
    END MostrarDetallesPedidos;

    PROCEDURE InsertarDetallePedido(
        p_PedidoID IN Pedido.PedidoID%TYPE,
        p_ProductoID IN Producto.ProductoID%TYPE,
        p_IngredienteExtraID IN IngredientesExtra.IngredienteID%TYPE,
        p_CantidadProductos IN DetallePedido.CantidadProductos%TYPE,
        p_PrecioUnitario IN DetallePedido.PrecioUnitario%TYPE,
        p_PrecioTotal IN DetallePedido.PrecioTotal%TYPE,
        p_PrecioIva IN DetallePedido.PrecioIva%TYPE,
        p_PrecioTotalDescuento IN DetallePedido.PrecioTotalDescuento%TYPE
    ) IS
    BEGIN
        INSERT INTO DetallePedido (
            PedidoID, ProductoID, IngredienteExtraID, CantidadProductos,
            PrecioUnitario, PrecioTotal, PrecioIva, PrecioTotalDescuento
        )
        VALUES (
            p_PedidoID, p_ProductoID, p_IngredienteExtraID, p_CantidadProductos,
            p_PrecioUnitario, p_PrecioTotal, p_PrecioIva, p_PrecioTotalDescuento
        );
        COMMIT;
    END InsertarDetallePedido;

    FUNCTION ObtenerDetallePorID(p_DetallePedidoID IN DetallePedido.DetallePedidoID%TYPE) RETURN SYS_REFCURSOR IS
        r_cursor SYS_REFCURSOR;
    BEGIN
        OPEN r_cursor FOR
            SELECT d.DetallePedidoID, d.PedidoID, d.ProductoID, d.IngredienteExtraID, d.CantidadProductos, d.PrecioUnitario,
                   d.PrecioTotal, d.PrecioIva, d.PrecioTotalDescuento
            FROM DetallePedido d
            WHERE d.DetallePedidoID = p_DetallePedidoID;
        RETURN r_cursor;
    END ObtenerDetallePorID;
END pkg_detalle_pedido_ops;

--8. Manejo de Métodos de Pago

CREATE OR REPLACE PACKAGE pkg_metodo_pago_ops AS
    PROCEDURE MostrarMetodosPago;
    PROCEDURE InsertarMetodoPago(p_TipoPago IN MetodoPago.TipoPago%TYPE);
    FUNCTION ObtenerMetodoPagoPorID(p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE) RETURN SYS_REFCURSOR;
END pkg_metodo_pago_ops;

CREATE OR REPLACE PACKAGE BODY pkg_metodo_pago_ops AS
    PROCEDURE MostrarMetodosPago IS
        CURSOR c_metodos IS
            SELECT MetodoPagoID, TipoPago
            FROM MetodoPago;
    BEGIN
        FOR r_metodo IN c_metodos LOOP
            DBMS_OUTPUT.PUT_LINE('MetodoPagoID: ' || r_metodo.MetodoPagoID ||
                                 ', TipoPago: ' || r_metodo.TipoPago);
        END LOOP;
    END MostrarMetodosPago;

    PROCEDURE InsertarMetodoPago(p_TipoPago IN MetodoPago.TipoPago%TYPE) IS
    BEGIN
        INSERT INTO MetodoPago (TipoPago)
        VALUES (p_TipoPago);
        COMMIT;
    END InsertarMetodoPago;

    FUNCTION ObtenerMetodoPagoPorID(p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE) RETURN SYS_REFCURSOR IS
        r_cursor SYS_REFCURSOR;
    BEGIN
        OPEN r_cursor FOR
            SELECT MetodoPagoID, TipoPago
            FROM MetodoPago
            WHERE MetodoPagoID = p_MetodoPagoID;
        RETURN r_cursor;
    END ObtenerMetodoPagoPorID;
END pkg_metodo_pago_ops;

--9. Reportes

CREATE OR REPLACE PACKAGE pkg_reporte_ops AS
    PROCEDURE GenerarReporte(
        p_Descripcion IN Reportes.Descripcion%TYPE,
        p_FechaGeneracion IN Reportes.FechaGeneracion%TYPE
    );
    FUNCTION ObtenerReportePorID(p_ReporteID IN Reportes.ReporteID%TYPE) RETURN SYS_REFCURSOR;
    PROCEDURE MostrarDetallesReporte(p_ReporteID IN Reportes.ReporteID%TYPE);
END pkg_reporte_ops;

CREATE OR REPLACE PACKAGE BODY pkg_reporte_ops AS
    PROCEDURE GenerarReporte(
        p_Descripcion IN Reportes.Descripcion%TYPE,
        p_FechaGeneracion IN Reportes.FechaGeneracion%TYPE
    ) IS
    BEGIN
        INSERT INTO Reportes (Descripcion, FechaGeneracion)
        VALUES (p_Descripcion, p_FechaGeneracion);
        COMMIT;
    END GenerarReporte;

    FUNCTION ObtenerReportePorID(p_ReporteID IN Reportes.ReporteID%TYPE) RETURN SYS_REFCURSOR IS
        r_cursor SYS_REFCURSOR;
    BEGIN
        OPEN r_cursor FOR
            SELECT ReporteID, Descripcion, FechaGeneracion
            FROM Reportes
            WHERE ReporteID = p_ReporteID;
        RETURN r_cursor;
    END ObtenerReportePorID;

    PROCEDURE MostrarDetallesReporte(p_ReporteID IN Reportes.ReporteID%TYPE) IS
        CURSOR c_detalles IS
            SELECT r.ReporteID, r.Descripcion, r.FechaGeneracion
            FROM Reportes r
            WHERE r.ReporteID = p_ReporteID;
    BEGIN
        FOR r_detalle IN c_detalles LOOP
            DBMS_OUTPUT.PUT_LINE('ReporteID: ' || r_detalle.ReporteID ||
                                 ', Descripción: ' || r_detalle.Descripcion ||
                                 ', FechaGeneración: ' || r_detalle.FechaGeneracion);
        END LOOP;
    END MostrarDetallesReporte;
END pkg_reporte_ops;

--10. Manejo de Sucursales

CREATE OR REPLACE PACKAGE pkg_sucursal_ops AS
    PROCEDURE AgregarSucursal(
        p_Nombre IN Sucursal.Nombre%TYPE,
        p_Direccion IN Sucursal.Direccion%TYPE,
        p_Telefono IN Sucursal.Telefono%TYPE
    );
    PROCEDURE ActualizarSucursal(
        p_SucursalID IN Sucursal.SucursalID%TYPE,
        p_Nombre IN Sucursal.Nombre%TYPE,
        p_Direccion IN Sucursal.Direccion%TYPE,
        p_Telefono IN Sucursal.Telefono%TYPE
    );
    FUNCTION ObtenerSucursalPorID(p_SucursalID IN Sucursal.SucursalID%TYPE) RETURN SYS_REFCURSOR;
    PROCEDURE MostrarDetallesSucursal(p_SucursalID IN Sucursal.SucursalID%TYPE);
END pkg_sucursal_ops;

CREATE OR REPLACE PACKAGE BODY pkg_sucursal_ops AS
    PROCEDURE AgregarSucursal(
        p_Nombre IN Sucursal.Nombre%TYPE,
        p_Direccion IN Sucursal.Direccion%TYPE,
        p_Telefono IN Sucursal.Telefono%TYPE
    ) IS
    BEGIN
        INSERT INTO Sucursal (Nombre, Direccion, Telefono)
        VALUES (p_Nombre, p_Direccion, p_Telefono);
        COMMIT;
    END AgregarSucursal;

    PROCEDURE ActualizarSucursal(
        p_SucursalID IN Sucursal.SucursalID%TYPE,
        p_Nombre IN Sucursal.Nombre%TYPE,
        p_Direccion IN Sucursal.Direccion%TYPE,
        p_Telefono IN Sucursal.Telefono%TYPE
    ) IS
    BEGIN
        UPDATE Sucursal
        SET Nombre = p_Nombre,
            Direccion = p_Direccion,
            Telefono = p_Telefono
        WHERE SucursalID = p_SucursalID;
        COMMIT;
    END ActualizarSucursal;

    FUNCTION ObtenerSucursalPorID(p_SucursalID IN Sucursal.SucursalID%TYPE) RETURN SYS_REFCURSOR IS
        r_cursor SYS_REFCURSOR;
    BEGIN
        OPEN r_cursor FOR
            SELECT SucursalID, Nombre, Direccion, Telefono
            FROM Sucursal
            WHERE SucursalID = p_SucursalID;
        RETURN r_cursor;
    END ObtenerSucursalPorID;

    PROCEDURE MostrarDetallesSucursal(p_SucursalID IN Sucursal.SucursalID%TYPE) IS
        CURSOR c_detalles IS
            SELECT s.SucursalID, s.Nombre, s.Direccion, s.Telefono
            FROM Sucursal s
            WHERE s.SucursalID = p_SucursalID;
        v_SucursalID Sucursal.SucursalID%TYPE;
        v_Nombre Sucursal.Nombre%TYPE;
        v_Direccion Sucursal.Direccion%TYPE;
        v_Telefono Sucursal.Telefono%TYPE;
    BEGIN
        OPEN c_detalles;
        LOOP
            FETCH c_detalles INTO v_SucursalID, v_Nombre, v_Direccion, v_Telefono;
            EXIT WHEN c_detalles%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('SucursalID: ' || v_SucursalID ||
                                 ', Nombre: ' || v_Nombre ||
                                 ', Dirección: ' || v_Direccion ||
                                 ', Teléfono: ' || v_Telefono);
        END LOOP;
        CLOSE c_detalles;
    END MostrarDetallesSucursal;
END pkg_sucursal_ops;