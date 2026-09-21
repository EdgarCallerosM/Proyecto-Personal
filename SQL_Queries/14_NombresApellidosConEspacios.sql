SELECT
ClienteID,
Nombre,
Apellido
FROM Clientes
WHERE TRIM(Nombre) NOT LIKE Nombre OR TRIM(Apellido) NOT LIKE Apellido