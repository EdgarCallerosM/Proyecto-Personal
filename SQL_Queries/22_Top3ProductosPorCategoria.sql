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
), RankDeProductosPorCategoria AS(
SELECT
vu.Categoria,
vu.Producto,
SUM(vu.Precio*vu.Cantidad*(1-DescuentoPct/100.0)) VentasTotales,
RANK() OVER(PARTITION BY Categoria ORDER BY SUM(vu.Precio*vu.Cantidad*(1-DescuentoPct/100.0)) DESC) Ranked
FROM VentasUnicas vu
GROUP BY vu.Categoria, vu.Producto)
SELECT
*
FROM RankDeProductosPorCategoria
WHERE Ranked<4