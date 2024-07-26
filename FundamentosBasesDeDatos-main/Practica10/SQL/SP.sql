/* Función para agregar un Veterinario a la tabla
 * Recibe los valores necesarios para insertar y
 * regresa una advertencia si se intentan usar símbolos en la CURP
 * y símbolos o números en estado o nombres.
 * De lo contrario inserta en la tabla los valores ingresados
 */
CREATE OR REPLACE PROCEDURE agregar_veterinario (CURP IN VARCHAR(18), 
												 telefono IN VARCHAR(10),calle IN VARCHAR(50), 
												 numero IN VARCHAR(50),estado IN VARCHAR(50),
												 cp IN VARCHAR(50),fechaNac IN DATE,
												 nombre IN VARCHAR(50),paterno IN VARCHAR(50),
												 materno IN VARCHAR(50),salario IN FLOAT,
												 genero IN VARCHAR(50),RFC IN VARCHAR(13),
												 horaInicio IN TIME,horaFin IN TIME,
												 pacientesAct IN INT)
	AS $$
	BEGIN
		CASE
			WHEN CURP NOT SIMILAR TO '[a-zA-Z0-9]*' THEN
				RAISE NOTICE 'Error: Estado solo admite valores alfabéticos';
    		WHEN estado NOT SIMILAR TO '[a-zA-Z]*' THEN
				RAISE NOTICE 'Error: Estado solo admite valores alfabéticos';
			WHEN nombre NOT SIMILAR TO '[a-zA-Z]*' THEN
				RAISE NOTICE 'Error: Nombre solo admite valores alfabéticos';
			WHEN paterno NOT SIMILAR TO '[a-zA-Z]*' THEN
				RAISE NOTICE 'Error: Apellido Paterno solo admite valores alfabéticos';
			WHEN materno NOT SIMILAR TO '[a-zA-Z]*' THEN
				RAISE NOTICE 'Error: Apelludi Materno solo admite valores alfabéticos';
			ELSE 
				INSERT INTO Veterinario(CURP,telefono,calle,numero,estado,cp,fechaNac,nombre,
								paterno,materno,salario,genero,RFC,horaInicio,horaFin,pacientesAct) 
				VALUES (CURP,telefono,calle,numero,estado,cp,fechaNac,nombre,
								paterno,materno,salario,genero,RFC,horaInicio,horaFin,pacientesAct);
		END CASE;
	END;
	$$
	Language plpgsql;
	

/* Función para eliminar un veterinario dado el CURP
 * Por como agregamos las restricciones de integridad 
 * al eliminar un veterinario de la tabla Veterinario
 * se eliminan todo renglón que le haga referencia.
 * Por lo tanto esta función solo invoca el DELETE
 */
CREATE OR REPLACE PROCEDURE elimina_veterinario(CURP IN VARCHAR(18))
	AS $$
	BEGIN
		DELETE FROM Veterinario WHERE CURP = CURP;
	END
	$$
	Language plpgsql;