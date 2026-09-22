/*Las columnas Nombre, Apellido y Estado tienen valores Nulos. Aqui simplemente estamos reemplazando esos nulos con el texto generico "Desconocido".*/
CREATE VIEW ClientesLimpios AS
SELECT DISTINCT
ClienteID,
COALESCE(Nombre,'Desconocido') Nombre,
COALESCE(Apellido,'Desconocido') Apellido,
COALESCE(Estado,'Desconocido') Estado,
FechaNacimiento,
Segmento
FROM Clientes 
