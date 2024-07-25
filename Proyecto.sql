SET SERVEROUTPUT ON
CREATE TABLE Sucursal (
    SucursalID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Dirección VARCHAR(200) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Provincia VARCHAR(100) NOT NULL,
    Teléfono VARCHAR(15)
);
/*EMPEZAMOS CON EL CRUD LA LA TABLA SOCURSAL*/
/*PRIMERO HACEMOS EL PROCESAMIENTO ALMACENADO*/
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearSucursal(
    p_SucursalID IN Sucursal.SucursalID%TYPE,
    p_Nombre IN Sucursal.Nombre%TYPE,
    p_Dirección IN Sucursal.Dirección%TYPE,
    p_Ciudad IN Sucursal.Ciudad%TYPE,
    p_Provincia IN Sucursal.Provincia%TYPE,
    p_Teléfono IN Sucursal.Teléfono%TYPE
)
IS
BEGIN
    INSERT INTO Sucursal (SucursalID, Nombre, Dirección, Ciudad, Provincia, Teléfono)
    VALUES (p_SucursalID, p_Nombre, p_Dirección, p_Ciudad, p_Provincia, p_Teléfono);
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
    v_Dirección Sucursal.Dirección%TYPE;
    v_Ciudad Sucursal.Ciudad%TYPE;
    v_Provincia Sucursal.Provincia%TYPE;
    v_Teléfono Sucursal.Teléfono%TYPE;
BEGIN
    SELECT Nombre, Dirección, Ciudad, Provincia, Teléfono 
    INTO v_Nombre, v_Dirección, v_Ciudad, v_Provincia, v_Teléfono
    FROM Sucursal
    WHERE SucursalID = p_SucursalID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Dirección: ' || v_Dirección || ', Ciudad: ' || v_Ciudad || ', Provincia: ' || v_Provincia || ', Teléfono: ' || v_Teléfono);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró una sucursal con SucursalID: ' || p_SucursalID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarSucursal(
    p_SucursalID IN Sucursal.SucursalID%TYPE,
    p_Nombre IN Sucursal.Nombre%TYPE,
    p_Dirección IN Sucursal.Dirección%TYPE,
    p_Ciudad IN Sucursal.Ciudad%TYPE,
    p_Provincia IN Sucursal.Provincia%TYPE,
    p_Teléfono IN Sucursal.Teléfono%TYPE
)
IS
BEGIN
    UPDATE Sucursal
    SET Nombre = p_Nombre, Dirección = p_Dirección, Ciudad = p_Ciudad, Provincia = p_Provincia, Teléfono = p_Teléfono
    WHERE SucursalID = p_SucursalID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró una sucursal con SucursalID: ' || p_SucursalID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sucursal actualizada correctamente');
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
        DBMS_OUTPUT.PUT_LINE('No se encontró una sucursal con SucursalID: ' || p_SucursalID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sucursal eliminada correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/

BEGIN
    CrearSucursal(1, 'Sucursal Central', 'Calle 123', 'San José', 'San José', '12345678');
END;
BEGIN
    CrearSucursal(2, 'Sucursal 2', 'Calle 345', 'Alajuela', 'Alajuela', '888888888');
END;

BEGIN
    ObtenerSucursalPorID(2);
END;

BEGIN
    ActualizarSucursal(1, 'Sucursal Central Actualizada', 'Avenida 456', 'San José', 'San José', '87654321');
END;

BEGIN
    ActualizarSucursal(2, 'Sucursal 2 ACTUALIZADA', 'Calle 375', 'Alajuela', 'Alajuela', '888887788');
END;

BEGIN
    EliminarSucursal(1);/* eliminamos la socursal requerida*/
END;


-----------------------------------------------------------------------------------------------------
CREATE TABLE Empleado (
    EmpleadoID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    SucursalID INT,
    FOREIGN KEY (SucursalID) REFERENCES Sucursal(SucursalID)
);
/*PROCEDIMIENTOS ALMACENADOS*/
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearEmpleado(
    p_EmpleadoID IN Empleado.EmpleadoID%TYPE,
    p_Nombre IN Empleado.Nombre%TYPE,
    p_Apellido IN Empleado.Apellido%TYPE,
    p_Cargo IN Empleado.Cargo%TYPE,
    p_SucursalID IN Empleado.SucursalID%TYPE
)
IS
BEGIN
    INSERT INTO Empleado (EmpleadoID, Nombre, Apellido, Cargo, SucursalID)
    VALUES (p_EmpleadoID, p_Nombre, p_Apellido, p_Cargo, p_SucursalID);
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
    v_Apellido Empleado.Apellido%TYPE;
    v_Cargo Empleado.Cargo%TYPE;
    v_SucursalID Empleado.SucursalID%TYPE;
BEGIN
    SELECT Nombre, Apellido, Cargo, SucursalID
    INTO v_Nombre, v_Apellido, v_Cargo, v_SucursalID
    FROM Empleado
    WHERE EmpleadoID = p_EmpleadoID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Apellido: ' || v_Apellido || ', Cargo: ' || v_Cargo || ', SucursalID: ' || v_SucursalID);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un empleado con EmpleadoID: ' || p_EmpleadoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarEmpleado(
    p_EmpleadoID IN Empleado.EmpleadoID%TYPE,
    p_Nombre IN Empleado.Nombre%TYPE,
    p_Apellido IN Empleado.Apellido%TYPE,
    p_Cargo IN Empleado.Cargo%TYPE,
    p_SucursalID IN Empleado.SucursalID%TYPE
)
IS
BEGIN
    UPDATE Empleado
    SET Nombre = p_Nombre, Apellido = p_Apellido, Cargo = p_Cargo, SucursalID = p_SucursalID
    WHERE EmpleadoID = p_EmpleadoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un empleado con EmpleadoID: ' || p_EmpleadoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Empleado actualizado correctamente');
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
        DBMS_OUTPUT.PUT_LINE('No se encontró un empleado con EmpleadoID: ' || p_EmpleadoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Empleado eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*SALIDA*/
BEGIN
    CrearEmpleado(1, 'Paula', 'Cordero', 'Chef', 2);
END;
BEGIN
    CrearEmpleado(2, 'María', 'Segura', 'Asistente', 2);
END;

BEGIN
    ObtenerEmpleadoPorID(2);
END;
BEGIN
    ActualizarEmpleado(2, 'Antony', 'Garcia', 'Director', 2);
END;
BEGIN
    EliminarEmpleado(1);
END;

-----------------------------------------------------------------------------------------------------
CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Dirección VARCHAR(200),
    Ciudad VARCHAR(100),
    Provincia VARCHAR(100),
    Teléfono VARCHAR(15),
    Email VARCHAR(100)
);
/*FUNCIONES*/
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearCliente(
    p_ClienteID IN Cliente.ClienteID%TYPE,
    p_Nombre IN Cliente.Nombre%TYPE,
    p_Apellido IN Cliente.Apellido%TYPE,
    p_Direccion IN Cliente.Dirección%TYPE,
    p_Ciudad IN Cliente.Ciudad%TYPE,
    p_Provincia IN Cliente.Provincia%TYPE,
    p_Telefono IN Cliente.Teléfono%TYPE,
    p_Email IN Cliente.Email%TYPE
)
IS
BEGIN
    INSERT INTO Cliente (ClienteID, Nombre, Apellido, Dirección, Ciudad, Provincia, Teléfono, Email)
    VALUES (p_ClienteID, p_Nombre, p_Apellido, p_Direccion, p_Ciudad, p_Provincia, p_Telefono, p_Email);
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
    v_Apellido Cliente.Apellido%TYPE;
    v_Direccion Cliente.Dirección%TYPE;
    v_Ciudad Cliente.Ciudad%TYPE;
    v_Provincia Cliente.Provincia%TYPE;
    v_Telefono Cliente.Teléfono%TYPE;
    v_Email Cliente.Email%TYPE;
