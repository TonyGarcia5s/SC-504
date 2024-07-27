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

---------------------------------------------------------------------

/*CRUD DE LA TABLA PRODUCTO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearProducto(
    p_ProductoID IN Producto.ProductoID%TYPE,
    p_Nombre IN Producto.Nombre%TYPE,
    p_Precio IN Producto.Precio%TYPE,
    p_Descripcion IN Producto.Descripcion%TYPE
)
IS
BEGIN
    INSERT INTO Producto (ProductoID, Nombre, Precio, Descripcion)
    VALUES (p_ProductoID, p_Nombre, p_Precio, p_Descripcion);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerProductoPorID(
    p_ProductoID IN Producto.ProductoID%TYPE
)
IS
    v_Nombre Producto.Nombre%TYPE;
    v_Precio Producto.Precio%TYPE;
    v_Descripcion Producto.Descripcion%TYPE;
BEGIN
    SELECT Nombre, Precio, Descripcion INTO v_Nombre, v_Precio, v_Descripcion
    FROM Producto
    WHERE ProductoID = p_ProductoID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Precio: ' || v_Precio || ', Descripcion: ' || v_Descripcion);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No producto found with ProductoID: ' || p_ProductoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarProducto(
    p_ProductoID IN Producto.ProductoID%TYPE,
    p_Nombre IN Producto.Nombre%TYPE,
    p_Precio IN Producto.Precio%TYPE,
    p_Descripcion IN Producto.Descripcion%TYPE
)
IS
BEGIN
    UPDATE Producto
    SET Nombre = p_Nombre,
        Precio = p_Precio,
        Descripcion = p_Descripcion
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


---------------------------------------------------------------------

/*CRUD DE LA TABLA TIPOPRODUCTO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearTipoProducto(
    p_TipoProductoID IN TipoProducto.TipoProductoID%TYPE,
    p_Tamano IN TipoProducto.Tamano%TYPE,
    p_Descripcion IN TipoProducto.Descripcion%TYPE,
    p_ProductoID IN TipoProducto.ProductoID%TYPE
)
IS
BEGIN
    INSERT INTO TipoProducto (TipoProductoID, Tamano, Descripcion, ProductoID)
    VALUES (p_TipoProductoID, p_Tamano, p_Descripcion, p_ProductoID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerTipoProductoPorID(
    p_TipoProductoID IN TipoProducto.TipoProductoID%TYPE
)
IS
    v_Tamano TipoProducto.Tamano%TYPE;
    v_Descripcion TipoProducto.Descripcion%TYPE;
    v_ProductoID TipoProducto.ProductoID%TYPE;
BEGIN
    SELECT Tamano, Descripcion, ProductoID INTO v_Tamano, v_Descripcion, v_ProductoID
    FROM TipoProducto
    WHERE TipoProductoID = p_TipoProductoID;

    DBMS_OUTPUT.PUT_LINE('Tamaño: ' || v_Tamano || ', Descripción: ' || v_Descripcion || ', ProductoID: ' || v_ProductoID);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No tipo producto found with TipoProductoID: ' || p_TipoProductoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarTipoProducto(
    p_TipoProductoID IN TipoProducto.TipoProductoID%TYPE,
    p_Tamano IN TipoProducto.Tamano%TYPE,
    p_Descripcion IN TipoProducto.Descripcion%TYPE,
    p_ProductoID IN Producto.ProductoID%TYPE
)
IS
BEGIN
    UPDATE TipoProducto
    SET Tamano = p_Tamano,
        Descripcion = p_Descripcion,
        ProductoID = p_ProductoID
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


---------------------------------------------------------------------

/*CRUD DE LA TABLA INGREDIENTEEXTRA*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearIngredientesExtra(
    p_IngredienteID IN IngredientesExtra.IngredienteID%TYPE,
    p_Nombre IN IngredientesExtra.Nombre%TYPE,
    p_Descripcion IN IngredientesExtra.Descripcion%TYPE,
    p_Precio IN IngredientesExtra.Precio%TYPE,
    p_ProductoID IN IngredientesExtra.ProductoID%TYPE
)
IS
BEGIN
    INSERT INTO IngredientesExtra (IngredienteID, Nombre, Descripcion, Precio, ProductoID)
    VALUES (p_IngredienteID, p_Nombre, p_Descripcion, p_Precio, p_ProductoID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerIngredienteExtraPorID(
    p_IngredienteID IN IngredientesExtra.IngredienteID%TYPE
)
IS
    v_Nombre IngredientesExtra.Nombre%TYPE;
    v_Descripcion IngredientesExtra.Descripcion%TYPE;
    v_Precio IngredientesExtra.Precio%TYPE;
    v_ProductoID IngredientesExtra.ProductoID%TYPE;
BEGIN
    SELECT Nombre, Descripcion, Precio, ProductoID INTO v_Nombre, v_Descripcion, v_Precio, v_ProductoID
    FROM IngredientesExtra
    WHERE IngredienteID = p_IngredienteID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Descripción: ' || v_Descripcion || ', Precio: ' || v_Precio || ', ProductoID: ' || v_ProductoID);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No ingrediente extra found with IngredienteID: ' || p_IngredienteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarIngredientesExtra(
    p_IngredienteID IN IngredientesExtra.IngredienteID%TYPE,
    p_Nombre IN IngredientesExtra.Nombre%TYPE,
    p_Descripcion IN IngredientesExtra.Descripcion%TYPE,
    p_Precio IN IngredientesExtra.Precio%TYPE,
    p_ProductoID IN IngredientesExtra.ProductoID%TYPE
)
IS
BEGIN
    UPDATE IngredientesExtra
    SET Nombre = p_Nombre,
        Descripcion = p_Descripcion,
        Precio = p_Precio,
        ProductoID = p_ProductoID
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


/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarIngredientesExtra(
    p_IngredienteID IN IngredientesExtra.IngredienteID%TYPE
)
IS
BEGIN
    DELETE FROM IngredientesExtra WHERE IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No ingrediente extra found with IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ingrediente extra deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


---------------------------------------------------------------------

/*CRUD DE LA TABLA PEDIDO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearPedido(
    p_PedidoID IN Pedido.PedidoID%TYPE,
    p_ClienteID IN Pedido.ClienteID%TYPE,
    p_SucursalID IN Pedido.SucursalID%TYPE,
    p_MetodoPagoID IN Pedido.MetodoPagoID%TYPE,
    p_PromocionID IN Pedido.PromocionID%TYPE,
    p_TipoVentaID IN Pedido.TipoVentaID%TYPE,
    p_Fecha IN Pedido.Fecha%TYPE,
    p_Hora IN Pedido.Hora%TYPE
)
IS
BEGIN
    INSERT INTO Pedido (PedidoID, ClienteID, SucursalID, MetodoPagoID, PromocionID, TipoVentaID, Fecha, Hora)
    VALUES (p_PedidoID, p_ClienteID, p_SucursalID, p_MetodoPagoID, p_PromocionID, p_TipoVentaID, p_Fecha, p_Hora);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerPedidoPorID(
    p_PedidoID IN Pedido.PedidoID%TYPE
)
IS
    v_ClienteID Pedido.ClienteID%TYPE;
    v_SucursalID Pedido.SucursalID%TYPE;
    v_MetodoPagoID Pedido.MetodoPagoID%TYPE;
    v_PromocionID Pedido.PromocionID%TYPE;
    v_TipoVentaID Pedido.TipoVentaID%TYPE;
    v_Fecha Pedido.Fecha%TYPE;
    v_Hora Pedido.Hora%TYPE;
BEGIN
    SELECT ClienteID, SucursalID, MetodoPagoID, PromocionID, TipoVentaID, Fecha, Hora INTO v_ClienteID, v_SucursalID, v_MetodoPagoID, v_PromocionID, v_TipoVentaID, v_Fecha, v_Hora
    FROM Pedido
    WHERE PedidoID = p_PedidoID;

    DBMS_OUTPUT.PUT_LINE('ClienteID: ' || v_ClienteID || ', SucursalID: ' || v_SucursalID || ', MetodoPagoID: ' || v_MetodoPagoID || ', Promoción: ' || v_PromocionID || ', TipoVentaID: ' || v_TipoVentaID || ', Fecha: ' || v_Fecha || ', Hora: ' || v_Hora);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No pedido found with PedidoID: ' || p_PedidoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarPedido(
    p_PedidoID IN Pedido.PedidoID%TYPE,
    p_ClienteID IN Pedido.ClienteID%TYPE,
    p_SucursalID IN Pedido.SucursalID%TYPE,
    p_MetodoPagoID IN Pedido.MetodoPagoID%TYPE,
    p_PromocionID IN Pedido.PromocionID%TYPE,
    p_TipoVentaID IN Pedido.TipoVentaID%TYPE,
    p_Fecha IN Pedido.Fecha%TYPE,
    p_Hora IN Pedido.Hora%TYPE
)
IS
BEGIN
    UPDATE Pedido
    SET ClienteID = p_ClienteID,
        SucursalID = p_SucursalID,
        MetodoPagoID = p_MetodoPagoID,
        PromocionID = p_PromocionID,
        TipoVentaID = p_TipoVentaID,
        Fecha = p_Fecha,
        Hora = p_Hora
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


---------------------------------------------------------------------

/*CRUD DE LA TABLA METODOPAGO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearMetodoPago(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE,
    p_TipoPago IN MetodoPago.TipoPago%TYPE
)
IS
BEGIN
    INSERT INTO MetodoPago (MetodoPagoID, TipoPago)
    VALUES (p_MetodoPagoID, p_TipoPago);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerMetodoPagoPorID(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE
)
IS
    v_TipoPago MetodoPago.TipoPago%TYPE;
BEGIN
    SELECT TipoPago INTO v_TipoPago
    FROM MetodoPago
    WHERE MetodoPagoID = p_MetodoPagoID;

    DBMS_OUTPUT.PUT_LINE('Tipo de Pago: ' || v_TipoPago);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No metodo pago found with MetodoPagoID: ' || p_MetodoPagoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarMetodoPago(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE,
    p_TipoPago IN MetodoPago.TipoPago%TYPE
)
IS
BEGIN
    UPDATE MetodoPago
    SET TipoPago = p_TipoPago
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


---------------------------------------------------------------------

/*CRUD DE LA TABLA TIPOVENTA*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearMTipoVenta(
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

    DBMS_OUTPUT.PUT_LINE('Mètodo de Retiro: ' || v_MetodoRetiro);
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
        DBMS_OUTPUT.PUT_LINE('Tipo Venta deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


---------------------------------------------------------------------

/*CRUD DE LA TABLA PROMOCION*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearPromocion(
    p_PromocionID IN Promocion.PromocionID%TYPE,
    p_Descripcion IN Promocion.Descripcion%TYPE,
    p_Descuento IN Promocion.Descuento%TYPE
)
IS
BEGIN
    INSERT INTO Promocion (PromocionID, Descripcion, Descuento)
    VALUES (p_PromocionID, p_Descripcion, p_Descuento);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerPromocionPorID(
    p_PromocionID IN Promocion.PromocionID%TYPE
)
IS
    v_Descripcion Promocion.Descripcion%TYPE;
    v_Descuento Promocion.Descuento%TYPE;
BEGIN
    SELECT Descripcion, Descuento INTO v_Descripcion, v_Descuento
    FROM Promocion
    WHERE PromocionID = p_PromocionID;

    DBMS_OUTPUT.PUT_LINE('Descripcion: ' || v_Descripcion || ', Descuento: ' || v_Descuento);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No promocion found with PromocionID: ' || p_PromocionID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarPromocion(
    p_PromocionID IN Promocion.PromocionID%TYPE,
    p_Descripcion IN Promocion.Descripcion%TYPE,
    p_Descuento IN Promocion.Descuento%TYPE
)
IS
BEGIN
    UPDATE Promocion
    SET Descripcion = p_Descripcion,
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


---------------------------------------------------------------------

/*CRUD DE LA TABLA DETALLEPEDIDO*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearDetallePedido(
    p_DetallePedidoID IN DetallePedido.DetallePedidoID%TYPE,
    p_PedidoID IN DetallePedido.PedidoID%TYPE,
    p_ProductoID IN DetallePedido.ProductoID%TYPE,
    p_IngredienteExtraID IN DetallePedido.IngredienteExtraID%TYPE,
    p_CantidadProductos IN DetallePedido.CantidadProductos%TYPE,
    p_PrecioUnitario IN DetallePedido.PrecioUnitario%TYPE,
    p_PrecioTotal IN DetallePedido.PrecioTotal%TYPE,
    p_PrecioIva IN DetallePedido.PrecioIva%TYPE,
    p_PrecioTotalDescuento IN DetallePedido.PrecioTotalDescuento%TYPE
)
IS
BEGIN
    INSERT INTO DetallePedido (DetallePedidoID, PedidoID, ProductoID, IngredienteExtraID, CantidadProductos, PrecioUnitario, PrecioTotal, PrecioIva, PrecioTotalDescuento)
    VALUES (p_DetallePedidoID, p_PedidoID, p_ProductoID, p_IngredienteExtraID, p_CantidadProductos, p_PrecioUnitario, p_PrecioTotal, p_PrecioIva, p_PrecioTotalDescuento);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerDetallePedidoPorID(
    p_DetallePedidoID IN DetallePedido.DetallePedidoID%TYPE
)
IS
    v_PedidoID DetallePedido.PedidoID%TYPE;
    v_ProductoID DetallePedido.ProductoID%TYPE;
    v_IngredienteExtraID DetallePedido.IngredienteExtraID%TYPE;
    v_CantidadProductos DetallePedido.CantidadProductos%TYPE;
    v_PrecioUnitario DetallePedido.PrecioUnitario%TYPE;
    v_PrecioTotal DetallePedido.PrecioTotal%TYPE;
    v_PrecioIva DetallePedido.PrecioIva%TYPE;
    v_PrecioTotalDescuento DetallePedido.PrecioTotalDescuento%TYPE;
BEGIN
    SELECT PedidoID, ProductoID, IngredienteExtraID, CantidadProductos, PrecioUnitario, PrecioTotal, PrecioIva, PrecioTotalDescuento INTO v_PedidoID, v_ProductoID, v_IngredienteExtraID, v_CantidadProductos, v_PrecioUnitario, v_PrecioTotal, v_PrecioIva, v_PrecioTotalDescuento
    FROM DetallePedido
    WHERE DetallePedidoID = p_DetallePedidoID;

    DBMS_OUTPUT.PUT_LINE('PedidoID: ' || v_PedidoID || ', ProductoID: ' || v_ProductoID || ', IngredienteExtraID: ' || v_IngredienteExtraID || ', CantidadProductos: ' || v_CantidadProductos || ', PrecioUnitario: ' || v_PrecioUnitario || ', PrecioTotal: ' || v_PrecioTotal || ', PrecioIva: ' || v_PrecioIva || ', PrecioTotalDescuento: ' || v_PrecioTotalDescuento);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No detalle pedido found with DetallePedidoID: ' || p_DetallePedidoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarDetallePedido(
    p_DetallePedidoID IN DetallePedido.DetallePedidoID%TYPE,
    p_PedidoID IN DetallePedido.PedidoID%TYPE,
    p_ProductoID IN DetallePedido.ProductoID%TYPE,
    p_IngredienteExtraID IN DetallePedido.IngredienteExtraID%TYPE,
    p_CantidadProductos IN DetallePedido.CantidadProductos%TYPE,
    p_PrecioUnitario IN DetallePedido.PrecioUnitario%TYPE,
    p_PrecioTotal IN DetallePedido.PrecioTotal%TYPE,
    p_PrecioIva IN DetallePedido.PrecioIva%TYPE,
    p_PrecioTotalDescuento IN DetallePedido.PrecioTotalDescuento%TYPE
)
IS
BEGIN
    UPDATE DetallePedido
    SET PedidoID = p_PedidoID,
        ProductoID = p_ProductoID,
        IngredienteExtraID = p_IngredienteExtraID,
        CantidadProductos = p_CantidadProductos,
        PrecioUnitario = p_PrecioUnitario,
        PrecioTotal = p_PrecioTotal,
        PrecioIva = p_PrecioIva,
        PrecioTotalDescuento = p_PrecioTotalDescuento
    WHERE DetallePedidoID = p_DetallePedidoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No detalle pedio found with DetallePedidoID: ' || p_DetallePedidoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Detalle pedido updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarDetallePedido(
    p_DetallePedidoID IN DetallePedido.DetallePedidoID%TYPE
)
IS
BEGIN
    DELETE FROM DetallePedido WHERE DetallePedidoID = p_DetallePedidoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No detalle pedido found with DetallePedidoID: ' || p_DetallePedidoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Detalle pedido deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


---------------------------------------------------------------------
/*CRUD DE LA TABLA REPORTES*/

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearReportes(
    p_ReporteID IN Reportes.ReporteID%TYPE,
    p_Descripcion IN Reportes.Descripcion%TYPE,
    p_FechaGeneracion IN Reportes.FechaGeneracion%TYPE
)
IS
BEGIN
    INSERT INTO Reportes (ReporteID, Descripcion, FechaGeneracion)
    VALUES (p_ReporteID, p_Descripcion, p_FechaGeneracion);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerReportePorID(
    p_ReporteID IN Reportes.ReporteID%TYPE
)
IS
    v_Descripcion Reportes.Descripcion%TYPE;
    v_FechaGeneracion Reportes.FechaGeneracion%TYPE;
BEGIN
    SELECT Descripcion, FechaGeneracion INTO v_Descripcion, v_FechaGeneracion
    FROM Reportes
    WHERE ReporteID = p_ReporteID;

    DBMS_OUTPUT.PUT_LINE('Descripción: ' || v_Descripcion || ', FechaGeneración: ' || v_FechaGeneracion);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No reporte found with ReporteID: ' || p_ReporteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarReportes(
    p_ReporteID IN Reportes.ReporteID%TYPE,
    p_Descripcion IN Reportes.Descripcion%TYPE,
    p_FechaGeneracion IN Reportes.FechaGeneracion%TYPE
)
IS
BEGIN
    UPDATE Reportes
    SET Descripcion = p_Descripcion,
        FechaGeneracion = p_FechaGeneracion
    WHERE ReporteID = p_ReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No reporte found with ReporteID: ' || p_ReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Reportes updated successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarReporte(
    p_ReporteID IN Reportes.ReporteID%TYPE
)
IS
BEGIN
    DELETE FROM Reportes WHERE ReporteID = p_ReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No reporte found with ReporteID: ' || p_ReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Reportes deleted successfully');
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
