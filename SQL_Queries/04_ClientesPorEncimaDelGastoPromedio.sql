WITH VentasUnicas AS(  -- En este CTE nos deshacemos de registros repetidos y solo nos quedemos con transacciones completas.
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
), 
  
VentasPorCliente AS( --En este CTE calculamos el gasto total de cada cliente.
SELECT
    vu2.ClienteID,
    SUM(vu2.Cantidad*vu2.Precio*(1-vu2.DescuentoPct/100.0)) GastoTotal
FROM VentasUnicas vu2
GROUP BY ClienteID)

--QUERY PRINCIPAL
SELECT
    ClienteID,
    GastoTotal
FROM VentasPorCliente
WHERE GastoTotal>(SELECT AVG(GastoTotal) FROM VentasPorCliente)
