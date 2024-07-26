/*************/
/* Funciones */
/*************/

/** Funciones pendientes:
 * Otorgar puntos a clientes registrados basados en el monto del consumo
 * Verificador de consistencia de puntos > monto cuando se requiera ese tipo de pago */

/** Función para generar el monto del pago de nomina
 * de acuerdo a su puesto y antiguedad
 * Recibe el curp del empleado y regresa el sueldo
 */
CREATE OR REPLACE FUNCTION genera_nomina(curp_empleado VARCHAR)
RETURNS DECIMAL
AS
$$
DECLARE 
    fecha DATE;
    sueldo DECIMAL(10,2);
    cajero BOOLEAN;
    repartidor BOOLEAN;
    tortillero BOOLEAN;
    taquero BOOLEAN;
    parrillero BOOLEAN;
    mesero BOOLEAN;
BEGIN
    SELECT fecha_contratacion, es_cajero, es_repartidor, es_tortillero, es_taquero, es_parrillero, es_mesero
    INTO fecha, cajero, repartidor, tortillero, taquero, parrillero, mesero
    FROM empleado WHERE curp = curp_empleado;

    IF cajero
    THEN
        sueldo = 8000.00;
    ELSIF repartidor
    THEN
        sueldo = 9000.00;
    ELSIF tortillero
    THEN
        sueldo = 7000.00;
    ELSIF taquero
    THEN
        sueldo = 9000.00;
    ELSIF parrillero
    THEN
        sueldo = 9000.00;
    ELSIF mesero
    THEN
        sueldo = 6000.00;
    ELSE
        RETURN NULL;
    END IF;
        
    IF EXTRACT(YEAR FROM (AGE (CURRENT_DATE, fecha))) > 2
    THEN 
        sueldo := sueldo + 1500.00;
    END IF;
    RETURN sueldo;
END;
$$
LANGUAGE plpgsql;

/* Funcion para generar el subtotal de un ticket
 * Si el cliente es empleado el subtotal es 0
 * Recaba el precio actual de cada producto y lo multiplica por la cantidad del mismo
 * Devuelve la suma total y aplica promociones con los siguientes codigos
 * 1 Pozole con 10% de descuento
 * 2 Aguas al 25% de descuento
 */

CREATE OR REPLACE FUNCTION genera_monto(num_tkt INT, promocion INT)
RETURNS DECIMAL
AS
$$
DECLARE
    subtotal DECIMAL;
BEGIN
IF EXISTS (SELECT curp 
           FROM empleado 
           WHERE curp = (SELECT curp_cliente 
                         FROM ticket 
                         WHERE num_ticket = num_tkt))
THEN 
    return 0;
END IF;

SELECT sum(total) INTO subtotal
FROM
        (SELECT 
         (cantidad * (CASE 
         WHEN promocion = 1 AND clave_venta IN (53,54) 
            THEN precio * 0.9      
         WHEN promocion = 2 AND clave_venta IN (46,47,48)
            THEN precio * 0.75
         ELSE precio 
         END )) AS total
         FROM historico_comida 
            NATURAL JOIN (select clave_venta, cantidad from registrar_comida WHERE num_ticket = num_tkt) AS productos_ticket
        WHERE fecha = (select max(fecha) from historico_comida where clave_venta = productos_ticket.clave_venta FETCH FIRST ROW ONLY)
        UNION
        SELECT (precio * cantidad) AS total
        FROM historico_salsas 
            NATURAL JOIN (select clave_venta, cantidad from registrar_salsas WHERE num_ticket = num_tkt) AS salsas_ticket
        WHERE fecha = (select max(fecha) from historico_comida where clave_venta = salsas_ticket.clave_venta FETCH FIRST ROW ONLY)) AS productos_y_salsas;
RETURN subtotal;
END;
$$
LANGUAGE plpgsql;






/******************************/
/* Procedimientos Almacenados */
/******************************/

/** Procedimiento para agregar un cliente default
 * Recibe el id_sucursal
 * Suponemos que el RFC de la taquería es ABCD1234EFG56
 * telefono es 0000000000
 * calle es siempreviva
 * numero es 123
 * colonia es springfield
 * alcaldia es iztacalco
 * cp 00000
 * mail compumundo@hypermegared.com
 */
CREATE OR REPLACE PROCEDURE agregar_cliente_default(id INT)
AS $$
DECLARE 
    rfc VARCHAR(18) := 'ABCD1234EFG56' || id;
    nombre_sucursal VARCHAR(100);
BEGIN
    SELECT nombre
    INTO nombre_sucursal
    FROM sucursal
    WHERE id_sucursal = id;
    
    INSERT INTO cliente 
    VALUES(rfc, nombre_sucursal, 'default', 'default', 'SiempreViva', '123',
           'Springfield', 'Iztacalco', '00000', '0000000000', 'compumundo@hypermegared.com', NULL);
END;
$$
Language plpgsql;

/* Procedimiento para incrementar los puntos de un cliente dado un monto */
CREATE OR REPLACE PROCEDURE agregar_puntos(monto INT, curp_cliente VARCHAR)
AS $$
DECLARE
    puntos_cliente INT;
