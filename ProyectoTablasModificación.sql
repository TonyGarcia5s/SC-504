CREATE TABLE Sucursal (
    SucursalID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion VARCHAR(255),
    Telefono VARCHAR(15)
);

CREATE TABLE Empleado (
    EmpleadoID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellidos VARCHAR(100),
    SucursalID INT,
    Puesto VARCHAR(50),
    Telefono VARCHAR(15),
    FOREIGN KEY (SucursalID) REFERENCES Sucursal(SucursalID)
);

CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellidos VARCHAR(100),
    Telefono VARCHAR(15),
    Direccion VARCHAR(255),
    Email VARCHAR(100)
);

CREATE TABLE TipoProducto (
    TipoProductoID INT PRIMARY KEY,
    Tamano VARCHAR(10),
    Descripcion VARCHAR(255),
    ProductoID INT,
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);

CREATE TABLE Producto (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Precio DECIMAL(10, 2),
    Descripcion VARCHAR(255)
);

CREATE TABLE IngredientesExtra (
    IngredienteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Descripcion VARCHAR(255),
    Precio DECIMAL(10, 2),
    ProductoID INT,
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);

CREATE TABLE MetodoPago (
    MetodoPagoID INT PRIMARY KEY,
    TipoPago VARCHAR(50)
);

CREATE TABLE Promocion (
    PromocionID INT PRIMARY KEY,
    Descripcion VARCHAR(255),
    Descuento DECIMAL(5, 2)
);

CREATE TABLE TipoVenta (
    TipoVentaID INT PRIMARY KEY,
    MetodoRetiro VARCHAR(50)
);

CREATE TABLE Pedido (
    PedidoID NUMBER PRIMARY KEY,
    ClienteID NUMBER,
    SucursalID NUMBER,
    MetodoPagoID NUMBER,
    PromocionID NUMBER,
    TipoVentaID NUMBER,
    Fecha DATE,
    Hora TIMESTAMP,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (SucursalID) REFERENCES Sucursal(SucursalID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodoPago(MetodoPagoID),
    FOREIGN KEY (PromocionID) REFERENCES Promocion(PromocionID),
    FOREIGN KEY (TipoVentaID) REFERENCES TipoVenta(TipoVentaID)
);


CREATE TABLE DetalleCompra (
    DetallePedidoID INT PRIMARY KEY,
    PedidoID INT,
    ProductoID INT,
    IngredienteExtraID INT,
    CantidadProductos INT,
    PrecioUni DECIMAL(10, 2),
    PrecioTotal DECIMAL(10, 2),
    PrecioIva DECIMAL(10, 2),
    PrecioTotalDescuento DECIMAL(10, 2),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    FOREIGN KEY (IngredienteExtraID) REFERENCES IngredientesExtra(IngredienteID)
);

CREATE TABLE Reportes (
    ReporteID INT PRIMARY KEY,
    Descripcion VARCHAR(255),
    FechaGeneracion DATE
);

CREATE TABLE DetalleReporte (
    DetalleReporteID INT PRIMARY KEY,
    ReporteID INT,
    ClienteID INT,
    PedidoID INT,
    TotalPedidos INT,
    TotalGasto DECIMAL(10, 2),
    FrecuenciaPedidos INT,
    FOREIGN KEY (ReporteID) REFERENCES Reportes(ReporteID),
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID)
);
