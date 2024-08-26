--Cursores

--1. Clientes con Pedidos

CREATE OR REPLACE PROCEDURE MostrarClientesConPedidos IS
    CURSOR cur_ClientesConPedidos IS
        SELECT c.ClienteID, c.Nombre, c.Apellidos, p.PedidoID, p.Fecha, p.Hora
        FROM Cliente c
        JOIN Pedido p ON c.ClienteID = p.ClienteID;

    v_ClienteID    Cliente.ClienteID%TYPE;
    v_Nombre       Cliente.Nombre%TYPE;
    v_Apellidos    Cliente.Apellidos%TYPE;
    v_PedidoID     Pedido.PedidoID%TYPE;
    v_Fecha        Pedido.Fecha%TYPE;
    v_Hora         Pedido.Hora%TYPE;
BEGIN
    OPEN cur_ClientesConPedidos;
    LOOP
        FETCH cur_ClientesConPedidos INTO v_ClienteID, v_Nombre, v_Apellidos, v_PedidoID, v_Fecha, v_Hora;
        EXIT WHEN cur_ClientesConPedidos%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_Nombre || ' ' || v_Apellidos || ' | Pedido ID: ' || v_PedidoID || ' | Fecha: ' || v_Fecha || ' | Hora: ' || v_Hora);
    END LOOP;
    CLOSE cur_ClientesConPedidos;
END;

--2. Productos con Ingredientes Extra

CREATE OR REPLACE PROCEDURE MostrarProductosConIngredientes IS
    CURSOR cur_ProductosConIngredientes IS
        SELECT p.ProductoID, p.Nombre AS Producto, i.IngredienteID, i.Nombre AS Ingrediente, i.Precio
        FROM Producto p
        JOIN IngredientesExtra i ON p.ProductoID = i.ProductoID;

    v_ProductoID      Producto.ProductoID%TYPE;
    v_Producto        Producto.Nombre%TYPE;
    v_IngredienteID   IngredientesExtra.IngredienteID%TYPE;
    v_Ingrediente     IngredientesExtra.Nombre%TYPE;
    v_Precio          IngredientesExtra.Precio%TYPE;
BEGIN
    OPEN cur_ProductosConIngredientes;
    LOOP
        FETCH cur_ProductosConIngredientes INTO v_ProductoID, v_Producto, v_IngredienteID, v_Ingrediente, v_Precio;
        EXIT WHEN cur_ProductosConIngredientes%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Producto: ' || v_Producto || ' | Ingrediente: ' || v_Ingrediente || ' | Precio: ' || v_Precio);
    END LOOP;
    CLOSE cur_ProductosConIngredientes;
END;

--3. Ventas por Producto

CREATE OR REPLACE PROCEDURE MostrarVentasPorProducto IS
    CURSOR cur_VentasPorProducto IS
        SELECT p.ProductoID, p.Nombre AS Producto, v.CantidadVendida, v.TotalVendido
        FROM VentasPorProducto v
        JOIN Producto p ON v.ProductoID = p.ProductoID;

    v_ProductoID      Producto.ProductoID%TYPE;
    v_Producto        Producto.Nombre%TYPE;
    v_CantidadVendida NUMBER;
    v_TotalVendido    NUMBER;
BEGIN
    OPEN cur_VentasPorProducto;
    LOOP
        FETCH cur_VentasPorProducto INTO v_ProductoID, v_Producto, v_CantidadVendida, v_TotalVendido;
        EXIT WHEN cur_VentasPorProducto%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Producto: ' || v_Producto || ' | Cantidad Vendida: ' || v_CantidadVendida || ' | Total Vendido: ' || v_TotalVendido);
    END LOOP;
    CLOSE cur_VentasPorProducto;
END;

--4. Pedidos por Sucursal