BEGIN
    SELECT puntos 
    INTO puntos_cliente
    FROM cliente
    WHERE curp = curp_cliente;
    
    IF puntos_cliente >= 0
    THEN 
        UPDATE cliente
        SET puntos = puntos_cliente + monto 
        WHERE curp = curp_cliente;
    END IF;
END;
$$
Language plpgsql;

/************/
/* Triggers */
/************/

/** Trigger para verificar que al dar de alta un vehículo este asociado a un repartidor
 * y no a otro tipo de empleado.
 */
CREATE OR REPLACE FUNCTION ver_rep()
RETURNS trigger
AS
$$
DECLARE 
    es_rep BOOLEAN;
BEGIN
    SELECT es_repartidor 
    INTO es_rep
	FROM empleado
    WHERE curp = NEW.curp;
    IF es_rep
    THEN 
        RETURN NEW;
    ELSE 
        RAISE NOTICE 'El empleado no es repartidor';
	    RETURN NULL;
    END IF;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER verifica_repartidor
BEFORE INSERT ON transporte
FOR EACH ROW
EXECUTE PROCEDURE ver_rep();

/** Trigger para verificar que al dar de alta un empleado no se le asignen dos labores diferentes.
 * Además se verifica que un empleado no sea un cliente default.
 */
CREATE OR REPLACE FUNCTION ver_emp()
RETURNS trigger
AS
$$
BEGIN
    IF NEW.curp LIKE 'ABCD1234EFG56%'
    THEN 
        RAISE NOTICE 'No se permite que un cliente default sea un empleado';
        RETURN NULL;
    END IF;
    IF TRUE NOT IN (NEW.es_cajero, NEW.es_repartidor, NEW.es_tortillero, NEW.es_taquero, NEW.es_parrillero, NEW.es_mesero)
    THEN
        RAISE NOTICE 'El empleado debe tener una especialidad';
        RETURN NULL;
    END IF;
    IF (NEW.es_cajero AND (NOT (TRUE in (NEW.es_repartidor, NEW.es_tortillero, NEW.es_taquero, NEW.es_parrillero, NEW.es_mesero))))
    THEN 
        RETURN NEW;
    ELSIF (NEW.es_repartidor AND (NOT (TRUE in (NEW.es_cajero, NEW.es_tortillero, NEW.es_taquero, NEW.es_parrillero, NEW.es_mesero))))
    THEN 
        RETURN NEW;
    ELSIF (NEW.es_tortillero AND (NOT (TRUE in (NEW.es_cajero, NEW.es_repartidor, NEW.es_taquero, NEW.es_parrillero, NEW.es_mesero))))
    THEN 
        RETURN NEW;
    ELSIF (NEW.es_taquero AND (NOT (TRUE in (NEW.es_cajero, NEW.es_repartidor, NEW.es_tortillero, NEW.es_parrillero, NEW.es_mesero))))
    THEN 
        RETURN NEW;
    ELSIF (NEW.es_parrillero AND (NOT (TRUE in (NEW.es_cajero, NEW.es_repartidor, NEW.es_tortillero, NEW.es_taquero, NEW.es_mesero))))
    THEN 
        RETURN NEW;
    ELSIF (NEW.es_mesero AND (NOT (TRUE in (NEW.es_cajero, NEW.es_repartidor, NEW.es_tortillero, NEW.es_taquero, NEW.es_parrillero))))
    THEN 
        RETURN NEW;
    ELSE
        RAISE NOTICE 'Un empleado solo puede tener una ubicación';
        RETURN NULL;
    END IF;    
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER verifica_empleado
BEFORE INSERT ON empleado
FOR EACH ROW
EXECUTE PROCEDURE ver_emp();

/** Trigger para verificar en primera instancia la consistencia al levantar tickets
 * Se verifica lo siguiente:
 * Que el pago de un servicio a domicilio no sea con puntos
 * Que un mesero sea el que atienda el servicio
 * Que una persona no se atienda a si misma
 * Que no sea un cliente default pide un servicio a domicilio
 */
CREATE OR REPLACE FUNCTION ver_tkt()
RETURNS trigger
AS
$$
DECLARE 
    mesero BOOLEAN;
BEGIN

    SELECT es_mesero
    INTO mesero
    FROM empleado
    WHERE curp = NEW.curp_empleado;
    
    IF NOT mesero
    THEN
        RAISE NOTICE 'Solo los meseros pueden atender';
        RETURN NULL;
    END IF;
    
    IF NEW.curp_empleado = NEW.curp_cliente
    THEN
        RAISE NOTICE 'No te puedes atender a ti mismo';
        RETURN NULL;
    END IF;
    
    IF NEW.a_domicilio AND lower(NEW.metodo_pago) = 'puntos'
    THEN
        RAISE NOTICE 'No se puede pagar con puntos el servicio a domicilio';
        RETURN NULL;
    END IF;
        
    IF NEW.a_domicilio AND NEW.curp_cliente LIKE 'ABCD1234EFG56%'
    THEN
        RAISE NOTICE 'Debe estar registrado el cliente para solicitar servicio a domicilio';
        RETURN NULL;
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER verifica_ticket
BEFORE INSERT ON ticket
FOR EACH ROW
EXECUTE PROCEDURE ver_tkt();
