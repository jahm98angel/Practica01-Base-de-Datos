/* Función que se ejecuta dentro del trigger apellidos_supervisor 
 * y cambia los valores de los apellidos paterno y materno
 * al ingresar un Supervisor
 */
CREATE OR REPLACE FUNCTION cambia_apellidos()
RETURNS trigger
AS
$$
DECLARE 
	materno_temp VARCHAR(50);	
BEGIN
	materno_temp := NEW.materno; 
	NEW.materno := NEW.paterno;
	NEW.paterno := materno_temp;	  
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

/* Trigger para el intercambio de apellido paterno y materno
 * Se ejecuta antes de Insertar un nuevo Supervisor
 */
CREATE TRIGGER apellidos_supervisor
BEFORE INSERT ON Supervisor
FOR EACH ROW
EXECUTE PROCEDURE cambia_apellidos();

/* Ejemplos: 
 * INSERT INTO Supervisor(CURP,telefono,calle,numero,estado,cp,fechaNac,
					   nombre,paterno,materno,salario,genero,periodo,
					   RFC,horaInicio,horaFin) 
	VALUES ('TEST770584XXHGYBC6','6929491259','Moland','8263','Jalisco',
		'21114','1982-04-22','Jaine','Orvis','McSpirron',6325.31,
		'Cisgender','Manana','TEST7705849QS','9:46','17:46');
 * SELECT paterno, materno FROM Supervisor WHERE CURP = 'TEST770584XXHGYBC6';
 * DELETE FROM Supervisor WHERE CURP = 'TEST770584XXHGYBC6';
 */

/* Función que se llama dentro del trigger restriccion_alter_delete
 * y levanta una notificación que alerta al usuario sobre la restricción 
 * que existe al querer modificar o eliminar datos de una tabla */
CREATE OR REPLACE FUNCTION noti_cambios()
RETURNS trigger
AS
$$
BEGIN
	RAISE NOTICE 'Error: No se puede alterar o eliminar los datos guardados';	  
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;

/* Trigger para evitar la modificación o eliminación de datos de una
 * mascota.
 * Se llama al querer hacer ALTER o DELETE */
CREATE TRIGGER restriccion_alter_delete
BEFORE UPDATE OR DELETE ON Mascota
FOR EACH ROW
EXECUTE PROCEDURE noti_cambios();