CREATE OR REPLACE PROCEDURE MostrarPedidosPorSucursal IS
    CURSOR cur_PedidosPorSucursal IS
        SELECT s.SucursalID, s.Nombre AS Sucursal, p.PedidoID, p.Fecha, p.Hora
        FROM Sucursal s
        JOIN Pedido p ON s.SucursalID = p.SucursalID;

    v_SucursalID   Sucursal.SucursalID%TYPE;
    v_Sucursal     Sucursal.Nombre%TYPE;
    v_PedidoID     Pedido.PedidoID%TYPE;
    v_Fecha        Pedido.Fecha%TYPE;
    v_Hora         Pedido.Hora%TYPE;
BEGIN
    OPEN cur_PedidosPorSucursal;
    LOOP
        FETCH cur_PedidosPorSucursal INTO v_SucursalID, v_Sucursal, v_PedidoID, v_Fecha, v_Hora;
        EXIT WHEN cur_PedidosPorSucursal%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Sucursal: ' || v_Sucursal || ' | Pedido ID: ' || v_PedidoID || ' | Fecha: ' || v_Fecha || ' | Hora: ' || v_Hora);
    END LOOP;
    CLOSE cur_PedidosPorSucursal;
END;

--5. Empleados por Sucursal

CREATE OR REPLACE PROCEDURE MostrarEmpleadosPorSucursal IS
    CURSOR cur_EmpleadosPorSucursal IS
        SELECT s.SucursalID, s.Nombre AS Sucursal, e.EmpleadoID, e.Nombre, e.Apellidos, e.Puesto
        FROM Sucursal s
        JOIN Empleado e ON s.SucursalID = e.SucursalID;

    v_SucursalID   Sucursal.SucursalID%TYPE;
    v_Sucursal     Sucursal.Nombre%TYPE;
    v_EmpleadoID   Empleado.EmpleadoID%TYPE;
    v_Nombre       Empleado.Nombre%TYPE;
    v_Apellidos    Empleado.Apellidos%TYPE;
    v_Puesto       Empleado.Puesto%TYPE;
BEGIN
    OPEN cur_EmpleadosPorSucursal;
    LOOP
        FETCH cur_EmpleadosPorSucursal INTO v_SucursalID, v_Sucursal, v_EmpleadoID, v_Nombre, v_Apellidos, v_Puesto;
        EXIT WHEN cur_EmpleadosPorSucursal%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Sucursal: ' || v_Sucursal || ' | Empleado: ' || v_Nombre || ' ' || v_Apellidos || ' | Puesto: ' || v_Puesto);
    END LOOP;
    CLOSE cur_EmpleadosPorSucursal;
END;

--6. Pedidos por Cliente y Sucursal

CREATE OR REPLACE PROCEDURE MostrarPedidosPorClienteYSucursal IS
    CURSOR cur_PedidosPorClienteYSucursal IS
        SELECT c.ClienteID, c.Nombre AS Cliente, s.SucursalID, s.Nombre AS Sucursal, p.PedidoID, p.Fecha, p.Hora
        FROM Cliente c
        JOIN Pedido p ON c.ClienteID = p.ClienteID
        JOIN Sucursal s ON p.SucursalID = s.SucursalID;

    v_ClienteID    Cliente.ClienteID%TYPE;
    v_Cliente      Cliente.Nombre%TYPE;
    v_SucursalID   Sucursal.SucursalID%TYPE;
    v_Sucursal     Sucursal.Nombre%TYPE;
    v_PedidoID     Pedido.PedidoID%TYPE;
    v_Fecha        Pedido.Fecha%TYPE;
    v_Hora         Pedido.Hora%TYPE;
BEGIN
    OPEN cur_PedidosPorClienteYSucursal;
    LOOP
        FETCH cur_PedidosPorClienteYSucursal INTO v_ClienteID, v_Cliente, v_SucursalID, v_Sucursal, v_PedidoID, v_Fecha, v_Hora;
        EXIT WHEN cur_PedidosPorClienteYSucursal%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_Cliente || ' | Sucursal: ' || v_Sucursal || ' | Pedido ID: ' || v_PedidoID || ' | Fecha: ' || v_Fecha || ' | Hora: ' || v_Hora);
    END LOOP;
    CLOSE cur_PedidosPorClienteYSucursal;
