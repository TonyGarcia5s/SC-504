/*Vista clientes con pedidos*/
CREATE OR REPLACE VIEW ClientesConPedidos AS
SELECT c.ClienteID, c.Nombre, c.Apellidos, p.PedidoID, p.Fecha, p.Hora
FROM Cliente c
JOIN Pedido p ON c.ClienteID = p.ClienteID;

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
