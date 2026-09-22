WITH VentasUnicas AS(  --En este CTE nos deshacemos de las ventas repetidas y nos aseguramos de solo quedarnos con ventas completadas, deshaciendonos de ventas
SELECT                 -- incompletas o devueltas.
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
	
VentasPorMes AS  -- En este CTE sumamos todas las ventas por Mes
(SELECT
		MONTH(vu.FechaVenta) Mes,
		SUM(vu.Cantidad*vu.Precio*(1-vu.DescuentoPct/100.0)) Ventas
FROM VentasUnicas vu
GROUP BY MONTH(vu.FechaVenta))

--QUERY PRINCIPAL
SELECT 
*,
100.0*(vm.Ventas-LAG(vm.Ventas,1,NULL) OVER(ORDER BY vm.Mes ASC))/LAG(vm.Ventas,1,NULL) OVER(ORDER BY vm.Mes ASC) CambioPorcentualPorMes
FROM VentasPorMes vm