END;

--7. Promociones Activas

CREATE OR REPLACE PROCEDURE MostrarPromocionesActivas IS
    CURSOR cur_PromocionesActivas IS
        SELECT p.PromocionID, p.Descripcion, COUNT(pd.PedidoID) AS CantidadAplicada, SUM(dc.PrecioTotalDescuento) AS TotalDescuentoAplicado
        FROM Promocion p
        JOIN Pedido pd ON p.PromocionID = pd.PromocionID
        JOIN DetallePedido dc ON pd.PedidoID = dc.PedidoID
        GROUP BY p.PromocionID, p.Descripcion;

    v_PromocionID              Promocion.PromocionID%TYPE;
    v_Descripcion              Promocion.Descripcion%TYPE;
    v_CantidadAplicada         NUMBER;
    v_TotalDescuentoAplicado   NUMBER;
BEGIN
    OPEN cur_PromocionesActivas;
    LOOP
        FETCH cur_PromocionesActivas INTO v_PromocionID, v_Descripcion, v_CantidadAplicada, v_TotalDescuentoAplicado;
        EXIT WHEN cur_PromocionesActivas%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Promoción ID: ' || v_PromocionID || ' | Descripción: ' || v_Descripcion || ' | Cantidad Aplicada: ' || v_CantidadAplicada || ' | Total Descuento Aplicado: ' || v_TotalDescuentoAplicado);
    END LOOP;
    CLOSE cur_PromocionesActivas;
END;

--8. Clientes con Pedidos y Total Gastado

CREATE OR REPLACE PROCEDURE MostrarClientesConTotalGastado IS
    CURSOR cur_ClientesConTotalGastado IS
        SELECT c.ClienteID, c.Nombre, c.Apellidos, COUNT(p.PedidoID) AS CantidadPedidos, SUM(dc.PrecioTotal) AS TotalGastado
        FROM Cliente c
        JOIN Pedido p ON c.ClienteID = p.ClienteID
        JOIN DetallePedido dc ON p.PedidoID = dc.PedidoID
        GROUP BY c.ClienteID, c.Nombre, c.Apellidos;

    v_ClienteID    Cliente.ClienteID%TYPE;
    v_Nombre       Cliente.Nombre%TYPE;
    v_Apellidos    Cliente.Apellidos%TYPE;
    v_CantidadPedidos NUMBER;
    v_TotalGastado  NUMBER;
BEGIN
    OPEN cur_ClientesConTotalGastado;
    LOOP
        FETCH cur_ClientesConTotalGastado INTO v_ClienteID, v_Nombre, v_Apellidos, v_CantidadPedidos, v_TotalGastado;
        EXIT WHEN cur_ClientesConTotalGastado%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_Nombre || ' ' || v_Apellidos || ' | Cantidad Pedidos: ' || v_CantidadPedidos || ' | Total Gastado: ' || v_TotalGastado);
    END LOOP;
    CLOSE cur_ClientesConTotalGastado;
END;

--9. Productos con Ingredientes Extra y Precio Total

CREATE OR REPLACE PROCEDURE MostrarProductosConIngredientesExtraYPrecioTotal IS
    CURSOR cur_ProductosConPrecioTotal IS
        SELECT p.ProductoID, p.Nombre AS Producto, SUM(i.Precio) AS PrecioTotal
        FROM Producto p
        JOIN IngredientesExtra i ON p.ProductoID = i.ProductoID
        GROUP BY p.ProductoID, p.Nombre;

    v_ProductoID      Producto.ProductoID%TYPE;
    v_Producto        Producto.Nombre%TYPE;
    v_PrecioTotal     NUMBER;
