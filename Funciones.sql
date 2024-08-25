--Funciones
--1. Calcular el total de un pedido con IVA
CREATE OR REPLACE FUNCTION CalcularTotalPedidoConIVA (
    p_PedidoID INT
) RETURN DECIMAL IS
    v_Total DECIMAL(10, 2);
BEGIN
    SELECT SUM(PrecioTotal) INTO v_Total
    FROM DetallePedido
    WHERE PedidoID = p_PedidoID;

    RETURN v_Total * 0.13; 
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--2. Calcular el total de un pedido con descuento
CREATE OR REPLACE FUNCTION CalcularTotalPedidoConDescuento (
    p_PedidoID INT
) RETURN DECIMAL IS
    v_Total DECIMAL(10, 2);
BEGIN
    SELECT SUM(PrecioTotalDescuento) INTO v_Total
    FROM DetallePedido
    WHERE PedidoID = p_PedidoID;

    RETURN v_Total;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--3. Para obtener el nombre completo de un cliente
CREATE OR REPLACE FUNCTION ObtenerNombreCompletoCliente (
    p_ClienteID INT
) RETURN VARCHAR IS
    v_NombreCompleto VARCHAR(200);
BEGIN
    SELECT Nombre || ' ' || Apellidos INTO v_NombreCompleto
    FROM Cliente
    WHERE ClienteID = p_ClienteID;

    RETURN v_NombreCompleto;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--4. Para obtener el nombre completo de un empleado
CREATE OR REPLACE FUNCTION ObtenerNombreCompletoEmpleado (
    p_EmpleadoID INT
) RETURN VARCHAR IS
    v_NombreCompleto VARCHAR(200);
BEGIN
    SELECT Nombre || ' ' || Apellidos INTO v_NombreCompleto
    FROM Empleado
    WHERE EmpleadoID = p_EmpleadoID;

    RETURN v_NombreCompleto;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--5. Para calcular el total de gasto de un cliente
CREATE OR REPLACE FUNCTION CalcularTotalGastoCliente (
    p_ClienteID INT
) RETURN DECIMAL IS
    v_TotalGasto DECIMAL(10, 2);
BEGIN
    SELECT SUM(PrecioTotal) INTO v_TotalGasto
    FROM Pedido P
    JOIN DetallePedido DC ON P.PedidoID = DC.PedidoID
    WHERE P.ClienteID = p_ClienteID;

    RETURN v_TotalGasto;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--6. Obtener el numero de pedidos de un cliente
CREATE OR REPLACE FUNCTION ObtenerNumeroPedidosCliente (
    p_ClienteID INT
) RETURN INT IS
    v_NumeroPedidos INT;
BEGIN
    SELECT COUNT(*) INTO v_NumeroPedidos
    FROM Pedido
    WHERE ClienteID = p_ClienteID;

    RETURN v_NumeroPedidos;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--7. Obtener el nombre de una sucursal
CREATE OR REPLACE FUNCTION ObtenerNombreSucursal (
    p_SucursalID INT
) RETURN VARCHAR IS
    v_NombreSucursal VARCHAR(100);
BEGIN
    SELECT Nombre INTO v_NombreSucursal
    FROM Sucursal
    WHERE SucursalID = p_SucursalID;

    RETURN v_NombreSucursal;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--8. Calcular el total de un reporte
CREATE OR REPLACE FUNCTION CalcularTotalReporte (
    p_ReporteID INT
) RETURN DECIMAL IS
    v_Total DECIMAL(10, 2);
BEGIN
    SELECT SUM(TotalGasto) INTO v_Total
    FROM DetalleReporte
    WHERE ReporteID = p_ReporteID;

    RETURN v_Total;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--9. Obtener el tipo de pago de un pedido
CREATE OR REPLACE FUNCTION ObtenerTipoPagoPedido (
    p_PedidoID INT
) RETURN VARCHAR IS
    v_TipoPago VARCHAR(50);
BEGIN
    SELECT MP.TipoPago INTO v_TipoPago
    FROM Pedido P
    JOIN MetodoPago MP ON P.MetodoPagoID = MP.MetodoPagoID
    WHERE P.PedidoID = p_PedidoID;

    RETURN v_TipoPago;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--10. Obtener la descripcion de un producto
CREATE OR REPLACE FUNCTION ObtenerDescripcionProducto (
    p_ProductoID INT
) RETURN VARCHAR IS
    v_DescripcionProducto VARCHAR(255);
BEGIN
    SELECT Descripcion INTO v_DescripcionProducto
    FROM Producto
    WHERE ProductoID = p_ProductoID;

    RETURN v_DescripcionProducto;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--11. Obtener la cantidad de productos en un pedido
CREATE OR REPLACE FUNCTION ObtenerCantidadProductosPedido (
    p_PedidoID INT
) RETURN INT IS
    v_CantidadProductos INT;
BEGIN
    SELECT SUM(CantidadProductos) INTO v_CantidadProductos
    FROM DetallePedido
    WHERE PedidoID = p_PedidoID;

    RETURN v_CantidadProductos;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--12. Obtener el descuento aplicado a un pedido
CREATE OR REPLACE FUNCTION ObtenerDescuentoPedido (
    p_PedidoID INT
) RETURN DECIMAL IS
    v_Descuento DECIMAL(5, 2);
BEGIN
    SELECT P.Descuento INTO v_Descuento
    FROM Pedido PD
    JOIN Promocion P ON PD.PromocionID = P.PromocionID
    WHERE PD.PedidoID = p_PedidoID;

    RETURN v_Descuento;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--13. Obtener el precio unitario de un producto
