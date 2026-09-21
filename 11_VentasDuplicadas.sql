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