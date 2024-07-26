SET SERVEROUTPUT ON

---------------------------------------------------------------------
/*CRUD DE LA TABLA SUCURSAL*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearSucursal(
    p_SucursalID IN Sucursal.SucursalID%TYPE,
    p_Nombre IN Sucursal.Nombre%TYPE,
    p_Direccion IN Sucursal.Direccion%TYPE,
    p_Telefono IN Sucursal.Telefono%TYPE
)
IS
BEGIN
    INSERT INTO Sucursal (SucursalID, Nombre, Direccion, Telefono)
    VALUES (p_SucursalID, p_Nombre, p_Direccion, p_Telefono);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerSucursalPorID(
    p_SucursalID IN Sucursal.SucursalID%TYPE
)
IS
    v_Nombre Sucursal.Nombre%TYPE;
    v_Direccion Sucursal.Direccion%TYPE;
    v_Telefono Sucursal.Telefono%TYPE;
BEGIN
    SELECT Nombre, Direccion, Telefono INTO v_Nombre, v_Direccion, v_Telefono
    FROM Sucursal
    WHERE SucursalID = p_SucursalID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Direccion: ' || v_Direccion || ', Telefono: ' || v_Telefono);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No sucursal found with SucursalID: ' || p_SucursalID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarSucursal(
    p_SucursalID IN Sucursal.SucursalID%TYPE,
    p_Nombre IN Sucursal.Nombre%TYPE,
    p_Direccion IN Sucursal.Direccion%TYPE,
    p_Telefono IN Sucursal.Telefono%TYPE
)
IS
BEGIN
    UPDATE Sucursal
    SET Nombre = p_Nombre,
        Direccion = p_Direccion,
        Telefono = p_Telefono
    WHERE SucursalID = p_SucursalID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No sucursal found with SucursalID: ' || p_SucursalID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sucursal updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarSucursal(
    p_SucursalID IN Sucursal.SucursalID%TYPE
)
IS
BEGIN
    DELETE FROM Sucursal WHERE SucursalID = p_SucursalID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No sucursal found with SucursalID: ' || p_SucursalID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sucursal deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


---------------------------------------------------------------------

/*CRUD DE LA TABLA EMPLEADO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearEmpleado(
    p_EmpleadoID IN Empleado.EmpleadoID%TYPE,
    p_Nombre IN Empleado.Nombre%TYPE,
    p_Apellidos IN Empleado.Apellidos%TYPE,
    p_SucursalID IN Empleado.SucursalID%TYPE,
    p_Puesto IN Empleado.Puesto%TYPE,
    p_Telefono IN Empleado.Telefono%TYPE
)
IS
BEGIN
    INSERT INTO Empleado (EmpleadoID, Nombre, Apellidos, SucursalID, Puesto, Telefono)
    VALUES (p_EmpleadoID, p_Nombre, p_Apellidos, p_SucursalID, p_Puesto, p_Telefono);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerEmpleadoPorID(
    p_EmpleadoID IN Empleado.EmpleadoID%TYPE
)
IS
    v_Nombre Empleado.Nombre%TYPE;
    v_Apellidos Empleado.Apellidos%TYPE;
    v_SucursalID Empleado.SucursalID%TYPE;
    v_Puesto Empleado.Puesto%TYPE;
    v_Telefono Empleado.Telefono%TYPE;
BEGIN
    SELECT Nombre, Apellidos, SucursalID, Puesto, Telefono INTO v_Nombre, v_Apellidos, v_SucursalID, v_Puesto, v_Telefono
    FROM Empleado
    WHERE EmpleadoID = p_EmpleadoID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Apellidos: ' || v_Apellidos || ', SucursalID: ' || v_SucursalID || ', Puesto: ' || v_Puesto || ', Telefono: ' || v_Telefono);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No empleado found with EmpleadoID: ' || p_EmpleadoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarEmpleado(
    p_EmpleadoID IN Empleado.EmpleadoID%TYPE,
    p_Nombre IN Empleado.Nombre%TYPE,
    p_Apellidos IN Empleado.Apellidos%TYPE,
    p_SucursalID IN Empleado.SucursalID%TYPE,
    p_Puesto IN Empleado.Puesto%TYPE,
    p_Telefono IN Empleado.Telefono%TYPE
)
IS
BEGIN
    UPDATE Empleado
    SET Nombre = p_Nombre,
        Apellidos = p_Apellidos,
        SucursalID = p_SucursalID,
        Puesto = p_Puesto,
        Telefono = p_Telefono
    WHERE EmpleadoID = p_EmpleadoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No empleado found with EmpleadoID: ' || p_EmpleadoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Empleado updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarEmpleado(
    p_EmpleadoID IN Empleado.EmpleadoID%TYPE
)
IS
BEGIN
    DELETE FROM Empleado WHERE EmpleadoID = p_EmpleadoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No empleado found with EmpleadoID: ' || p_EmpleadoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Empleado deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


---------------------------------------------------------------------

/*CRUD DE LA TABLA CLIENTE*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearCliente(
    p_ClienteID IN Cliente.ClienteID%TYPE,
    p_Nombre IN Cliente.Nombre%TYPE,
    p_Apellidos IN Cliente.Apellidos%TYPE,
    p_Telefono IN Cliente.Telefono%TYPE,
    p_Direccion IN Cliente.Direccion%TYPE,
    p_Email IN Cliente.Email%TYPE
)
IS
BEGIN
    INSERT INTO Cliente (ClienteID, Nombre, Apellidos, Telefono, Direccion, Email)
    VALUES (p_ClienteID, p_Nombre, p_Apellidos, p_Telefono, p_Direccion, p_Email);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerClientePorID(
    p_ClienteID IN Cliente.ClienteID%TYPE
)
IS
    v_Nombre Cliente.Nombre%TYPE;
    v_Apellidos Cliente.Apellidos%TYPE;
    v_Telefono Cliente.Telefono%TYPE;
    v_Direccion Cliente.Direccion%TYPE;
    v_Email Cliente.Email%TYPE;
BEGIN
    SELECT Nombre, Apellidos, Telefono, Direccion, Email INTO v_Nombre, v_Apellidos, v_Telefono, v_Direccion, v_Email
    FROM Cliente
    WHERE ClienteID = p_ClienteID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Apellidos: ' || v_Apellidos || ', Telefono: ' || v_Telefono || ', Direccion: ' || v_Direccion || ', Email: ' || v_Email);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No cliente found with ClienteID: ' || p_ClienteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarCliente(
    p_ClienteID IN Cliente.ClienteID%TYPE,
    p_Nombre IN Cliente.Nombre%TYPE,
    p_Apellidos IN Cliente.Apellidos%TYPE,
    p_Telefono IN Cliente.Telefono%TYPE,
    p_Direccion IN Cliente.Direccion%TYPE,
    p_Email IN Cliente.Email%TYPE
)
IS
BEGIN
    UPDATE Cliente
    SET Nombre = p_Nombre,
        Apellidos = p_Apellidos,
        Telefono = p_Telefono,
        Direccion = p_Direccion,
        Email = p_Email
    WHERE ClienteID = p_ClienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No cliente found with ClienteID: ' || p_ClienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarCliente(
    p_ClienteID IN Cliente.ClienteID%TYPE
)
IS
BEGIN
    DELETE FROM Cliente WHERE ClienteID = p_ClienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No cliente found with ClienteID: ' || p_ClienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


---------------------------------------------------------------------

/*CRUD DE LA TABLA PRODUCTO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearProducto(
    p_ProductoID IN Producto.ProductoID%TYPE,
    p_Nombre IN Producto.Nombre%TYPE,
    p_Precio IN Producto.Precio%TYPE,
    p_TipoProductoID IN Producto.TipoProductoID%TYPE
)
IS
BEGIN
    INSERT INTO Producto (ProductoID, Nombre, Precio, TipoProductoID)
    VALUES (p_ProductoID, p_Nombre, p_Precio, p_TipoProductoID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerProductoPorID(
    p_ProductoID IN Producto.ProductoID%TYPE
)
IS
    v_Nombre Producto.Nombre%TYPE;
    v_Precio Producto.Precio%TYPE;
    v_TipoProductoID Producto.TipoProductoID%TYPE;
BEGIN
    SELECT Nombre, Precio, TipoProductoID INTO v_Nombre, v_Precio, v_TipoProductoID
    FROM Producto
    WHERE ProductoID = p_ProductoID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Precio: ' || v_Precio || ', TipoProductoID: ' || v_TipoProductoID);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No producto found with ProductoID: ' || p_ProductoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarProducto(
    p_ProductoID IN Producto.ProductoID%TYPE,
    p_Nombre IN Producto.Nombre%TYPE,
    p_Precio IN Producto.Precio%TYPE,
    p_TipoProductoID IN Producto.TipoProductoID%TYPE
)
IS
BEGIN
    UPDATE Producto
    SET Nombre = p_Nombre,
        Precio = p_Precio,
        TipoProductoID = p_TipoProductoID
    WHERE ProductoID = p_ProductoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No producto found with ProductoID: ' || p_ProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Producto updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarProducto(
    p_ProductoID IN Producto.ProductoID%TYPE
)
IS
BEGIN
    DELETE FROM Producto WHERE ProductoID = p_ProductoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No producto found with ProductoID: ' || p_ProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Producto deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

---------------------------------------------------------------------

/*CRUD DE LA TABLA TIPOPRODUCTO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearTipoProducto(
    p_TipoProductoID IN TipoProducto.TipoProductoID%TYPE,
    p_Nombre IN TipoProducto.Nombre%TYPE
)
IS
BEGIN
    INSERT INTO TipoProducto (TipoProductoID, Nombre)
    VALUES (p_TipoProductoID, p_Nombre);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerTipoProductoPorID(
    p_TipoProductoID IN TipoProducto.TipoProductoID%TYPE
)
IS
    v_Nombre TipoProducto.Nombre%TYPE;
BEGIN
    SELECT Nombre INTO v_Nombre
    FROM TipoProducto
    WHERE TipoProductoID = p_TipoProductoID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No tipo producto found with TipoProductoID: ' || p_TipoProductoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarTipoProducto(
    p_TipoProductoID IN TipoProducto.TipoProductoID%TYPE,
    p_Nombre IN TipoProducto.Nombre%TYPE
)
IS
BEGIN
    UPDATE TipoProducto
    SET Nombre = p_Nombre
    WHERE TipoProductoID = p_TipoProductoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No tipo producto found with TipoProductoID: ' || p_TipoProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo producto updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarTipoProducto(
    p_TipoProductoID IN TipoProducto.TipoProductoID%TYPE
)
IS
BEGIN
    DELETE FROM TipoProducto WHERE TipoProductoID = p_TipoProductoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No tipo producto found with TipoProductoID: ' || p_TipoProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo producto deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


---------------------------------------------------------------------

/*CRUD DE LA TABLA INGREDIENTEEXTRA*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearIngredienteExtra(
    p_IngredienteID IN IngredienteExtra.IngredienteID%TYPE,
    p_Nombre IN IngredienteExtra.Nombre%TYPE,
    p_Precio IN IngredienteExtra.Precio%TYPE
)
IS
BEGIN
    INSERT INTO IngredienteExtra (IngredienteID, Nombre, Precio)
    VALUES (p_IngredienteID, p_Nombre, p_Precio);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerIngredienteExtraPorID(
    p_IngredienteID IN IngredienteExtra.IngredienteID%TYPE
)
IS
    v_Nombre IngredienteExtra.Nombre%TYPE;
    v_Precio IngredienteExtra.Precio%TYPE;
BEGIN
    SELECT Nombre, Precio INTO v_Nombre, v_Precio
    FROM IngredienteExtra
    WHERE IngredienteID = p_IngredienteID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Precio: ' || v_Precio);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No ingrediente extra found with IngredienteID: ' || p_IngredienteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarIngredienteExtra(
    p_IngredienteID IN IngredienteExtra.IngredienteID%TYPE,
    p_Nombre IN IngredienteExtra.Nombre%TYPE,
    p_Precio IN IngredienteExtra.Precio%TYPE
)
IS
BEGIN
    UPDATE IngredienteExtra
    SET Nombre = p_Nombre,
        Precio = p_Precio
    WHERE IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No ingrediente extra found with IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ingrediente extra updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarIngredienteExtra(
    p_IngredienteID IN IngredienteExtra.IngredienteID%TYPE
)
IS
BEGIN
    DELETE FROM IngredienteExtra WHERE IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No ingrediente extra found with IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ingrediente extra deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

---------------------------------------------------------------------

/*CRUD DE LA TABLA PEDIDO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearPedido(
    p_PedidoID IN Pedido.PedidoID%TYPE,
    p_ClienteID IN Pedido.ClienteID%TYPE,
    p_Fecha IN Pedido.Fecha%TYPE,
    p_Total IN Pedido.Total%TYPE,
    p_MetodoPagoID IN Pedido.MetodoPagoID%TYPE
)
IS
BEGIN
    INSERT INTO Pedido (PedidoID, ClienteID, Fecha, Total, MetodoPagoID)
    VALUES (p_PedidoID, p_ClienteID, p_Fecha, p_Total, p_MetodoPagoID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerPedidoPorID(
    p_PedidoID IN Pedido.PedidoID%TYPE
)
IS
    v_ClienteID Pedido.ClienteID%TYPE;
    v_Fecha Pedido.Fecha%TYPE;
    v_Total Pedido.Total%TYPE;
    v_MetodoPagoID Pedido.MetodoPagoID%TYPE;
BEGIN
    SELECT ClienteID, Fecha, Total, MetodoPagoID INTO v_ClienteID, v_Fecha, v_Total, v_MetodoPagoID
    FROM Pedido
    WHERE PedidoID = p_PedidoID;

    DBMS_OUTPUT.PUT_LINE('ClienteID: ' || v_ClienteID || ', Fecha: ' || v_Fecha || ', Total: ' || v_Total || ', MetodoPagoID: ' || v_MetodoPagoID);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No pedido found with PedidoID: ' || p_PedidoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarPedido(
    p_PedidoID IN Pedido.PedidoID%TYPE,
    p_ClienteID IN Pedido.ClienteID%TYPE,
    p_Fecha IN Pedido.Fecha%TYPE,
    p_Total IN Pedido.Total%TYPE,
    p_MetodoPagoID IN Pedido.MetodoPagoID%TYPE
)
IS
BEGIN
    UPDATE Pedido
    SET ClienteID = p_ClienteID,
        Fecha = p_Fecha,
        Total = p_Total,
        MetodoPagoID = p_MetodoPagoID
    WHERE PedidoID = p_PedidoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No pedido found with PedidoID: ' || p_PedidoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pedido updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarPedido(
    p_PedidoID IN Pedido.PedidoID%TYPE
)
IS
BEGIN
    DELETE FROM Pedido WHERE PedidoID = p_PedidoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No pedido found with PedidoID: ' || p_PedidoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pedido deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

---------------------------------------------------------------------

/*CRUD DE LA TABLA METODOPAGO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearMetodoPago(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE,
    p_Nombre IN MetodoPago.Nombre%TYPE
)
IS
BEGIN
    INSERT INTO MetodoPago (MetodoPagoID, Nombre)
    VALUES (p_MetodoPagoID, p_Nombre);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerMetodoPagoPorID(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE
)
IS
    v_Nombre MetodoPago.Nombre%TYPE;
BEGIN
    SELECT Nombre INTO v_Nombre
    FROM MetodoPago
    WHERE MetodoPagoID = p_MetodoPagoID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No metodo pago found with MetodoPagoID: ' || p_MetodoPagoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarMetodoPago(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE,
    p_Nombre IN MetodoPago.Nombre%TYPE
)
IS
BEGIN
    UPDATE MetodoPago
    SET Nombre = p_Nombre
    WHERE MetodoPagoID = p_MetodoPagoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No metodo pago found with MetodoPagoID: ' || p_MetodoPagoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Metodo pago updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarMetodoPago(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE
)
IS
BEGIN
    DELETE FROM MetodoPago WHERE MetodoPagoID = p_MetodoPagoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No metodo pago found with MetodoPagoID: ' || p_MetodoPagoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Metodo pago deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


---------------------------------------------------------------------

/*CRUD DE LA TABLA PROMOCION*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearPromocion(
    p_PromocionID IN Promocion.PromocionID%TYPE,
    p_Nombre IN Promocion.Nombre%TYPE,
    p_Descripcion IN Promocion.Descripcion%TYPE,
    p_FechaInicio IN Promocion.FechaInicio%TYPE,
    p_FechaFin IN Promocion.FechaFin%TYPE,
    p_Descuento IN Promocion.Descuento%TYPE
)
IS
BEGIN
    INSERT INTO Promocion (PromocionID, Nombre, Descripcion, FechaInicio, FechaFin, Descuento)
    VALUES (p_PromocionID, p_Nombre, p_Descripcion, p_FechaInicio, p_FechaFin, p_Descuento);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerPromocionPorID(
    p_PromocionID IN Promocion.PromocionID%TYPE
)
IS
    v_Nombre Promocion.Nombre%TYPE;
    v_Descripcion Promocion.Descripcion%TYPE;
    v_FechaInicio Promocion.FechaInicio%TYPE;
    v_FechaFin Promocion.FechaFin%TYPE;
    v_Descuento Promocion.Descuento%TYPE;
BEGIN
    SELECT Nombre, Descripcion, FechaInicio, FechaFin, Descuento INTO v_Nombre, v_Descripcion, v_FechaInicio, v_FechaFin, v_Descuento
    FROM Promocion
    WHERE PromocionID = p_PromocionID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Descripcion: ' || v_Descripcion || ', FechaInicio: ' || v_FechaInicio || ', FechaFin: ' || v_FechaFin || ', Descuento: ' || v_Descuento);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No promocion found with PromocionID: ' || p_PromocionID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarPromocion(
    p_PromocionID IN Promocion.PromocionID%TYPE,
    p_Nombre IN Promocion.Nombre%TYPE,
    p_Descripcion IN Promocion.Descripcion%TYPE,
    p_FechaInicio IN Promocion.FechaInicio%TYPE,
    p_FechaFin IN Promocion.FechaFin%TYPE,
    p_Descuento IN Promocion.Descuento%TYPE
)
IS
BEGIN
    UPDATE Promocion
    SET Nombre = p_Nombre,
        Descripcion = p_Descripcion,
        FechaInicio = p_FechaInicio,
        FechaFin = p_FechaFin,
        Descuento = p_Descuento
    WHERE PromocionID = p_PromocionID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No promocion found with PromocionID: ' || p_PromocionID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Promocion updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarPromocion(
    p_PromocionID IN Promocion.PromocionID%TYPE
)
IS
BEGIN
    DELETE FROM Promocion WHERE PromocionID = p_PromocionID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No promocion found with PromocionID: ' || p_PromocionID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Promocion deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

---------------------------------------------------------------------

/*CRUD DE LA TABLA DETALLECOMPRA*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearDetalleCompra(
    p_DetalleCompraID IN DetalleCompra.DetalleCompraID%TYPE,
    p_CompraID IN DetalleCompra.CompraID%TYPE,
    p_ProductoID IN DetalleCompra.ProductoID%TYPE,
    p_Cantidad IN DetalleCompra.Cantidad%TYPE,
    p_PrecioUnitario IN DetalleCompra.PrecioUnitario%TYPE
)
IS
BEGIN
    INSERT INTO DetalleCompra (DetalleCompraID, CompraID, ProductoID, Cantidad, PrecioUnitario)
    VALUES (p_DetalleCompraID, p_CompraID, p_ProductoID, p_Cantidad, p_PrecioUnitario);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerDetalleCompraPorID(
    p_DetalleCompraID IN DetalleCompra.DetalleCompraID%TYPE
)
IS
    v_CompraID DetalleCompra.CompraID%TYPE;
    v_ProductoID DetalleCompra.ProductoID%TYPE;
    v_Cantidad DetalleCompra.Cantidad%TYPE;
    v_PrecioUnitario DetalleCompra.PrecioUnitario%TYPE;
BEGIN
    SELECT CompraID, ProductoID, Cantidad, PrecioUnitario INTO v_CompraID, v_ProductoID, v_Cantidad, v_PrecioUnitario
    FROM DetalleCompra
    WHERE DetalleCompraID = p_DetalleCompraID;

    DBMS_OUTPUT.PUT_LINE('CompraID: ' || v_CompraID || ', ProductoID: ' || v_ProductoID || ', Cantidad: ' || v_Cantidad || ', PrecioUnitario: ' || v_PrecioUnitario);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No detalle compra found with DetalleCompraID: ' || p_DetalleCompraID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarDetalleCompra(
    p_DetalleCompraID IN DetalleCompra.DetalleCompraID%TYPE,
    p_CompraID IN DetalleCompra.CompraID%TYPE,
    p_ProductoID IN DetalleCompra.ProductoID%TYPE,
    p_Cantidad IN DetalleCompra.Cantidad%TYPE,
    p_PrecioUnitario IN DetalleCompra.PrecioUnitario%TYPE
)
IS
BEGIN
    UPDATE DetalleCompra
    SET CompraID = p_CompraID,
        ProductoID = p_ProductoID,
        Cantidad = p_Cantidad,
        PrecioUnitario = p_PrecioUnitario
    WHERE DetalleCompraID = p_DetalleCompraID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No detalle compra found with DetalleCompraID: ' || p_DetalleCompraID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Detalle compra updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarDetalleCompra(
    p_DetalleCompraID IN DetalleCompra.DetalleCompraID%TYPE
)
IS
BEGIN
    DELETE FROM DetalleCompra WHERE DetalleCompraID = p_DetalleCompraID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No detalle compra found with DetalleCompraID: ' || p_DetalleCompraID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Detalle compra deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


---------------------------------------------------------------------
/*CRUD DE LA TABLA REPORTE*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearReporte(
    p_ReporteID IN Reporte.ReporteID%TYPE,
    p_Titulo IN Reporte.Titulo%TYPE,
    p_Fecha IN Reporte.Fecha%TYPE,
    p_Contenido IN Reporte.Contenido%TYPE
)
IS
BEGIN
    INSERT INTO Reporte (ReporteID, Titulo, Fecha, Contenido)
    VALUES (p_ReporteID, p_Titulo, p_Fecha, p_Contenido);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerReportePorID(
    p_ReporteID IN Reporte.ReporteID%TYPE
)
IS
    v_Titulo Reporte.Titulo%TYPE;
    v_Fecha Reporte.Fecha%TYPE;
    v_Contenido Reporte.Contenido%TYPE;
BEGIN
    SELECT Titulo, Fecha, Contenido INTO v_Titulo, v_Fecha, v_Contenido
    FROM Reporte
    WHERE ReporteID = p_ReporteID;

    DBMS_OUTPUT.PUT_LINE('Titulo: ' || v_Titulo || ', Fecha: ' || v_Fecha || ', Contenido: ' || v_Contenido);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No reporte found with ReporteID: ' || p_ReporteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarReporte(
    p_ReporteID IN Reporte.ReporteID%TYPE,
    p_Titulo IN Reporte.Titulo%TYPE,
    p_Fecha IN Reporte.Fecha%TYPE,
    p_Contenido IN Reporte.Contenido%TYPE
)
IS
BEGIN
    UPDATE Reporte
    SET Titulo = p_Titulo,
        Fecha = p_Fecha,
        Contenido = p_Contenido
    WHERE ReporteID = p_ReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No reporte found with ReporteID: ' || p_ReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Reporte updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarReporte(
    p_ReporteID IN Reporte.ReporteID%TYPE
)
IS
BEGIN
    DELETE FROM Reporte WHERE ReporteID = p_ReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No reporte found with ReporteID: ' || p_ReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Reporte deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

---------------------------------------------------------------------
/*CRUD DE LA TABLA TIPO VENTA*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearTipoVenta(
    p_TipoVentaID IN TipoVenta.TipoVentaID%TYPE,
    p_MetodoRetiro IN TipoVenta.MetodoRetiro%TYPE
)
IS
BEGIN
    INSERT INTO TipoVenta (TipoVentaID, MetodoRetiro)
    VALUES (p_TipoVentaID, p_MetodoRetiro);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerTipoVentaPorID(
    p_TipoVentaID IN TipoVenta.TipoVentaID%TYPE
)
IS
    v_MetodoRetiro TipoVenta.MetodoRetiro%TYPE;
BEGIN
    SELECT MetodoRetiro INTO v_MetodoRetiro
    FROM TipoVenta
    WHERE TipoVentaID = p_TipoVentaID;

    DBMS_OUTPUT.PUT_LINE('Metodo Retiro: ' || v_MetodoRetiro);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No tipo venta found with TipoVentaID: ' || p_TipoVentaID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarTipoVenta(
    p_TipoVentaID IN TipoVenta.TipoVentaID%TYPE,
    p_MetodoRetiro IN TipoVenta.MetodoRetiro%TYPE
)
IS
BEGIN
    UPDATE TipoVenta
    SET MetodoRetiro = p_MetodoRetiro
    WHERE TipoVentaID = p_TipoVentaID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No tipo venta found with TipoVentaID: ' || p_TipoVentaID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo venta updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarTipoVenta(
    p_TipoVentaID IN TipoVenta.TipoVentaID%TYPE
)
IS
BEGIN
    DELETE FROM TipoVenta WHERE TipoVentaID = p_TipoVentaID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No tipo venta found with TipoVentaID: ' || p_TipoVentaID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo venta deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


---------------------------------------------------------------------

/*CRUD DE LA TABLA DETALLE REPORTE*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearDetalleReporte(
    p_DetalleReporteID IN DetalleReporte.DetalleReporteID%TYPE,
    p_ReporteID IN DetalleReporte.ReporteID%TYPE,
    p_ClienteID IN DetalleReporte.ClienteID%TYPE,
    p_PedidoID IN DetalleReporte.PedidoID%TYPE,
    p_TotalPedidos IN DetalleReporte.TotalPedidos%TYPE,
    p_TotalGasto IN DetalleReporte.TotalGasto%TYPE,
    p_FrecuenciaPedidos IN DetalleReporte.FrecuenciaPedidos%TYPE
)
IS
BEGIN
    INSERT INTO DetalleReporte (DetalleReporteID, ReporteID, ClienteID, PedidoID, TotalPedidos, TotalGasto, FrecuenciaPedidos)
    VALUES (p_DetalleReporteID, p_ReporteID, p_ClienteID, p_PedidoID, p_TotalPedidos, p_TotalGasto, p_FrecuenciaPedidos);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerDetalleReportePorID(
    p_DetalleReporteID IN DetalleReporte.DetalleReporteID%TYPE
)
IS
    v_ReporteID DetalleReporte.ReporteID%TYPE;
    v_ClienteID DetalleReporte.ClienteID%TYPE;
    v_PedidoID DetalleReporte.PedidoID%TYPE;
    v_TotalPedidos DetalleReporte.TotalPedidos%TYPE;
    v_TotalGasto DetalleReporte.TotalGasto%TYPE;
    v_FrecuenciaPedidos DetalleReporte.FrecuenciaPedidos%TYPE;
BEGIN
    SELECT ReporteID, ClienteID, PedidoID, TotalPedidos, TotalGasto, FrecuenciaPedidos
    INTO v_ReporteID, v_ClienteID, v_PedidoID, v_TotalPedidos, v_TotalGasto, v_FrecuenciaPedidos
    FROM DetalleReporte
    WHERE DetalleReporteID = p_DetalleReporteID;

    DBMS_OUTPUT.PUT_LINE('ReporteID: ' || v_ReporteID || ', ClienteID: ' || v_ClienteID || ', PedidoID: ' || v_PedidoID || ', TotalPedidos: ' || v_TotalPedidos || ', TotalGasto: ' || v_TotalGasto || ', FrecuenciaPedidos: ' || v_FrecuenciaPedidos);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No detalle reporte found with DetalleReporteID: ' || p_DetalleReporteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarDetalleReporte(
    p_DetalleReporteID IN DetalleReporte.DetalleReporteID%TYPE,
    p_ReporteID IN DetalleReporte.ReporteID%TYPE,
    p_ClienteID IN DetalleReporte.ClienteID%TYPE,
    p_PedidoID IN DetalleReporte.PedidoID%TYPE,
    p_TotalPedidos IN DetalleReporte.TotalPedidos%TYPE,
    p_TotalGasto IN DetalleReporte.TotalGasto%TYPE,
    p_FrecuenciaPedidos IN DetalleReporte.FrecuenciaPedidos%TYPE
)
IS
BEGIN
    UPDATE DetalleReporte
    SET ReporteID = p_ReporteID,
        ClienteID = p_ClienteID,
        PedidoID = p_PedidoID,
        TotalPedidos = p_TotalPedidos,
        TotalGasto = p_TotalGasto,
        FrecuenciaPedidos = p_FrecuenciaPedidos
    WHERE DetalleReporteID = p_DetalleReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No detalle reporte found with DetalleReporteID: ' || p_DetalleReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Detalle reporte updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarDetalleReporte(
    p_DetalleReporteID IN DetalleReporte.DetalleReporteID%TYPE
)
IS
BEGIN
    DELETE FROM DetalleReporte WHERE DetalleReporteID = p_DetalleReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No detalle reporte found with DetalleReporteID: ' || p_DetalleReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Detalle reporte deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