CREATE OR REPLACE FUNCTION ObtenerPrecioUnitarioProducto (
    p_ProductoID INT
) RETURN DECIMAL IS
    v_PrecioUnitario DECIMAL(10, 2);
BEGIN
    SELECT Precio INTO v_PrecioUnitario
    FROM Producto
    WHERE ProductoID = p_ProductoID;

    RETURN v_PrecioUnitario;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--14. Obtener el nombre de un producto
CREATE OR REPLACE FUNCTION ObtenerNombreProducto (p_ProductoID INT) RETURN VARCHAR IS
    v_NombreProducto VARCHAR(100);
BEGIN
    SELECT Nombre INTO v_NombreProducto
    FROM Producto
    WHERE ProductoID = p_ProductoID;

    RETURN v_NombreProducto;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--15. Calcular el IVA de un pedido
CREATE OR REPLACE FUNCTION CalcularIVAPedido (p_PedidoID INT) RETURN DECIMAL IS
    v_Total DECIMAL(10, 2);
    v_IVA DECIMAL(10, 2);
BEGIN
    SELECT SUM(PrecioTotal) INTO v_Total
    FROM DetallePedido
    WHERE PedidoID = p_PedidoID;

    v_IVA := v_Total * 0.13;

    RETURN v_IVA;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--16. Obtener la dirrecion de un cliente
CREATE OR REPLACE FUNCTION ObtenerDireccionCliente (p_ClienteID INT) RETURN VARCHAR IS
    v_Direccion VARCHAR(255);
BEGIN
    SELECT Direccion INTO v_Direccion
    FROM Cliente
    WHERE ClienteID = p_ClienteID;

    RETURN v_Direccion;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--17. Obtener la frecuencia de pedidos de un cliente
CREATE OR REPLACE FUNCTION ObtenerFrecuenciaPedidosCliente (p_ClienteID INT) RETURN INT IS
    v_Frecuencia INT;
BEGIN
    SELECT COUNT(*) INTO v_Frecuencia
    FROM Pedido
    WHERE ClienteID = p_ClienteID;

    RETURN v_Frecuencia;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--18. Obtener la descripcion de la promocion aplicada a un pedido
CREATE OR REPLACE FUNCTION ObtenerPromocionAplicada (p_PedidoID INT) RETURN VARCHAR IS
    v_DescripcionPromocion VARCHAR(255);
BEGIN
    SELECT P.Descripcion INTO v_DescripcionPromocion
    FROM Pedido PD
    JOIN Promocion P ON PD.PromocionID = P.PromocionID
    WHERE PD.PedidoID = p_PedidoID;

    RETURN v_DescripcionPromocion;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--19. Obtener el metodo de retiro de un pedido
CREATE OR REPLACE FUNCTION ObtenerMetodoRetiroPedido (p_PedidoID INT) RETURN VARCHAR IS
    v_MetodoRetiro VARCHAR(50);
BEGIN
    SELECT TV.MetodoRetiro INTO v_MetodoRetiro
    FROM Pedido P
    JOIN TipoVenta TV ON P.TipoVentaID = TV.TipoVentaID
    WHERE P.PedidoID = p_PedidoID;

    RETURN v_MetodoRetiro;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--20. Obtener la descripcion de un ingrediente extra
CREATE OR REPLACE FUNCTION ObtenerDescripcionIngredienteExtra (p_IngredienteID INT) RETURN VARCHAR IS
    v_DescripcionIngrediente VARCHAR(255);
BEGIN
    SELECT Descripcion INTO v_DescripcionIngrediente
    FROM IngredientesExtra
    WHERE IngredienteID = p_IngredienteID;

    RETURN v_DescripcionIngrediente;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--21. Calcular el total de IVA para los reportes generados
CREATE OR REPLACE FUNCTION CalcularTotalIVAReportes (p_ReporteID INT) RETURN DECIMAL IS
    v_TotalIVA DECIMAL(10, 2);
BEGIN
    SELECT SUM(TotalGasto * 0.13) INTO v_TotalIVA
    FROM DetalleReporte
    WHERE ReporteID = p_ReporteID;

    RETURN v_TotalIVA;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--22. Obtener el email de un cliente
CREATE OR REPLACE FUNCTION ObtenerEmailCliente (p_ClienteID INT) RETURN VARCHAR IS
    v_Email VARCHAR(255);
BEGIN
    SELECT Email INTO v_Email
    FROM Cliente
    WHERE ClienteID = p_ClienteID;

    RETURN v_Email;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--23. Obtener el precio de un ingrediente extra
CREATE OR REPLACE FUNCTION ObtenerPrecioIngredienteExtra (p_IngredienteID INT) RETURN DECIMAL IS
    v_Precio DECIMAL(10, 2);
BEGIN
    SELECT Precio INTO v_Precio
    FROM IngredientesExtra
    WHERE IngredienteID = p_IngredienteID;

    RETURN v_Precio;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--24. Obtener el nombre del tipo de producto
CREATE OR REPLACE FUNCTION ObtenerNombreTipoProducto (p_TipoProductoID INT) RETURN VARCHAR IS
    v_NombreTipoProducto VARCHAR(100);
BEGIN
    SELECT Descripcion INTO v_NombreTipoProducto
    FROM TipoProducto
    WHERE TipoProductoID = p_TipoProductoID;

    RETURN v_NombreTipoProducto;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

--25. Obtener el tamaño del tipo de producto
CREATE OR REPLACE FUNCTION ObtenerTamanoTipoProducto (p_TipoProductoID INT) RETURN VARCHAR IS
    v_Tamano VARCHAR(50);
BEGIN
    SELECT Tamano INTO v_Tamano
    FROM TipoProducto
    WHERE TipoProductoID = p_TipoProductoID;

    RETURN v_Tamano;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;
