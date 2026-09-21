CREATE VIEW ClientesLimpios AS
SELECT DISTINCT
ClienteID,
COALESCE(Nombre,'Desconocido') Nombre,
COALESCE(Apellido,'Desconocido') Apellido,
COALESCE(Estado,'Desconocido') Estado,
FechaNacimiento,
Segmento
FROM Clientes 