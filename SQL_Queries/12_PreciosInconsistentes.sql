/* Aqui hacemos un Join entre las tablas Ventas y Productos para detectar en que ventas los precios registrados de los productos
no concuerdan con los precios oficiales*/
SELECT
v.VentaID,
p.Precio,
v.PrecioUnitario
FROM Ventas v
LEFT JOIN Productos p
ON v.ProductoID=p.ProductoID
WHERE p.Precio <> v.PrecioUnitario