BEGIN
    OPEN cur_ProductosConPrecioTotal;
    LOOP
        FETCH cur_ProductosConPrecioTotal INTO v_ProductoID, v_Producto, v_PrecioTotal;
        EXIT WHEN cur_ProductosConPrecioTotal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Producto: ' || v_Producto || ' | Precio Total Ingredientes: ' || v_PrecioTotal);
    END LOOP;
    CLOSE cur_ProductosConPrecioTotal;
END;

--10. Ventas por Sucursal y Producto

CREATE OR REPLACE PROCEDURE MostrarVentasPorSucursalYProducto IS
    CURSOR cur_VentasPorSucursalYProducto IS
        SELECT s.SucursalID, s.Nombre AS Sucursal, p.ProductoID, p.Nombre AS Producto, SUM(dc.CantidadProductos) AS CantidadVendida, SUM(dc.PrecioTotal) AS TotalVendido
        FROM Sucursal s
        JOIN Pedido pd ON s.SucursalID = pd.SucursalID
        JOIN DetallePedido dc ON pd.PedidoID = dc.PedidoID
        JOIN Producto p ON dc.ProductoID = p.ProductoID
        GROUP BY s.SucursalID, s.Nombre, p.ProductoID, p.Nombre;

    v_SucursalID   Sucursal.SucursalID%TYPE;
    v_Sucursal     Sucursal.Nombre%TYPE;
    v_ProductoID   Producto.ProductoID%TYPE;
    v_Producto     Producto.Nombre%TYPE;
    v_CantidadVendida NUMBER;
    v_TotalVendido    NUMBER;
BEGIN
    OPEN cur_VentasPorSucursalYProducto;
    LOOP
        FETCH cur_VentasPorSucursalYProducto INTO v_SucursalID, v_Sucursal, v_ProductoID, v_Producto, v_CantidadVendida, v_TotalVendido;
        EXIT WHEN cur_VentasPorSucursalYProducto%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Sucursal: ' || v_Sucursal || ' | Producto: ' || v_Producto || ' | Cantidad Vendida: ' || v_CantidadVendida || ' | Total Vendido: ' || v_TotalVendido);
    END LOOP;
    CLOSE cur_VentasPorSucursalYProducto;
END;

--11. Ventas por Fecha

CREATE OR REPLACE PROCEDURE MostrarVentasPorFecha IS
    CURSOR cur_VentasPorFecha IS
        SELECT p.Fecha, COUNT(p.PedidoID) AS TotalPedidos, SUM(dc.PrecioTotal) AS TotalVentas
        FROM Pedido p
        JOIN DetallePedido dc ON p.PedidoID = dc.PedidoID
        GROUP BY p.Fecha
        ORDER BY p.Fecha;

    v_Fecha         Pedido.Fecha%TYPE;
    v_TotalPedidos  NUMBER;
    v_TotalVentas   NUMBER;
BEGIN
    OPEN cur_VentasPorFecha;
    LOOP
        FETCH cur_VentasPorFecha INTO v_Fecha, v_TotalPedidos, v_TotalVentas;
        EXIT WHEN cur_VentasPorFecha%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Fecha: ' || v_Fecha || ' | Total Pedidos: ' || v_TotalPedidos || ' | Total Ventas: ' || v_TotalVentas);
    END LOOP;
    CLOSE cur_VentasPorFecha;
END;

--12. Ingredientes Extra por Pedido y Cantidad

CREATE OR REPLACE PROCEDURE MostrarIngredientesExtraPorPedido IS
    CURSOR cur_IngredientesExtraPorPedido IS
        SELECT p.PedidoID, i.Nombre AS Ingrediente, SUM(dc.CantidadProductos) AS Cantidad
        FROM Pedido p
        JOIN DetallePedido dc ON p.PedidoID = dc.PedidoID
        JOIN IngredientesExtra i ON dc.IngredienteExtraID = i.IngredienteID
        GROUP BY p.PedidoID, i.Nombre;

    v_PedidoID    Pedido.PedidoID%TYPE;
    v_Ingrediente IngredientesExtra.Nombre%TYPE;
    v_Cantidad    NUMBER;