BEGIN
    SELECT Nombre, Apellido, Dirección, Ciudad, Provincia, Teléfono, Email
    INTO v_Nombre, v_Apellido, v_Direccion, v_Ciudad, v_Provincia, v_Telefono, v_Email
    FROM Cliente
    WHERE ClienteID = p_ClienteID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Apellido: ' || v_Apellido || ', Dirección: ' || v_Direccion || ', Ciudad: ' || v_Ciudad || ', Provincia: ' || v_Provincia || ', Teléfono: ' || v_Telefono || ', Email: ' || v_Email);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un cliente con ClienteID: ' || p_ClienteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarCliente(
    p_ClienteID IN Cliente.ClienteID%TYPE,
    p_Nombre IN Cliente.Nombre%TYPE,
    p_Apellido IN Cliente.Apellido%TYPE,
    p_Direccion IN Cliente.Dirección%TYPE,
    p_Ciudad IN Cliente.Ciudad%TYPE,
    p_Provincia IN Cliente.Provincia%TYPE,
    p_Telefono IN Cliente.Teléfono%TYPE,
    p_Email IN Cliente.Email%TYPE
)
IS
BEGIN
    UPDATE Cliente
    SET Nombre = p_Nombre, Apellido = p_Apellido, Dirección = p_Direccion, Ciudad = p_Ciudad, Provincia = p_Provincia, Teléfono = p_Telefono, Email = p_Email
    WHERE ClienteID = p_ClienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un cliente con ClienteID: ' || p_ClienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente actualizado correctamente');
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
        DBMS_OUTPUT.PUT_LINE('No se encontró un cliente con ClienteID: ' || p_ClienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/
BEGIN
    CrearCliente(1, 'Arianna', 'Retana', 'Paraiso ', 'Cartago', 'Cartago', '87654321', 'ari.reta@gmail.com');
END;
BEGIN
    CrearCliente(2, 'Camila', 'Ulloa', 'Ochomogo', 'Cartago', 'Cartago', '37474838', 'cami.ollu@gmail.com');
END;
BEGIN
    CrearCliente(3, 'Jose', 'Mora', 'Avenida Central', 'San José', 'San José', '93298723', 'jos.mora@gmail.com');
END;
BEGIN
    ObtenerClientePorID(3);
END;
BEGIN
    ActualizarCliente(1, 'Arianna', 'Retana', 'Paraiso ', 'Cartago', 'Cartago', '87654321', 'ari.reta_nuevo1@gmail.com');
END;

BEGIN
    EliminarCliente(1);
END;
-------------------------------------------------------------------------------------------------------
--4
CREATE TABLE Pedido (
    PedidoID INT PRIMARY KEY,
    ClienteID INT,
    EmpleadoID INT,
    Fecha DATE NOT NULL,
    Hora TIMESTAMP NOT NULL, 
    Total DECIMAL(10, 2) NOT NULL,
    Estado VARCHAR2(50) NOT NULL,  
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearPedido(
    p_PedidoID IN Pedido.PedidoID%TYPE,
    p_ClienteID IN Pedido.ClienteID%TYPE,
    p_EmpleadoID IN Pedido.EmpleadoID%TYPE,
    p_Fecha IN Pedido.Fecha%TYPE,
    p_Hora IN Pedido.Hora%TYPE,
    p_Total IN Pedido.Total%TYPE,
    p_Estado IN Pedido.Estado%TYPE
)
IS
BEGIN
    INSERT INTO Pedido (PedidoID, ClienteID, EmpleadoID, Fecha, Hora, Total, Estado)
    VALUES (p_PedidoID, p_ClienteID, p_EmpleadoID, p_Fecha, p_Hora, p_Total, p_Estado);
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
    v_EmpleadoID Pedido.EmpleadoID%TYPE;
    v_Fecha Pedido.Fecha%TYPE;
    v_Hora Pedido.Hora%TYPE;
    v_Total Pedido.Total%TYPE;
    v_Estado Pedido.Estado%TYPE;
BEGIN
    SELECT ClienteID, EmpleadoID, Fecha, Hora, Total, Estado
    INTO v_ClienteID, v_EmpleadoID, v_Fecha, v_Hora, v_Total, v_Estado
    FROM Pedido
    WHERE PedidoID = p_PedidoID;

    DBMS_OUTPUT.PUT_LINE('ClienteID: ' || v_ClienteID || ', EmpleadoID: ' || v_EmpleadoID || ', Fecha: ' || v_Fecha || ', Hora: ' || v_Hora || ', Total: ' || v_Total || ', Estado: ' || v_Estado);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un pedido con PedidoID: ' || p_PedidoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarPedido(
    p_PedidoID IN Pedido.PedidoID%TYPE,
    p_ClienteID IN Pedido.ClienteID%TYPE,
    p_EmpleadoID IN Pedido.EmpleadoID%TYPE,
    p_Fecha IN Pedido.Fecha%TYPE,
    p_Hora IN Pedido.Hora%TYPE,
    p_Total IN Pedido.Total%TYPE,
    p_Estado IN Pedido.Estado%TYPE
)
IS
BEGIN
    UPDATE Pedido
    SET ClienteID = p_ClienteID, EmpleadoID = p_EmpleadoID, Fecha = p_Fecha, Hora = p_Hora, Total = p_Total, Estado = p_Estado
    WHERE PedidoID = p_PedidoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un pedido con PedidoID: ' || p_PedidoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pedido actualizado correctamente');
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
        DBMS_OUTPUT.PUT_LINE('No se encontró un pedido con PedidoID: ' || p_PedidoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pedido eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/
BEGIN
    CrearPedido(1, 1, 1, TO_DATE('2024-07-23', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-07-23 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1550, 'Pendiente');
END;

BEGIN
    CrearPedido(2, 3, 2, TO_DATE('2024-08-07', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-08-07 5:00:00', 'YYYY-MM-DD HH24:MI:SS'), 12000, 'Pendiente');
END;
BEGIN
    ObtenerPedidoPorID(1);
END;
BEGIN
    ActualizarPedido(1, 1, 1, TO_DATE('2024-07-23', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-07-23 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000, 'Completo');
END;
BEGIN
    EliminarPedido(1);
END;


------------------------------------------------------------------------------------------
--5
CREATE TABLE Producto (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción VARCHAR(200),
    Precio DECIMAL(10, 2) NOT NULL
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearProducto(
    p_ProductoID IN Producto.ProductoID%TYPE,
    p_Nombre IN Producto.Nombre%TYPE,
    p_Descripcion IN Producto.Descripción%TYPE,
    p_Precio IN Producto.Precio%TYPE
)
IS
BEGIN
    INSERT INTO Producto (ProductoID, Nombre, Descripción, Precio)
    VALUES (p_ProductoID, p_Nombre, p_Descripcion, p_Precio);
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
    v_Descripcion Producto.Descripción%TYPE;
    v_Precio Producto.Precio%TYPE;
BEGIN
    SELECT Nombre, Descripción, Precio
    INTO v_Nombre, v_Descripcion, v_Precio
    FROM Producto
    WHERE ProductoID = p_ProductoID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Descripción: ' || v_Descripcion || ', Precio: ' || v_Precio);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un producto con ProductoID: ' || p_ProductoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarProducto(
    p_ProductoID IN Producto.ProductoID%TYPE,
    p_Nombre IN Producto.Nombre%TYPE,
    p_Descripcion IN Producto.Descripción%TYPE,
    p_Precio IN Producto.Precio%TYPE
)
IS
BEGIN
    UPDATE Producto
    SET Nombre = p_Nombre, Descripción = p_Descripcion, Precio = p_Precio
    WHERE ProductoID = p_ProductoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un producto con ProductoID: ' || p_ProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Producto actualizado correctamente');
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
        DBMS_OUTPUT.PUT_LINE('No se encontró un producto con ProductoID: ' || p_ProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Producto eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/
BEGIN
    CrearProducto(1, 'Pizza Mediana', 'Pizza de 8 pedazos', 8000);
END;
BEGIN
    CrearProducto(2, 'Pizza Grande', 'Pizza de 16 pedazos', 10000);
END;
BEGIN
    CrearProducto(3, 'Pizza pequena', 'Pizza de 4 pedazos', 4000);
END;
BEGIN
    ObtenerProductoPorID(1);
END;
BEGIN
    ActualizarProducto(1, 'Pizza mediana Actualizado', 'ahora son 10!!!', 8000);
END;
BEGIN
    EliminarProducto(1);
END;





------------------------------------------------------------------------------------------
--6
CREATE TABLE PedidoProducto (
    PedidoID INT,
    ProductoID INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (PedidoID, ProductoID),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearPedidoProducto(
    p_PedidoID IN PedidoProducto.PedidoID%TYPE,
    p_ProductoID IN PedidoProducto.ProductoID%TYPE,
    p_Cantidad IN PedidoProducto.Cantidad%TYPE,
    p_PrecioUnitario IN PedidoProducto.PrecioUnitario%TYPE
)
IS
BEGIN
    INSERT INTO PedidoProducto (PedidoID, ProductoID, Cantidad, PrecioUnitario)
    VALUES (p_PedidoID, p_ProductoID, p_Cantidad, p_PrecioUnitario);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerPedidoProducto(
    p_PedidoID IN PedidoProducto.PedidoID%TYPE,
    p_ProductoID IN PedidoProducto.ProductoID%TYPE
)
IS
    v_Cantidad PedidoProducto.Cantidad%TYPE;
    v_PrecioUnitario PedidoProducto.PrecioUnitario%TYPE;
BEGIN
    SELECT Cantidad, PrecioUnitario
    INTO v_Cantidad, v_PrecioUnitario
    FROM PedidoProducto
    WHERE PedidoID = p_PedidoID AND ProductoID = p_ProductoID;

    DBMS_OUTPUT.PUT_LINE('Cantidad: ' || v_Cantidad || ', PrecioUnitario: ' || v_PrecioUnitario);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con PedidoID: ' || p_PedidoID || ' y ProductoID: ' || p_ProductoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarPedidoProducto(
    p_PedidoID IN PedidoProducto.PedidoID%TYPE,
    p_ProductoID IN PedidoProducto.ProductoID%TYPE,
    p_Cantidad IN PedidoProducto.Cantidad%TYPE,
    p_PrecioUnitario IN PedidoProducto.PrecioUnitario%TYPE
)
IS
BEGIN
    UPDATE PedidoProducto
    SET Cantidad = p_Cantidad, PrecioUnitario = p_PrecioUnitario
    WHERE PedidoID = p_PedidoID AND ProductoID = p_ProductoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con PedidoID: ' || p_PedidoID || ' y ProductoID: ' || p_ProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Registro actualizado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarPedidoProducto(
    p_PedidoID IN PedidoProducto.PedidoID%TYPE,
    p_ProductoID IN PedidoProducto.ProductoID%TYPE
)
IS
BEGIN
    DELETE FROM PedidoProducto
    WHERE PedidoID = p_PedidoID AND ProductoID = p_ProductoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con PedidoID: ' || p_PedidoID || ' y ProductoID: ' || p_ProductoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Registro eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/
BEGIN
    CrearPedidoProducto(1, 1, 10, 1500);
END;
BEGIN
    ObtenerPedidoProducto(1, 1);
END;
BEGIN
    ActualizarPedidoProducto(1, 1, 20, 1800);
END;

BEGIN
    EliminarPedidoProducto(1, 1);
END;


--------------------------------------------------------------------------------------------
--7
CREATE TABLE Ingrediente (
    IngredienteID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción VARCHAR(200)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearIngrediente(
    p_IngredienteID IN Ingrediente.IngredienteID%TYPE,
    p_Nombre IN Ingrediente.Nombre%TYPE,
    p_Descripción IN Ingrediente.Descripción%TYPE
)
IS
BEGIN
    INSERT INTO Ingrediente (IngredienteID, Nombre, Descripción)
    VALUES (p_IngredienteID, p_Nombre, p_Descripción);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerIngredientePorID(
    p_IngredienteID IN Ingrediente.IngredienteID%TYPE
)
IS
    v_Nombre Ingrediente.Nombre%TYPE;
    v_Descripción Ingrediente.Descripción%TYPE;
BEGIN
    SELECT Nombre, Descripción
    INTO v_Nombre, v_Descripción
    FROM Ingrediente
    WHERE IngredienteID = p_IngredienteID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Descripción: ' || v_Descripción);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un ingrediente con IngredienteID: ' || p_IngredienteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarIngrediente(
    p_IngredienteID IN Ingrediente.IngredienteID%TYPE,
    p_Nombre IN Ingrediente.Nombre%TYPE,
    p_Descripción IN Ingrediente.Descripción%TYPE
)
IS
BEGIN
    UPDATE Ingrediente
    SET Nombre = p_Nombre, Descripción = p_Descripción
    WHERE IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un ingrediente con IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ingrediente actualizado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarIngrediente(
    p_IngredienteID IN Ingrediente.IngredienteID%TYPE
)
IS
BEGIN
    DELETE FROM Ingrediente
    WHERE IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un ingrediente con IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ingrediente eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/

BEGIN
    CrearIngrediente(1, 'Masa', 'Ingrediente para la base de la pizza');
END;
BEGIN
    ObtenerIngredientePorID(1);
END;

BEGIN
    ActualizarIngrediente(1, 'Masa', 'Ingrediente para poner los demas ingredientes de la pizza');
END;
BEGIN
    EliminarIngrediente(1);
END;


------------------------------------------------------------------------------------------

CREATE TABLE ProductoIngrediente (
    ProductoID INT,
    IngredienteID INT,
    Cantidad DECIMAL(10, 2) NOT NULL,
    Unidad VARCHAR(50) NOT NULL,
    PRIMARY KEY (ProductoID, IngredienteID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    FOREIGN KEY (IngredienteID) REFERENCES Ingrediente(IngredienteID)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearProductoIngrediente(
    p_ProductoID IN ProductoIngrediente.ProductoID%TYPE,
    p_IngredienteID IN ProductoIngrediente.IngredienteID%TYPE,
    p_Cantidad IN ProductoIngrediente.Cantidad%TYPE,
    p_Unidad IN ProductoIngrediente.Unidad%TYPE
)
IS
BEGIN
    INSERT INTO ProductoIngrediente (ProductoID, IngredienteID, Cantidad, Unidad)
    VALUES (p_ProductoID, p_IngredienteID, p_Cantidad, p_Unidad);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerProductoIngrediente(
    p_ProductoID IN ProductoIngrediente.ProductoID%TYPE,
    p_IngredienteID IN ProductoIngrediente.IngredienteID%TYPE
)
IS
    v_Cantidad ProductoIngrediente.Cantidad%TYPE;
    v_Unidad ProductoIngrediente.Unidad%TYPE;
BEGIN
    SELECT Cantidad, Unidad
    INTO v_Cantidad, v_Unidad
    FROM ProductoIngrediente
    WHERE ProductoID = p_ProductoID AND IngredienteID = p_IngredienteID;

    DBMS_OUTPUT.PUT_LINE('Cantidad: ' || v_Cantidad || ', Unidad: ' || v_Unidad);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con ProductoID: ' || p_ProductoID || ' e IngredienteID: ' || p_IngredienteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarProductoIngrediente(
    p_ProductoID IN ProductoIngrediente.ProductoID%TYPE,
    p_IngredienteID IN ProductoIngrediente.IngredienteID%TYPE,
    p_Cantidad IN ProductoIngrediente.Cantidad%TYPE,
    p_Unidad IN ProductoIngrediente.Unidad%TYPE
)
IS
BEGIN
    UPDATE ProductoIngrediente
    SET Cantidad = p_Cantidad, Unidad = p_Unidad
    WHERE ProductoID = p_ProductoID AND IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con ProductoID: ' || p_ProductoID || ' e IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Registro actualizado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarProductoIngrediente(
    p_ProductoID IN ProductoIngrediente.ProductoID%TYPE,
    p_IngredienteID IN ProductoIngrediente.IngredienteID%TYPE
)
IS
BEGIN
    DELETE FROM ProductoIngrediente
    WHERE ProductoID = p_ProductoID AND IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con ProductoID: ' || p_ProductoID || ' e IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Registro eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*SALIDA*/
BEGIN
    CrearProductoIngrediente(1, 1, 500, 'Gramos');
END;

BEGIN
    ObtenerProductoIngrediente(1, 1);
END;

BEGIN
    ActualizarProductoIngrediente(1, 1, 250, 'Mililitros');
END;
BEGIN
    EliminarProductoIngrediente(1, 1);
END;


---------------------------------------------------------------------------------------------
--9
CREATE TABLE Proveedor (
    ProveedorID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Dirección VARCHAR(200),
    Teléfono VARCHAR(15),
    Email VARCHAR(100)
);

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearProveedor(
    p_ProveedorID IN Proveedor.ProveedorID%TYPE,
    p_Nombre IN Proveedor.Nombre%TYPE,
    p_Dirección IN Proveedor.Dirección%TYPE,
    p_Teléfono IN Proveedor.Teléfono%TYPE,
    p_Email IN Proveedor.Email%TYPE
)
IS
BEGIN
    INSERT INTO Proveedor (ProveedorID, Nombre, Dirección, Teléfono, Email)
    VALUES (p_ProveedorID, p_Nombre, p_Dirección, p_Teléfono, p_Email);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerProveedorPorID(
    p_ProveedorID IN Proveedor.ProveedorID%TYPE
)
IS
    v_Nombre Proveedor.Nombre%TYPE;
    v_Dirección Proveedor.Dirección%TYPE;
    v_Teléfono Proveedor.Teléfono%TYPE;
    v_Email Proveedor.Email%TYPE;
BEGIN
    SELECT Nombre, Dirección, Teléfono, Email
    INTO v_Nombre, v_Dirección, v_Teléfono, v_Email
    FROM Proveedor
    WHERE ProveedorID = p_ProveedorID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Dirección: ' || v_Dirección || ', Teléfono: ' || v_Teléfono || ', Email: ' || v_Email);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un proveedor con ProveedorID: ' || p_ProveedorID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarProveedor(
    p_ProveedorID IN Proveedor.ProveedorID%TYPE,
    p_Nombre IN Proveedor.Nombre%TYPE,
    p_Dirección IN Proveedor.Dirección%TYPE,
    p_Teléfono IN Proveedor.Teléfono%TYPE,
    p_Email IN Proveedor.Email%TYPE
)
IS
BEGIN
    UPDATE Proveedor
    SET Nombre = p_Nombre,
        Dirección = p_Dirección,
        Teléfono = p_Teléfono,
        Email = p_Email
    WHERE ProveedorID = p_ProveedorID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un proveedor con ProveedorID: ' || p_ProveedorID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Proveedor actualizado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarProveedor(
    p_ProveedorID IN Proveedor.ProveedorID%TYPE
)
IS
BEGIN
    DELETE FROM Proveedor
    WHERE ProveedorID = p_ProveedorID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró un proveedor con ProveedorID: ' || p_ProveedorID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Proveedor eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/
BEGIN
    CrearProveedor(1, 'Proveedor De Frescos', 'Dirección San Jose Centro', '999999', 'fres@hotmail.com');
END;
BEGIN
    ObtenerProveedorPorID(1);
END;

BEGIN
    ActualizarProveedor(1, 'Proveedor Actualizado', 'Nueva Dirección Alajueja', '888888', 'fresca@hotmail.com');
END;

BEGIN
    EliminarProveedor(1);
END;

----------------------------------------------------------------------------------------------
--10
CREATE TABLE ProveedorIngrediente (
    ProveedorID INT,
    IngredienteID INT,
    Precio DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ProveedorID, IngredienteID),
    FOREIGN KEY (ProveedorID) REFERENCES Proveedor(ProveedorID),
    FOREIGN KEY (IngredienteID) REFERENCES Ingrediente(IngredienteID)
);

/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearProveedorIngrediente(
    p_ProveedorID IN ProveedorIngrediente.ProveedorID%TYPE,
    p_IngredienteID IN ProveedorIngrediente.IngredienteID%TYPE,
    p_Precio IN ProveedorIngrediente.Precio%TYPE
)
IS
BEGIN
    INSERT INTO ProveedorIngrediente (ProveedorID, IngredienteID, Precio)
    VALUES (p_ProveedorID, p_IngredienteID, p_Precio);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerProveedorIngrediente(
    p_ProveedorID IN ProveedorIngrediente.ProveedorID%TYPE,
    p_IngredienteID IN ProveedorIngrediente.IngredienteID%TYPE
)
IS
    v_Precio ProveedorIngrediente.Precio%TYPE;
BEGIN
    SELECT Precio
    INTO v_Precio
    FROM ProveedorIngrediente
    WHERE ProveedorID = p_ProveedorID AND IngredienteID = p_IngredienteID;

    DBMS_OUTPUT.PUT_LINE('Precio: ' || v_Precio);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con ProveedorID: ' || p_ProveedorID || ' e IngredienteID: ' || p_IngredienteID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarProveedorIngrediente(
    p_ProveedorID IN ProveedorIngrediente.ProveedorID%TYPE,
    p_IngredienteID IN ProveedorIngrediente.IngredienteID%TYPE,
    p_Precio IN ProveedorIngrediente.Precio%TYPE
)
IS
BEGIN
    UPDATE ProveedorIngrediente
    SET Precio = p_Precio
    WHERE ProveedorID = p_ProveedorID AND IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con ProveedorID: ' || p_ProveedorID || ' e IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Registro actualizado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarProveedorIngrediente(
    p_ProveedorID IN ProveedorIngrediente.ProveedorID%TYPE,
    p_IngredienteID IN ProveedorIngrediente.IngredienteID%TYPE
)
IS
BEGIN
    DELETE FROM ProveedorIngrediente
    WHERE ProveedorID = p_ProveedorID AND IngredienteID = p_IngredienteID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el registro con ProveedorID: ' || p_ProveedorID || ' e IngredienteID: ' || p_IngredienteID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Registro eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/

BEGIN
    CrearProveedorIngrediente(1, 1, 5000);
END;
BEGIN
    ObtenerProveedorIngrediente(1, 1);
END;
BEGIN
    ActualizarProveedorIngrediente(1, 1, 4500);
END;

BEGIN
    EliminarProveedorIngrediente(1, 1);
END;
-------------------------------------------------------------------------------------------------
--11
CREATE TABLE CategoriaProducto (
    CategoriaID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción VARCHAR(200)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearCategoriaProducto(
    p_CategoriaID IN CategoriaProducto.CategoriaID%TYPE,
    p_Nombre IN CategoriaProducto.Nombre%TYPE,
    p_Descripción IN CategoriaProducto.Descripción%TYPE
)
IS
BEGIN
    INSERT INTO CategoriaProducto (CategoriaID, Nombre, Descripción)
    VALUES (p_CategoriaID, p_Nombre, p_Descripción);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerCategoriaProductoPorID(
    p_CategoriaID IN CategoriaProducto.CategoriaID%TYPE
)
IS
    v_Nombre CategoriaProducto.Nombre%TYPE;
    v_Descripción CategoriaProducto.Descripción%TYPE;
BEGIN
    SELECT Nombre, Descripción
    INTO v_Nombre, v_Descripción
    FROM CategoriaProducto
    WHERE CategoriaID = p_CategoriaID;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre || ', Descripción: ' || v_Descripción);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró una categoría con CategoriaID: ' || p_CategoriaID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarCategoriaProducto(
    p_CategoriaID IN CategoriaProducto.CategoriaID%TYPE,
    p_Nombre IN CategoriaProducto.Nombre%TYPE,
    p_Descripción IN CategoriaProducto.Descripción%TYPE
)
IS
BEGIN
    UPDATE CategoriaProducto
    SET Nombre = p_Nombre,
        Descripción = p_Descripción
    WHERE CategoriaID = p_CategoriaID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró una categoría con CategoriaID: ' || p_CategoriaID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Categoría actualizada correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarCategoriaProducto(
    p_CategoriaID IN CategoriaProducto.CategoriaID%TYPE
)
IS
BEGIN
    DELETE FROM CategoriaProducto
    WHERE CategoriaID = p_CategoriaID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró una categoría con CategoriaID: ' || p_CategoriaID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Categoría eliminada correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/
-- Crear una categoría de producto en una pizzería
BEGIN
    CrearCategoriaProducto(1, 'Pizzas', 'diferentes tamaños  de pizza y sabores');
END;
BEGiN
    ObtenerCategoriaProductoPorID(1);
END;
BEGIN
    ActualizarCategoriaProducto(1, 'Pizzas y Pastas', ' pizzas y pastas');
END;
BEGIN
    EliminarCategoriaProducto(1);
END;


--------------------------------------------------------------------------------------------------
--12
CREATE TABLE ProductoCategoria (
    ProductoID INT,
    CategoriaID INT,
    PRIMARY KEY (ProductoID, CategoriaID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    FOREIGN KEY (CategoriaID) REFERENCES CategoriaProducto(CategoriaID)
);
/*CREAR*/

/*LEER*/

/*ACTUALIZAR*/

/*ELIMINAR*/

/*SALIDA*/


----------------------------------------------------------------------------------------------------
--13
CREATE TABLE MetodoPago (
    MetodoPagoID INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripción VARCHAR(200)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearMetodoPago(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE,
    p_Nombre IN MetodoPago.Nombre%TYPE,
    p_Descripción IN MetodoPago.Descripción%TYPE
)
IS
BEGIN
    INSERT INTO MetodoPago (MetodoPagoID, Nombre, Descripción)
    VALUES (p_MetodoPagoID, p_Nombre, p_Descripción);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerMetodoPago(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE
)
IS
    v_Nombre MetodoPago.Nombre%TYPE;
    v_Descripción MetodoPago.Descripción%TYPE;
BEGIN
    SELECT Nombre, Descripción
    INTO v_Nombre, v_Descripción
    FROM MetodoPago
    WHERE MetodoPagoID = p_MetodoPagoID;

    DBMS_OUTPUT.PUT_LINE('MetodoPagoID: ' || p_MetodoPagoID || ', Nombre: ' || v_Nombre || ', Descripción: ' || v_Descripción);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el método de pago con MetodoPagoID: ' || p_MetodoPagoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarMetodoPago(
    p_MetodoPagoID IN MetodoPago.MetodoPagoID%TYPE,
    p_Nombre IN MetodoPago.Nombre%TYPE,
    p_Descripción IN MetodoPago.Descripción%TYPE
)
IS
BEGIN
    UPDATE MetodoPago
    SET Nombre = p_Nombre, Descripción = p_Descripción
    WHERE MetodoPagoID = p_MetodoPagoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el método de pago con MetodoPagoID: ' || p_MetodoPagoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Método de pago actualizado correctamente');
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
    DELETE FROM MetodoPago
    WHERE MetodoPagoID = p_MetodoPagoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el método de pago con MetodoPagoID: ' || p_MetodoPagoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Método de pago eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/
BEGIN
    CrearMetodoPago(1, 'Tarjeta de Crédito', 'Pago mediante tarjeta de crédito');
END;


BEGIN
    ObtenerMetodoPago(1);  
END;



BEGIN
    ActualizarMetodoPago(1, 'Efectivo', 'Pago en Efectivo');
END;


BEGIN
    EliminarMetodoPago(1);  
END;

-----------------------------------------------------------------------------------------------------
--14
CREATE TABLE Pago (
    PagoID INT PRIMARY KEY,
    PedidoID INT,
    MetodoPagoID INT,
    Monto DECIMAL(10, 2) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodoPago(MetodoPagoID)
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearPago(
    p_PagoID IN Pago.PagoID%TYPE,
    p_PedidoID IN Pago.PedidoID%TYPE,
    p_MetodoPagoID IN Pago.MetodoPagoID%TYPE,
    p_Monto IN Pago.Monto%TYPE,
    p_Fecha IN Pago.Fecha%TYPE
)
IS
BEGIN
    INSERT INTO Pago (PagoID, PedidoID, MetodoPagoID, Monto, Fecha)
    VALUES (p_PagoID, p_PedidoID, p_MetodoPagoID, p_Monto, p_Fecha);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerPago(
    p_PagoID IN Pago.PagoID%TYPE
)
IS
    v_PedidoID Pago.PedidoID%TYPE;
    v_MetodoPagoID Pago.MetodoPagoID%TYPE;
    v_Monto Pago.Monto%TYPE;
    v_Fecha Pago.Fecha%TYPE;
BEGIN
    SELECT PedidoID, MetodoPagoID, Monto, Fecha
    INTO v_PedidoID, v_MetodoPagoID, v_Monto, v_Fecha
    FROM Pago
    WHERE PagoID = p_PagoID;

    DBMS_OUTPUT.PUT_LINE('PagoID: ' || p_PagoID || ', PedidoID: ' || v_PedidoID || ', MetodoPagoID: ' || v_MetodoPagoID || ', Monto: ' || v_Monto || ', Fecha: ' || v_Fecha);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el pago con PagoID: ' || p_PagoID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarPago(
    p_PagoID IN Pago.PagoID%TYPE,
    p_PedidoID IN Pago.PedidoID%TYPE,
    p_MetodoPagoID IN Pago.MetodoPagoID%TYPE,
    p_Monto IN Pago.Monto%TYPE,
    p_Fecha IN Pago.Fecha%TYPE
)
IS
BEGIN
    UPDATE Pago
    SET PedidoID = p_PedidoID, MetodoPagoID = p_MetodoPagoID, Monto = p_Monto, Fecha = p_Fecha
    WHERE PagoID = p_PagoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el pago con PagoID: ' || p_PagoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pago actualizado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ELIMINAR*/
CREATE OR REPLACE PROCEDURE EliminarPago(
    p_PagoID IN Pago.PagoID%TYPE
)
IS
BEGIN
    DELETE FROM Pago
    WHERE PagoID = p_PagoID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el pago con PagoID: ' || p_PagoID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pago eliminado correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/*SALIDA*/
BEGIN
    CrearPago(1, 1, 1, 2500, TO_DATE('2024-12 -24', 'YYYY-MM-DD'));
END;

BEGIN
    ObtenerPago(1);  
END;

BEGIN
    ActualizarPago(1, 1, 2, 3000, TO_DATE('2024-12-17', 'YYYY-MM-DD'));
END;

BEGIN
    EliminarPago(1);  
END;


-----------------------------------------------------------------------------------------------------------
--15
CREATE TABLE Promocion (
    PromocionID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción VARCHAR(200),
    Descuento DECIMAL(5, 2) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL
);
/*CREAR*/
CREATE OR REPLACE PROCEDURE CrearPromocion(
    p_PromocionID IN Promocion.PromocionID%TYPE,
    p_Nombre IN Promocion.Nombre%TYPE,
    p_Descripción IN Promocion.Descripción%TYPE,
    p_Descuento IN Promocion.Descuento%TYPE,
    p_FechaInicio IN Promocion.FechaInicio%TYPE,
    p_FechaFin IN Promocion.FechaFin%TYPE
)
IS
BEGIN
    INSERT INTO Promocion (PromocionID, Nombre, Descripción, Descuento, FechaInicio, FechaFin)
    VALUES (p_PromocionID, p_Nombre, p_Descripción, p_Descuento, p_FechaInicio, p_FechaFin);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*LEER*/
CREATE OR REPLACE PROCEDURE ObtenerPromocion(
    p_PromocionID IN Promocion.PromocionID%TYPE
)
IS
    v_Nombre Promocion.Nombre%TYPE;
    v_Descripción Promocion.Descripción%TYPE;
    v_Descuento Promocion.Descuento%TYPE;
    v_FechaInicio Promocion.FechaInicio%TYPE;
    v_FechaFin Promocion.FechaFin%TYPE;
BEGIN
    SELECT Nombre, Descripción, Descuento, FechaInicio, FechaFin
    INTO v_Nombre, v_Descripción, v_Descuento, v_FechaInicio, v_FechaFin
    FROM Promocion
    WHERE PromocionID = p_PromocionID;

    DBMS_OUTPUT.PUT_LINE('PromocionID: ' || p_PromocionID || ', Nombre: ' || v_Nombre || ', Descripción: ' || v_Descripción || ', Descuento: ' || v_Descuento || ', FechaInicio: ' || v_FechaInicio || ', FechaFin: ' || v_FechaFin);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró la promoción con PromocionID: ' || p_PromocionID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*ACTUALIZAR*/
CREATE OR REPLACE PROCEDURE ActualizarPromocion(
    p_PromocionID IN Promocion.PromocionID%TYPE,
    p_Nombre IN Promocion.Nombre%TYPE,
    p_Descripción IN Promocion.Descripción%TYPE,
    p_Descuento IN Promocion.Descuento%TYPE,
    p_FechaInicio IN Promocion.FechaInicio%TYPE,
    p_FechaFin IN Promocion.FechaFin%TYPE
)
IS
BEGIN
    UPDATE Promocion
    SET Nombre = p_Nombre, Descripción = p_Descripción, Descuento = p_Descuento, FechaInicio = p_FechaInicio, FechaFin = p_FechaFin
    WHERE PromocionID = p_PromocionID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró la promoción con PromocionID: ' || p_PromocionID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Promoción actualizada correctamente');
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
    DELETE FROM Promocion
    WHERE PromocionID = p_PromocionID;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró la promoción con PromocionID: ' || p_PromocionID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Promoción eliminada correctamente');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

/*SALIDA*/
BEGIN
    CrearPromocion(1, 'Promoción de Verano', 'Descuento del 20% en pizzas', 200, TO_DATE('2024-03-30', 'YYYY-MM-DD'), TO_DATE('2024-04-27', 'YYYY-MM-DD'));
END;
BEGIN
    CrearPromocion(2, 'Promoción de naruto', 'Descuento del 20% en pizzas', 200, TO_DATE('2024-03-30', 'YYYY-MM-DD'), TO_DATE('2024-04-27', 'YYYY-MM-DD'));
END;
BEGIN
    ObtenerPromocion(1); 
END;

BEGIN
    ActualizarPromocion(1, 'Promoción de Invierno', 'Descuento del 25% en pizzas', 500, TO_DATE('2024-09-14', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'));
END;

BEGIN
    EliminarPromocion(1);  
END;

