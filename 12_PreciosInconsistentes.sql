SELECT
v.VentaID,
p.Precio,
v.PrecioUnitario
FROM Ventas v
LEFT JOIN Productos p
ON v.ProductoID=p.ProductoID
WHERE p.Precio <> v.PrecioUnitario