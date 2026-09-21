WITH Repeticiones AS(
SELECT
'Total' Concepto,
COUNT(t.Repeticiones) VentasConDuplicacion
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
), ClientesIncompletos AS(
SELECT
'Total' Concepto,
COUNT(*) NumeroDeClientesIncompletos
FROM Clientes
WHERE ClienteID IS NULL OR Nombre IS NULL OR Apellido IS NULL OR Estado IS NULL OR FechaNacimiento IS NULL OR Segmento IS NULL
), ClinetesConEspacios AS(
SELECT
'Total' Concepto,
COUNT(*) ClientesConEspacios
FROM Clientes
WHERE TRIM(Nombre) NOT LIKE Nombre OR TRIM(Apellido) NOT LIKE Apellido
), PreciosInconsisitentes AS(
SELECT
'Total' Concepto,
COUNT(*) NumeroDePreciosInconsistentes
FROM Ventas v
LEFT JOIN Productos p
ON v.ProductoID=p.ProductoID
WHERE p.Precio <> v.PrecioUnitario
)
SELECT
p.Concepto,
p.VentasConDuplicacion,
ci.NumeroDeClientesIncompletos,
ce.ClientesConEspacios,
pin.NumeroDePreciosInconsistentes
FROM Repeticiones p
LEFT JOIN ClientesIncompletos ci
ON p.Concepto=ci.Concepto
LEFT JOIN ClinetesConEspacios ce
ON ci.Concepto = ce.Concepto
LEFT JOIN PreciosInconsisitentes pin
ON pin.Concepto = ce.Concepto
