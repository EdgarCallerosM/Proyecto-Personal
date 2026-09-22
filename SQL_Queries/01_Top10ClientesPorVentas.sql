--  Unimos la tabla Productos con la tabla Ventas para segurarnos de que utilicemos los precios correctos en ventas.
SELECT TOP 10
    v.ClienteID,
    SUM(p.Precio*v.Cantidad*(1-v.DescuentoPct/100.0)) AS VentasT
FROM Ventas v
  
LEFT JOIN Productos p
ON v.ProductoID = p.ProductoID
  
WHERE v.EstadoVenta = 'Completada'
GROUP BY v.ClienteID
ORDER BY VentasT DESC
