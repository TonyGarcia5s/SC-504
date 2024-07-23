CREATE TABLE Sucursal (
    SucursalID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Dirección VARCHAR(200) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Provincia VARCHAR(100) NOT NULL,
    Teléfono VARCHAR(15)
);

CREATE TABLE Empleado (
    EmpleadoID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    SucursalID INT,
    FOREIGN KEY (SucursalID) REFERENCES Sucursal(SucursalID)
);

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

CREATE TABLE Pedido (
    PedidoID INT PRIMARY KEY,
    ClienteID INT,
    EmpleadoID INT,
    Fecha DATE NOT NULL,
    Hora TIMESTAMP NOT NULL,  /* Cambie  TIME a TIMESTAMP por que oracle no lo soporta*/
    Total DECIMAL(10, 2) NOT NULL,
    Estado VARCHAR2(50) NOT NULL,  
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID)
);

CREATE TABLE Producto (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción VARCHAR(200),
    Precio DECIMAL(10, 2) NOT NULL
);

CREATE TABLE PedidoProducto (
    PedidoID INT,
    ProductoID INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (PedidoID, ProductoID),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);

CREATE TABLE Ingrediente (
    IngredienteID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción VARCHAR(200)
);

CREATE TABLE ProductoIngrediente (
    ProductoID INT,
    IngredienteID INT,
    Cantidad DECIMAL(10, 2) NOT NULL,
    Unidad VARCHAR(50) NOT NULL,
    PRIMARY KEY (ProductoID, IngredienteID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    FOREIGN KEY (IngredienteID) REFERENCES Ingrediente(IngredienteID)
);

CREATE TABLE Proveedor (
    ProveedorID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Dirección VARCHAR(200),
    Teléfono VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE ProveedorIngrediente (
    ProveedorID INT,
    IngredienteID INT,
    Precio DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ProveedorID, IngredienteID),
    FOREIGN KEY (ProveedorID) REFERENCES Proveedor(ProveedorID),
    FOREIGN KEY (IngredienteID) REFERENCES Ingrediente(IngredienteID)
);


CREATE TABLE CategoriaProducto (
    CategoriaID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción VARCHAR(200)
);

CREATE TABLE ProductoCategoria (
    ProductoID INT,
    CategoriaID INT,
    PRIMARY KEY (ProductoID, CategoriaID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    FOREIGN KEY (CategoriaID) REFERENCES CategoriaProducto(CategoriaID)
);

CREATE TABLE MetodoPago (
    MetodoPagoID INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripción VARCHAR(200)
);

CREATE TABLE Pago (
    PagoID INT PRIMARY KEY,
    PedidoID INT,
    MetodoPagoID INT,
    Monto DECIMAL(10, 2) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodoPago(MetodoPagoID)
);

CREATE TABLE Promocion (
    PromocionID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción VARCHAR(200),
    Descuento DECIMAL(5, 2) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL
);