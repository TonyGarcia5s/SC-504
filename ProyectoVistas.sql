/*Vista Historial de pedidos*/
CREATE OR REPLACE VIEW HistorialPedidos AS
SELECT c.ClienteID, c.Nombre, c.Apellidos, p.PedidoID, p.Fecha, p.Hora, p.SucursalID, p.MetodoPagoID, p.PromocionID, p.TipoVentaID, p.TotalPedido
FROM Cliente c
JOIN Pedido p ON c.ClienteID = p.ClienteID;

/*Vista Preferencias del cliente*/
CREATE OR REPLACE VIEW PreferenciasClientes AS
SELECT c.ClienteID, c.Nombre, c.Apellidos, dp.IngredienteExtraID, ie.Nombre AS IngredienteNombre, ie.Precio, 
       dp.CantidadProductos AS Cantidad
FROM Cliente c
JOIN Pedido p ON c.ClienteID = p.ClienteID
JOIN DetallePedido dp ON p.PedidoID = dp.PedidoID
JOIN IngredientesExtra ie ON dp.IngredienteExtraID = ie.IngredienteID;

/*Vista Clientes frecuentes*/
CREATE OR REPLACE VIEW ClientesFrecuentes AS
SELECT c.ClienteID, c.Nombre, c.Apellidos, COUNT(p.PedidoID) AS NumeroPedidos
FROM Cliente c
JOIN Pedido p ON c.ClienteID = p.ClienteID
GROUP BY c.ClienteID, c.Nombre, c.Apellidos
HAVING COUNT(p.PedidoID) > 5;

/*Vista Resumen de pedidos por fecha*/
CREATE OR REPLACE VIEW ResumenPedidosPorFecha AS
SELECT p.Fecha, COUNT(p.PedidoID) AS NumeroPedidos, SUM(dp.PrecioTotal) AS TotalVentas
FROM Pedido p
JOIN DetallePedido dp ON p.PedidoID = dp.PedidoID
GROUP BY p.Fecha;

/*Vista productos con ingredientes*/
CREATE OR REPLACE VIEW ProductosConIngredientes AS
SELECT p.ProductoID, p.Nombre AS Producto, i.IngredienteID, i.Nombre AS Ingrediente, i.Precio
FROM Producto p
JOIN IngredientesExtra i ON p.ProductoID = i.ProductoID;

/*Vista pedidos por sucursal*/
CREATE OR REPLACE VIEW PedidosPorSucursal AS
SELECT s.SucursalID, s.Nombre AS Sucursal, p.PedidoID, p.Fecha, p.Hora
FROM Sucursal s
JOIN Pedido p ON s.SucursalID = p.SucursalID;

/*Vista empleados por sucursal*/
CREATE OR REPLACE VIEW EmpleadosPorSucursal AS
SELECT s.SucursalID, s.Nombre AS Sucursal, e.EmpleadoID, e.Nombre, e.Apellidos, e.Puesto
FROM Sucursal s
JOIN Empleado e ON s.SucursalID = e.SucursalID;

/*Vista ventas por producto*/
CREATE OR REPLACE VIEW VentasPorProducto AS
SELECT p.ProductoID, p.Nombre, SUM(dc.CantidadProductos) AS CantidadVendida, SUM(dc.PrecioTotal) AS TotalVendido
FROM Producto p
JOIN DetallePedido dc ON p.ProductoID = dc.ProductoID
GROUP BY p.ProductoID, p.Nombre;

/*Vista promociones aplicadas*/
CREATE OR REPLACE VIEW PromocionesAplicadas AS
SELECT pr.PromocionID, pr.Descripcion, COUNT(p.PedidoID) AS CantidadAplicada, SUM(dc.PrecioTotalDescuento) AS TotalDescuentoAplicado
FROM Promocion pr
JOIN Pedido p ON pr.PromocionID = p.PromocionID
JOIN DetallePedido dc ON p.PedidoID = dc.PedidoID
GROUP BY pr.PromocionID, pr.Descripcion;

/*Vista tipos de pago utilizados*/
CREATE OR REPLACE VIEW TiposDePagoUtilizados AS
SELECT mp.MetodoPagoID, mp.TipoPago, COUNT(p.PedidoID) AS CantidadUsada
FROM MetodoPago mp
JOIN Pedido p ON mp.MetodoPagoID = p.MetodoPagoID
GROUP BY mp.MetodoPagoID, mp.TipoPago;

/*Vista ventas por sucursal*/
CREATE OR REPLACE VIEW VentasPorSucursal AS
SELECT s.SucursalID, s.Nombre AS Sucursal, SUM(dc.PrecioTotal) AS TotalVendido
FROM Sucursal s
JOIN Pedido p ON s.SucursalID = p.SucursalID
JOIN DetallePedido dc ON p.PedidoID = dc.PedidoID
GROUP BY s.SucursalID, s.Nombre;

/*Vista pedidos por cliente*/
CREATE OR REPLACE VIEW PedidosPorCliente AS
SELECT c.ClienteID, c.Nombre, c.Apellidos, COUNT(p.PedidoID) AS CantidadPedidos, SUM(dc.PrecioTotal) AS TotalGastado
FROM Cliente c
JOIN Pedido p ON c.ClienteID = p.ClienteID
JOIN DetallePedido dc ON p.PedidoID = dc.PedidoID
GROUP BY c.ClienteID, c.Nombre, c.Apellidos;

/*Vista ingredientes extra por pedido*/
CREATE OR REPLACE VIEW IngredientesExtraPorPedido AS
SELECT p.PedidoID, i.IngredienteID, i.Nombre, dc.CantidadProductos, dc.PrecioTotal
FROM Pedido p
JOIN DetallePedido dc ON p.PedidoID = dc.PedidoID
JOIN IngredientesExtra i ON dc.IngredienteExtraID = i.IngredienteID;

/*Vista Información de clientes*/
CREATE OR REPLACE VIEW InformaciónClientes AS
SELECT ClienteID, Nombre, Apellidos, Telefono, Direccion, Email
FROM Cliente;

/*Vista Reportes*/
CREATE OR REPLACE VIEW ReportesGenerales AS
SELECT r.ReporteID, r.Descripcion, r.FechaGeneracion, d.ClienteID, d.PedidoID, d.TotalPedidos, d.TotalGasto
FROM Reportes r
JOIN DetalleReporte d ON r.ReporteID = d.ReporteID;

/*Vista Detalle de Pedidos*/
CREATE OR REPLACE VIEW DetallePedidos AS
SELECT p.PedidoID, p.ClienteID, c.Nombre, c.Apellidos, p.Fecha, p.Hora, dp.ProductoID, pr.Nombre AS ProductoNombre, dp.CantidadProductos, dp.PrecioUnitario, dp.PrecioTotal
FROM Pedido p
JOIN Cliente c ON p.ClienteID = c.ClienteID
JOIN DetallePedido dp ON p.PedidoID = dp.PedidoID
JOIN Producto pr ON dp.ProductoID = pr.ProductoID;

/*Vista Estadísticas de los reportes*/
CREATE OR REPLACE VIEW EstadisticasReportes AS
SELECT r.ReporteID, r.Descripcion, r.FechaGeneracion, COUNT(d.PedidoID) AS NumeroPedidos, SUM(d.TotalGasto) AS TotalGasto
FROM Reportes r
JOIN DetalleReporte d ON r.ReporteID = d.ReporteID
GROUP BY r.ReporteID, r.Descripcion, r.FechaGeneracion;
