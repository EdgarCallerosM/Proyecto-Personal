/* Aqui vamos a generar un resumen de todos los problemas encontrados en la base de datos.*/
WITH Repeticiones AS(
SELECT
  'Total' Concepto,
  COUNT(t.Repeticiones) VentasConDuplicacion -- Primero escribimos un CTE donde contamos cuantas duplicadas hay. La columna 'Concepto' sera util mas tarde.
FROM(
        SELECT
          VentaID,
          ClienteID,
          ProductoID,
          FechaVenta,
          Cantidad,
          MetodoPago,
          Canal,
          EstadoVenta,
          PrecioUnitario,
          DescuentoPct,
          COUNT(*) Repeticiones
        FROM Ventas
        GROUP BY VentaID,
          ClienteID,
          ProductoID,
          FechaVenta,
          Cantidad,
          MetodoPago,
          Canal,
          EstadoVenta,
          PrecioUnitario,
          DescuentoPct
        HAVING COUNT(*)>1)t
        ), 
  
ClientesIncompletos AS(   --En este CTE estamos contando cuantos clientes con datos incompletes hay en la tabla Clientes.
SELECT
  'Total' Concepto,
  COUNT(*) NumeroDeClientesIncompletos
FROM Clientes
WHERE ClienteID IS NULL OR Nombre IS NULL OR Apellido IS NULL OR Estado IS NULL OR FechaNacimiento IS NULL OR Segmento IS NULL
), 
  
ClientesConEspacios AS(  --En este CTE contamos cuantos renglones con espacios en blanco hay  
SELECT
  'Total' Concepto,
  COUNT(*) RenglonesConEspacios
FROM Clientes
WHERE TRIM(Nombre) NOT LIKE Nombre OR TRIM(Apellido) NOT LIKE Apellido
), 

PreciosInconsisitentes AS( --Finalmente, en este CTE contamos cuantos precios inconsistentes hay en la tabla Ventas
SELECT
'Total' Concepto,
COUNT(*) NumeroDePreciosInconsistentes
FROM Ventas v
LEFT JOIN Productos p
ON v.ProductoID=p.ProductoID
WHERE p.Precio <> v.PrecioUnitario
)
  
SELECT            --En nuestro querie principal, unimos todos los CTEs en la columna comun 'Concepto' para generar un solo reporte
p.Concepto,
p.VentasConDuplicacion,
ci.NumeroDeClientesIncompletos,
ce.RenglonesConEspacios,
pin.NumeroDePreciosInconsistentes
FROM Repeticiones p
LEFT JOIN ClientesIncompletos ci
ON p.Concepto=ci.Concepto
LEFT JOIN ClientesConEspacios ce
ON ci.Concepto = ce.Concepto
LEFT JOIN PreciosInconsisitentes pin
ON pin.Concepto = ce.Concepto
