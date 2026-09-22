WITH VentasUnicas AS(
SELECT DISTINCT
v.VentaID,
v.ClienteID,
v.ProductoID,
v.FechaVenta,
v.Cantidad,
v.MetodoPago,
v.Canal,
v.EstadoVenta,
v.PrecioUnitario,
v.DescuentoPct,
p.Categoria,
p.Producto,
p.Precio
FROM Ventas v
LEFT JOIN Productos p
ON v.ProductoID = p.ProductoID
WHERE v.EstadoVenta = 'Completada'
)
SELECT
ClienteID,
VentaID,
FechaVenta,
Precio*Cantidad*(1-DescuentoPct/100.0) Gasto,
SUM(Precio*Cantidad*(1-DescuentoPct/100.0)) OVER(PARTITION BY ClienteID ORDER BY FechaVenta, VentaID) Gasto_Acumulado
FROM VentasUnicas