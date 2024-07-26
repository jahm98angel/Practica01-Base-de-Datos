/* Funcion que a partir de una CURP regresa la edad de la persona 
 * Recibe un VARCHAR con la CURP, obtiene la subcadena correspondiente 
 * a la fecha de nacimiento, la transforma y le resta la fecha actual
 * Regresa un Intervalo 
 */
CREATE OR REPLACE FUNCTION edad_desde_curp(VARCHAR)
	RETURNS INTERVAL
	AS $$
	DECLARE
		edad INTERVAL;
	BEGIN
		edad := AGE(CURRENT_DATE, TO_DATE(substring($1 from 5 for 6), 'YYMMDD'));
		return edad;
	END;
	$$
	Language plpgsql;

/* Función para calcular las ganancias de una estética
 * En nuestro modelo relacional separamos las consultas y los
 * productos que vendemos, por lo tanto buscamos las ganancias 
 * correspondientes a la estética en ambas tablas y las sumamos.
 * Regresa un valor de tipo DOUBLE PRECISION
 */
CREATE OR REPLACE FUNCTION ganancias_estetica(int)
	RETURNS DOUBLE PRECISION
	AS $$
	DECLARE
		producto DOUBLE PRECISION;
		recibo DOUBLE PRECISION;
	BEGIN
		producto := sum(precio) from reciboproducto where idestetica = $1;
		recibo := sum(precio) from reciboservicio where idestetica = $1;
		return producto + recibo;
	END;
	$$
	Language plpgsql;