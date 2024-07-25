SET SERVEROUTPUT ON


---------------------------------------------------------------------------------
CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR2(255) NOT NULL,
    Apellidos VARCHAR2(255) NOT NULL,
    Telefono VARCHAR2(15) NOT NULL,
    Direccion VARCHAR2(255) NOT NULL,
    Email VARCHAR2(255) NOT NULL
);
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
        DBMS_OUTPUT.PUT_LINE('No client found with ClienteID: ' || p_ClienteID);
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
        DBMS_OUTPUT.PUT_LINE('No client found with ClienteID: ' || p_ClienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Client updated successfully');
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
        DBMS_OUTPUT.PUT_LINE('No client found with ClienteID: ' || p_ClienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Client deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*SALIDA*/

BEGIN
    CrearCliente(1, 'Juan', 'Pérez', '1234567890', 'Calle Falsa 123', 'juan.perez@example.com');
END;
BEGIN
    CrearCliente(1, 'maria', 'cordero', '14354554', 'el tigre', 'cordero@gmail.com');
END;
BEGIN
    ObtenerClientePorID(1);
END;

BEGIN
    ActualizarCliente(1, 'Juan', 'Pérez', '0987654321', 'Avenida Siempre Viva 742', 'juan.perez@updated.com');
END;

BEGIN
    EliminarCliente(1);
END;





--------------------------------------------------------------------------------
CREATE TABLE Sucursal (
    SucursalID INT PRIMARY KEY,
    Nombre VARCHAR2(255) NOT NULL,
    Direccion VARCHAR2(255) NOT NULL,
    Telefono VARCHAR2(15) NOT NULL
);

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


/*SALIDA*/

BEGIN
    CrearSucursal(1, 'Sucursal Central', 'Avenida Principal 456', '0987654321');
END;

BEGIN
    ObtenerSucursalPorID(1);
END;

BEGIN
    ActualizarSucursal(1, 'Sucursal Central', 'Avenida Secundaria 789', '0123456789');
END;

BEGIN
    EliminarSucursal(1);
END;




--------------------------------------------------------------------------------
CREATE TABLE MetodoPago (
    MetodoPagoID INT PRIMARY KEY,
    TipoPago VARCHAR2(20) CHECK (TipoPago IN ('efectivo', 'tarjeta', 'sinpe', 'apple pay')) NOT NULL
);
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

    DBMS_OUTPUT.PUT_LINE('TipoPago: ' || v_TipoPago);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No metodo de pago found with MetodoPagoID: ' || p_MetodoPagoID);
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
        DBMS_OUTPUT.PUT_LINE('No metodo de pago found with MetodoPagoID: ' || p_MetodoPagoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Metodo de pago updated successfully');
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
        DBMS_OUTPUT.PUT_LINE('No metodo de pago found with MetodoPagoID: ' || p_MetodoPagoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Metodo de pago deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*SALIDA*/
BEGIN
    CrearMetodoPago(1, 'efectivo');
END;
BEGIN
    CrearMetodoPago(2, 'tarjeta');
END;
BEGIN
    CrearMetodoPago(3, 'sinpe');
END;
BEGIN
    CrearMetodoPago(4, 'apple pay');
END;
BEGIN
    ObtenerMetodoPagoPorID(1);
END;

BEGIN
    ActualizarMetodoPago(1, 'apple pay');
END;

BEGIN
    EliminarMetodoPago(1);
END;





--------------------------------------------------------------------------------
CREATE TABLE Promocion (
    PromocionID INT PRIMARY KEY,
    Descripcion VARCHAR2(255),
    Descuento DECIMAL(5, 2) NOT NULL
);
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


/*SALIDA*/

BEGIN
    CrearPromocion(1, 'Descuento de verano', 150);
END;

BEGIN
    ObtenerPromocionPorID(1);
END;

BEGIN
    ActualizarPromocion(1, 'Descuento de invierno', 200);
END;

BEGIN
    EliminarPromocion(1);
END;




--------------------------------------------------------------------------------
CREATE TABLE TipoVenta (
    TipoVentaID INT PRIMARY KEY,
    MetodoRetiro VARCHAR2(20) CHECK (MetodoRetiro IN ('restaurante', 'drive thru', 'app')) NOT NULL
);
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

    DBMS_OUTPUT.PUT_LINE('MetodoRetiro: ' || v_MetodoRetiro);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No tipo de venta found with TipoVentaID: ' || p_TipoVentaID);
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
        DBMS_OUTPUT.PUT_LINE('No tipo de venta found with TipoVentaID: ' || p_TipoVentaID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo de venta updated successfully');
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
        DBMS_OUTPUT.PUT_LINE('No tipo de venta found with TipoVentaID: ' || p_TipoVentaID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo de venta deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*SALIDA*/

BEGIN
    CrearTipoVenta(1, 'restaurante');
END;
BEGIN
    CrearTipoVenta(2, 'drive thru');
END;
BEGIN
    CrearTipoVenta(3, 'app');
END;
BEGIN
    ObtenerTipoVentaPorID(1);
END;

BEGIN
    ActualizarTipoVenta(1, 'app');
END;

BEGIN
    EliminarTipoVenta(1);
END;




--------------------------------------------------------------------------------
CREATE TABLE Producto (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR2(255) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    Descripcion VARCHAR2(255) NOT NULL
);
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

/*SALIDA*/

BEGIN
    CrearProducto(1, 'Pizza Margherita', 130, 'Pizza clásica con tomate y mozzarella');
END;

BEGIN
    ObtenerProductoPorID(1);
END;

BEGIN
    ActualizarProducto(1, 'Pizza Mediana', 120, 'tiene 8 pedazos');
END;

BEGIN
    EliminarProducto(1);
END;





--------------------------------------------------------------------------------
CREATE TABLE TipoProducto (
    TipoProductoID INT PRIMARY KEY,
    Tamano VARCHAR2(10) CHECK (Tamano IN ('pequeña', 'mediana', 'grande')) NOT NULL,
    Descripcion VARCHAR2(255) NOT NULL,
    ProductoID INT,
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);
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

    DBMS_OUTPUT.PUT_LINE('Tamano: ' || v_Tamano || ', Descripcion: ' || v_Descripcion || ', ProductoID: ' || v_ProductoID);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No tipo de producto found with TipoProductoID: ' || p_TipoProductoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ACTUALIZAR*/

CREATE OR REPLACE PROCEDURE ActualizarTipoProducto(
    p_TipoProductoID IN TipoProducto.TipoProductoID%TYPE,
    p_Tamano IN TipoProducto.Tamano%TYPE,
    p_Descripcion IN TipoProducto.Descripcion%TYPE,
    p_ProductoID IN TipoProducto.ProductoID%TYPE
)
IS
BEGIN
    UPDATE TipoProducto
    SET Tamano = p_Tamano,
        Descripcion = p_Descripcion,
        ProductoID = p_ProductoID
    WHERE TipoProductoID = p_TipoProductoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No tipo de producto found with TipoProductoID: ' || p_TipoProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo de producto updated successfully');
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
        DBMS_OUTPUT.PUT_LINE('No tipo de producto found with TipoProductoID: ' || p_TipoProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo de producto deleted successfully');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*SALIDA*/
BEGIN
    CrearTipoProducto(1, 'mediana', 'Pizza mediana de estilo clásico', 1);
END;--cuando queremos crear un producto aca tiene qie ir relacionado con la tabla producto osea es decir tiene que existir en la tabla producto
--para que se pueda crear aca 

BEGIN
    ObtenerTipoProductoPorID(1);
END;

BEGIN
    ActualizarTipoProducto(1, 'mediana', 'Pizza mediana con borde relleno de queso', 1);
END;

BEGIN
    EliminarTipoProducto(1);
END;





--------------------------------------------------------------------------------
CREATE TABLE IngredientesExtra (
    IngredienteID INT PRIMARY KEY,
    Nombre VARCHAR2(255) NOT NULL,
    Descripcion VARCHAR2(255),
    Precio DECIMAL(10, 2) NOT NULL,
    ProductoID INT,
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearIngredienteExtra(
    p_IngredienteID IN IngredientesExtra.IngredienteID%TYPE,
    p_Nombre IN IngredientesExtra.Nombre%TYPE,
    p_Descripcion IN IngredientesExtra.Descripcion%TYPE,
    p_Precio IN IngredientesExtra.Precio%TYPE,
    p_ProductoID IN IngredientesExtra.ProductoID%TYPE
)
IS
    v_ProductoCount INT;
BEGIN
    -- Verifica que el ProductoID exista en la tabla Producto
    SELECT COUNT(*)
    INTO v_ProductoCount
    FROM Producto
    WHERE ProductoID = p_ProductoID;

    IF v_ProductoCount = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: ProductoID ' || p_ProductoID || ' no existe en la tabla Producto');
        RETURN;
    END IF;

    -- Inserta el nuevo IngredienteExtra
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

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Descripcion: ' || v_Descripcion || ', Precio: ' || v_Precio || ', ProductoID: ' || v_ProductoID);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No ingrediente extra found with IngredienteID: ' || p_IngredienteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarIngredienteExtra(
    p_IngredienteID IN IngredientesExtra.IngredienteID%TYPE,
    p_Nombre IN IngredientesExtra.Nombre%TYPE,
    p_Descripcion IN IngredientesExtra.Descripcion%TYPE,
    p_Precio IN IngredientesExtra.Precio%TYPE,
    p_ProductoID IN IngredientesExtra.ProductoID%TYPE
)
IS
BEGIN
    -- Verifica que el ProductoID exista en la tabla Producto
    IF p_ProductoID IS NOT NULL THEN
        DECLARE
            v_ProductoCount INT;
        BEGIN
            SELECT COUNT(*)
            INTO v_ProductoCount
            FROM Producto
            WHERE ProductoID = p_ProductoID;

            IF v_ProductoCount = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: ProductoID ' || p_ProductoID || ' no existe en la tabla Producto');
                RETURN;
            END IF;
        END;
    END IF;

    -- Actualiza el IngredienteExtra
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
CREATE OR REPLACE PROCEDURE EliminarIngredienteExtra(
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


/*SALIDA*/

BEGIN
    CrearIngredienteExtra(1, 'Olivas', 'Olivas negras', 150, 1);
END;

BEGIN
    ObtenerIngredienteExtraPorID(1);
END;

BEGIN
    ActualizarIngredienteExtra(1, 'Olivas Verdes', 'Olivas verdes', 175, 1);
END;

BEGIN
    EliminarIngredienteExtra(1);
END;




--------------------------------------------------------------------------------
CREATE TABLE Pedido (
    PedidoID INT PRIMARY KEY,
    ClienteID INT,
    SucursalID INT,
    MetodoPagoID INT,
    PromocionID INT,
    TipoVentaID INT,
    Fecha DATE NOT NULL,
    Hora DATE NOT NULL, -- Cambiado a DATE para incluir fecha y hora
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (SucursalID) REFERENCES Sucursal(SucursalID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodoPago(MetodoPagoID),
    FOREIGN KEY (PromocionID) REFERENCES Promocion(PromocionID),
    FOREIGN KEY (TipoVentaID) REFERENCES TipoVenta(TipoVentaID)
);
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
    
    DBMS_OUTPUT.PUT_LINE('Pedido creado exitosamente');
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
    SELECT ClienteID, SucursalID, MetodoPagoID, PromocionID, TipoVentaID, Fecha, Hora
    INTO v_ClienteID, v_SucursalID, v_MetodoPagoID, v_PromocionID, v_TipoVentaID, v_Fecha, v_Hora
    FROM Pedido
    WHERE PedidoID = p_PedidoID;

    DBMS_OUTPUT.PUT_LINE('PedidoID: ' || p_PedidoID ||
                         ', ClienteID: ' || v_ClienteID ||
                         ', SucursalID: ' || v_SucursalID ||
                         ', MetodoPagoID: ' || v_MetodoPagoID ||
                         ', PromocionID: ' || v_PromocionID ||
                         ', TipoVentaID: ' || v_TipoVentaID ||
                         ', Fecha: ' || TO_CHAR(v_Fecha, 'YYYY-MM-DD') ||
                         ', Hora: ' || TO_CHAR(v_Hora, 'HH24:MI:SS'));
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

/*SALIDA*/
BEGIN
    CrearPedido(1, 1, 1, 1, 1, 1, TO_DATE('2024-07-24', 'YYYY-MM-DD'), TO_DATE('2024-07-24 15:30:00', 'YYYY-MM-DD HH24:MI:SS'));
END;

BEGIN
    ObtenerPedidoPorID(1);
END;

BEGIN
    ActualizarPedido(1, 2, 2, 2, 2, 2, TO_DATE('2024-07-25', 'YYYY-MM-DD'), TO_DATE('2024-07-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
END;
BEGIN
    EliminarPedido(1);
END;
--------------------------------------------------------------------------------

CREATE TABLE DetalleCompra (
    DetallePedidoID INT PRIMARY KEY,
    PedidoID INT,
    ProductoID INT,
    IngredienteExtraID INT,
    CantidadProductos INT NOT NULL,
    PrecioUni DECIMAL(10, 2) NOT NULL,
    PrecioTotal DECIMAL(10, 2) NOT NULL,
    PrecioIva DECIMAL(10, 2) NOT NULL,
    PrecioTotalDescuento DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    FOREIGN KEY (IngredienteExtraID) REFERENCES IngredientesExtra(IngredienteID)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearDetalleCompra(
    p_DetallePedidoID IN DetalleCompra.DetallePedidoID%TYPE,
    p_PedidoID IN DetalleCompra.PedidoID%TYPE,
    p_ProductoID IN DetalleCompra.ProductoID%TYPE,
    p_IngredienteExtraID IN DetalleCompra.IngredienteExtraID%TYPE,
    p_CantidadProductos IN DetalleCompra.CantidadProductos%TYPE,
    p_PrecioUni IN DetalleCompra.PrecioUni%TYPE,
    p_PrecioTotal IN DetalleCompra.PrecioTotal%TYPE,
    p_PrecioIva IN DetalleCompra.PrecioIva%TYPE,
    p_PrecioTotalDescuento IN DetalleCompra.PrecioTotalDescuento%TYPE
)
IS
BEGIN
    INSERT INTO DetalleCompra (
        DetallePedidoID, PedidoID, ProductoID, IngredienteExtraID, 
        CantidadProductos, PrecioUni, PrecioTotal, PrecioIva, PrecioTotalDescuento
    ) VALUES (
        p_DetallePedidoID, p_PedidoID, p_ProductoID, p_IngredienteExtraID, 
        p_CantidadProductos, p_PrecioUni, p_PrecioTotal, p_PrecioIva, p_PrecioTotalDescuento
    );

    DBMS_OUTPUT.PUT_LINE('Detalle de compra creado exitosamente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*LEER*/

CREATE OR REPLACE PROCEDURE ObtenerDetalleCompraPorID(
    p_DetallePedidoID IN DetalleCompra.DetallePedidoID%TYPE
)
IS
    v_PedidoID DetalleCompra.PedidoID%TYPE;
    v_ProductoID DetalleCompra.ProductoID%TYPE;
    v_IngredienteExtraID DetalleCompra.IngredienteExtraID%TYPE;
    v_CantidadProductos DetalleCompra.CantidadProductos%TYPE;
    v_PrecioUni DetalleCompra.PrecioUni%TYPE;
    v_PrecioTotal DetalleCompra.PrecioTotal%TYPE;
    v_PrecioIva DetalleCompra.PrecioIva%TYPE;
    v_PrecioTotalDescuento DetalleCompra.PrecioTotalDescuento%TYPE;
BEGIN
    SELECT PedidoID, ProductoID, IngredienteExtraID, CantidadProductos, PrecioUni, PrecioTotal, PrecioIva, PrecioTotalDescuento
    INTO v_PedidoID, v_ProductoID, v_IngredienteExtraID, v_CantidadProductos, v_PrecioUni, v_PrecioTotal, v_PrecioIva, v_PrecioTotalDescuento
    FROM DetalleCompra
    WHERE DetallePedidoID = p_DetallePedidoID;

    DBMS_OUTPUT.PUT_LINE('PedidoID: ' || v_PedidoID || ', ProductoID: ' || v_ProductoID || ', IngredienteExtraID: ' || v_IngredienteExtraID ||
                         ', CantidadProductos: ' || v_CantidadProductos || ', PrecioUni: ' || v_PrecioUni || ', PrecioTotal: ' || v_PrecioTotal ||
                         ', PrecioIva: ' || v_PrecioIva || ', PrecioTotalDescuento: ' || v_PrecioTotalDescuento);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el detalle de compra con DetallePedidoID: ' || p_DetallePedidoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarDetalleCompra(
    p_DetallePedidoID IN DetalleCompra.DetallePedidoID%TYPE,
    p_PedidoID IN DetalleCompra.PedidoID%TYPE,
    p_ProductoID IN DetalleCompra.ProductoID%TYPE,
    p_IngredienteExtraID IN DetalleCompra.IngredienteExtraID%TYPE,
    p_CantidadProductos IN DetalleCompra.CantidadProductos%TYPE,
    p_PrecioUni IN DetalleCompra.PrecioUni%TYPE,
    p_PrecioTotal IN DetalleCompra.PrecioTotal%TYPE,
    p_PrecioIva IN DetalleCompra.PrecioIva%TYPE,
    p_PrecioTotalDescuento IN DetalleCompra.PrecioTotalDescuento%TYPE
)
IS
BEGIN
    UPDATE DetalleCompra
    SET PedidoID = p_PedidoID,
        ProductoID = p_ProductoID,
        IngredienteExtraID = p_IngredienteExtraID,
        CantidadProductos = p_CantidadProductos,
        PrecioUni = p_PrecioUni,
        PrecioTotal = p_PrecioTotal,
        PrecioIva = p_PrecioIva,
        PrecioTotalDescuento = p_PrecioTotalDescuento
    WHERE DetallePedidoID = p_DetallePedidoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el detalle de compra con DetallePedidoID: ' || p_DetallePedidoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Detalle de compra actualizado exitosamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarDetalleCompra(
    p_DetallePedidoID IN DetalleCompra.DetallePedidoID%TYPE
)
IS
BEGIN
    DELETE FROM DetalleCompra
    WHERE DetallePedidoID = p_DetallePedidoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el detalle de compra con DetallePedidoID: ' || p_DetallePedidoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Detalle de compra eliminado exitosamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*SALIDA*/
BEGIN
    CrearDetalleCompra(
        1, -- DetallePedidoID
        1, -- PedidoID
        1, -- ProductoID
        1, -- IngredienteExtraID
        2, -- CantidadProductos
        130, -- PrecioUni
        260, -- PrecioTotal
        20, -- PrecioIva
        280 -- PrecioTotalDescuento
    );
END;
BEGIN
    ObtenerDetalleCompraPorID(1);
END;

BEGIN
    ActualizarDetalleCompra(
        1, -- DetallePedidoID
        1, -- PedidoID
        1, -- ProductoID
        1, -- IngredienteExtraID
        3, -- CantidadProductos
        130, -- PrecioUni
        390, -- PrecioTotal
        30, -- PrecioIva
        420 -- PrecioTotalDescuento
    );
END;

BEGIN
    EliminarDetalleCompra(1);
END;
--------------------------------------------------------------------------------
CREATE TABLE Reportes (
    ReporteID INT PRIMARY KEY,
    Descripcion VARCHAR2(255),
    FechaGeneracion DATE NOT NULL
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearReporte(
    p_ReporteID IN Reportes.ReporteID%TYPE,
    p_Descripcion IN Reportes.Descripcion%TYPE,
    p_FechaGeneracion IN Reportes.FechaGeneracion%TYPE
)
IS
BEGIN
    INSERT INTO Reportes (ReporteID, Descripcion, FechaGeneracion)
    VALUES (p_ReporteID, p_Descripcion, p_FechaGeneracion);

    DBMS_OUTPUT.PUT_LINE('Reporte creado exitosamente');
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
    SELECT Descripcion, FechaGeneracion
    INTO v_Descripcion, v_FechaGeneracion
    FROM Reportes
    WHERE ReporteID = p_ReporteID;

    DBMS_OUTPUT.PUT_LINE('Descripcion: ' || v_Descripcion || ', FechaGeneracion: ' || TO_CHAR(v_FechaGeneracion, 'DD-MON-YYYY'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el reporte con ReporteID: ' || p_ReporteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarReporte(
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
        DBMS_OUTPUT.PUT_LINE('No se encontró el reporte con ReporteID: ' || p_ReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Reporte actualizado exitosamente');
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
    DELETE FROM Reportes
    WHERE ReporteID = p_ReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el reporte con ReporteID: ' || p_ReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Reporte eliminado exitosamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*SALIDA*/
BEGIN
    CrearReporte(
        1, 'Reporte de ventas del mes', SYSDATE );
END;

BEGIN
    ObtenerReportePorID(1);
END;
BEGIN
    ActualizarReporte(
        1,  'Reporte de ventas del trimestre', SYSDATE );
END;
BEGIN
    EliminarReporte(1);
END;

--------------------------------------------------------------------------------
CREATE TABLE DetalleReporte (
    DetalleReporteID INT PRIMARY KEY,
    ReporteID INT,
    ClienteID INT,
    PedidoID INT,
    TotalPedidos INT NOT NULL,
    TotalGasto DECIMAL(10, 2) NOT NULL,
    FrecuenciaPedidos INT NOT NULL,
    FOREIGN KEY (ReporteID) REFERENCES Reportes(ReporteID),
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID)
);
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
    INSERT INTO DetalleReporte (
        DetalleReporteID, 
        ReporteID, 
        ClienteID, 
        PedidoID, 
        TotalPedidos, 
        TotalGasto, 
        FrecuenciaPedidos
    )
    VALUES (
        p_DetalleReporteID, 
        p_ReporteID, 
        p_ClienteID, 
        p_PedidoID, 
        p_TotalPedidos, 
        p_TotalGasto, 
        p_FrecuenciaPedidos
    );

    DBMS_OUTPUT.PUT_LINE('DetalleReporte creado exitosamente');
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
    SELECT 
        ReporteID, 
        ClienteID, 
        PedidoID, 
        TotalPedidos, 
        TotalGasto, 
        FrecuenciaPedidos
    INTO 
        v_ReporteID, 
        v_ClienteID, 
        v_PedidoID, 
        v_TotalPedidos, 
        v_TotalGasto, 
        v_FrecuenciaPedidos
    FROM 
        DetalleReporte
    WHERE 
        DetalleReporteID = p_DetalleReporteID;

    DBMS_OUTPUT.PUT_LINE('ReporteID: ' || v_ReporteID || 
                         ', ClienteID: ' || v_ClienteID || 
                         ', PedidoID: ' || v_PedidoID || 
                         ', TotalPedidos: ' || v_TotalPedidos || 
                         ', TotalGasto: ' || v_TotalGasto || 
                         ', FrecuenciaPedidos: ' || v_FrecuenciaPedidos);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el detalle del reporte con DetalleReporteID: ' || p_DetalleReporteID);
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
    SET 
        ReporteID = p_ReporteID,
        ClienteID = p_ClienteID,
        PedidoID = p_PedidoID,
        TotalPedidos = p_TotalPedidos,
        TotalGasto = p_TotalGasto,
        FrecuenciaPedidos = p_FrecuenciaPedidos
    WHERE 
        DetalleReporteID = p_DetalleReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el detalle del reporte con DetalleReporteID: ' || p_DetalleReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('DetalleReporte actualizado exitosamente');
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
    DELETE FROM DetalleReporte
    WHERE DetalleReporteID = p_DetalleReporteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el detalle del reporte con DetalleReporteID: ' || p_DetalleReporteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('DetalleReporte eliminado exitosamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


/*SALIDA*/
BEGIN
    CrearDetalleReporte(
        1, -- DetalleReporteID
        1, -- ReporteID
        1, -- ClienteID
        1, -- PedidoID
        5, -- TotalPedidos
        150, -- TotalGasto
        3 -- FrecuenciaPedidos
    );
END;
BEGIN
    ObtenerDetalleReportePorID(1);
END;
BEGIN
    ActualizarDetalleReporte(
        1, -- DetalleReporteID
        2, -- ReporteID
        2, -- ClienteID
        2, -- PedidoID
        10, -- TotalPedidos
        300.00, -- TotalGasto
        6 -- FrecuenciaPedidos
    );
END;
BEGIN
    EliminarDetalleReporte(1);
END;

