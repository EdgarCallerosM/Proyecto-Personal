CREATE VIEW VentasLimpias AS
SELECT DISTINCT
v.VentaID,
v.ClienteID,
v.ProductoID,
p.Producto,
p.Categoria,
p.Proveedor,
v.FechaVenta,
v.Cantidad,
v.MetodoPago,
v.Canal,
v.EstadoVenta,
p.Precio,
v.DescuentoPct,
p.precio*v.Cantidad*(1-v.DescuentoPct/100.0) Ventas
FROM Ventas v
LEFT JOIN Productos p
ON p.ProductoID=v.ProductoID