/*En este querie estamos buscando si hay ventas duplicadas. Primero hacemos un subquerie donde agrupamos todas las columnas y contamos cuantos renglones
hay con columnas identicas. Despues seleccionamos los renglones donde la cuenta de repeticiones sea mayor a 1.*/
SELECT
*
FROM(
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
		COUNT(*) Repeticiones
	FROM Ventas v
	GROUP BY v.VentaID,
				v.ClienteID,
				v.ProductoID,
				v.FechaVenta,
				v.Cantidad,
				v.MetodoPago,
				v.Canal,
				v.EstadoVenta,
				v.PrecioUnitario,
				v.DescuentoPct
	)t
WHERE Repeticiones>1
