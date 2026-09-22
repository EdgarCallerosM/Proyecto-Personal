WITH VentasUnicas AS(
SELECT 
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
p.Precio,
COUNT(*) Repeticiones
FROM Ventas v
LEFT JOIN Productos p
ON v.ProductoID = p.ProductoID
WHERE v.EstadoVenta = 'Completada'
GROUP BY 
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
),
VentasPorMes AS 
(SELECT
MONTH(vu.FechaVenta) Mes,
SUM(vu.Cantidad*vu.Precio*(1-vu.DescuentoPct/100.0)) Ventas
FROM VentasUnicas vu
GROUP BY MONTH(vu.FechaVenta))
SELECT
*,
100.0*(vm.Ventas-LAG(vm.Ventas,1,NULL) OVER(ORDER BY vm.Mes ASC))/LAG(vm.Ventas,1,NULL) OVER(ORDER BY vm.Mes ASC) CambioPorcentualPorMes
FROM VentasPorMes vm