BEGIN
    OPEN cur_IngredientesExtraPorPedido;
    LOOP
        FETCH cur_IngredientesExtraPorPedido INTO v_PedidoID, v_Ingrediente, v_Cantidad;
        EXIT WHEN cur_IngredientesExtraPorPedido%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Pedido ID: ' || v_PedidoID || ' | Ingrediente: ' || v_Ingrediente || ' | Cantidad: ' || v_Cantidad);
    END LOOP;
    CLOSE cur_IngredientesExtraPorPedido;
END;

--13. Productos con Mayor Precio Total en Pedidos

CREATE OR REPLACE PROCEDURE MostrarProductosMayorPrecioTotal IS
    CURSOR cur_ProductosMayorPrecioTotal IS
        SELECT p.ProductoID, p.Nombre AS Producto, SUM(dc.PrecioTotal) AS TotalPrecio
        FROM Producto p
        JOIN DetallePedido dc ON p.ProductoID = dc.ProductoID
        GROUP BY p.ProductoID, p.Nombre
        ORDER BY TotalPrecio DESC;

    v_ProductoID      Producto.ProductoID%TYPE;
    v_Producto        Producto.Nombre%TYPE;
    v_TotalPrecio     NUMBER;
BEGIN
    OPEN cur_ProductosMayorPrecioTotal;
    LOOP
        FETCH cur_ProductosMayorPrecioTotal INTO v_ProductoID, v_Producto, v_TotalPrecio;
        EXIT WHEN cur_ProductosMayorPrecioTotal%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Producto: ' || v_Producto || ' | Total Precio: ' || v_TotalPrecio);
    END LOOP;
    CLOSE cur_ProductosMayorPrecioTotal;
END;

--14. Cantidad Total de Productos por Sucursal

CREATE OR REPLACE PROCEDURE MostrarCantidadTotalProductosPorSucursal IS
    CURSOR cur_CantidadTotalProductosPorSucursal IS
        SELECT s.SucursalID, s.Nombre AS Sucursal, COUNT(dc.ProductoID) AS CantidadProductos
        FROM Sucursal s
        JOIN Pedido p ON s.SucursalID = p.SucursalID
        JOIN DetallePedido dc ON p.PedidoID = dc.PedidoID
        GROUP BY s.SucursalID, s.Nombre;

    v_SucursalID   Sucursal.SucursalID%TYPE;
    v_Sucursal     Sucursal.Nombre%TYPE;
    v_CantidadProductos NUMBER;
BEGIN
    OPEN cur_CantidadTotalProductosPorSucursal;
    LOOP
        FETCH cur_CantidadTotalProductosPorSucursal INTO v_SucursalID, v_Sucursal, v_CantidadProductos;
        EXIT WHEN cur_CantidadTotalProductosPorSucursal%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Sucursal: ' || v_Sucursal || ' | Cantidad Total de Productos: ' || v_CantidadProductos);
    END LOOP;
    CLOSE cur_CantidadTotalProductosPorSucursal;
END;

--15. Detalles de Ventas por Producto

CREATE OR REPLACE PROCEDURE MostrarDetallesVentasPorProducto IS
    CURSOR cur_VentasPorProducto IS
        SELECT pci.Producto AS ProductoNombre, vp.CantidadVendida
        FROM VentasPorProducto vp
        JOIN ProductosConIngredientes pci ON vp.ProductoID = pci.ProductoID;

    v_ProductoNombre ProductosConIngredientes.Producto%TYPE;
    v_CantidadVendida NUMBER;
BEGIN
    OPEN cur_VentasPorProducto;
    LOOP
        FETCH cur_VentasPorProducto INTO v_ProductoNombre, v_CantidadVendida;
        EXIT WHEN cur_VentasPorProducto%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Producto: ' || v_ProductoNombre || ' | Cantidad Vendida: ' || v_CantidadVendida);
    END LOOP;
    CLOSE cur_VentasPorProducto;
END;

