/* Si utilizamos el comparador logico = para comparar TRIM(texto) y texto, SQL server ignora si hay espacios en blanco al final de texto. 
Es por eso que usamos "NOT LIKE" para hacer la comparacion.*/
SELECT
ClienteID,
Nombre,
Apellido
FROM Clientes
WHERE TRIM(Nombre) NOT LIKE Nombre OR TRIM(Apellido) NOT LIKE Apellido
