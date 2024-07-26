DROP SCHEMA IF EXISTS public CASCADE; --Borrar todo

CREATE SCHEMA public;  -- Creamos el esquema publico

COMMENT ON SCHEMA public IS 'El esquema que viene por defecto en postgres';

/*
Definición de tablas
*/

--Tablas Llave Primaria

CREATE TABLE operador(
	curp CHAR(18) NOT NULL UNIQUE CHECK(CHAR_LENGTH(curp) = 18),
	nombre VARCHAR(50) NOT NULL CHECK(nombre<>''),
	apellidoPaterno VARCHAR(50) NOT NULL CHECK(apellidoPaterno<>''),
	apellidoMaterno VARCHAR(50) NOT NULL CHECK(apellidoMaterno<>''),
	horario VARCHAR(50) NOT NULL CHECK(horario <>''),
	ciudad VARCHAR(20) NOT NULL CHECK(ciudad <>''),
	calle VARCHAR(20) NOT NULL CHECK(calle <>''),
	numero INT NOT NULL,
	--cp INT NOT NULL CHECK(cp BETWEEN 10000 AND 99999),
	cp CHAR(5) CHECK(cp SIMILAR TO '[0-9]{5}'), --Permite codigos postales de la forma 00000 a 99999
	genero CHAR(1) CHECK(genero = 'H' OR genero= 'M'),
	gradoMaximo VARCHAR(50) NOT NULL CHECK(gradoMaximo <> '')
	--PRIMARY KEY(curp)
	--CONSTRAINT operador_pkey PRIMARY KEY(curp)
);
COMMENT ON TABLE operador IS 'Tabla que contiene a los operadores dentro del transporte colectivo';
COMMENT ON COLUMN operador.curp IS 'El curp que tiene los operadores y sirve para identicarlos';

CREATE TABLE usuario(
	curp CHAR(18) NOT NULL UNIQUE CHECK(CHAR_LENGTH(curp) = 18),
	nombre VARCHAR(50) NOT NULL CHECK(nombre<>''),
	apellidoPaterno VARCHAR(50) NOT NULL CHECK(apellidoPaterno<>''),
	apellidoMaterno VARCHAR(50) NOT NULL CHECK(apellidoMaterno<>''),
	nombreUsuario VARCHAR(50) NOT NULL CHECK(nombreUsuario <>''),
	contrasenia VARCHAR(20) NOT NULL CHECK(contrasenia <>''),
	correo VARCHAR(20) NOT NULL CHECK(correo <>'')
	--PRIMARY KEY(curp)
	--CONSTRAINT operador_pkey PRIMARY KEY(curp)
);

/*
Tablas llave Compuesta
*/
CREATE TABLE telefono(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp) = 18),
	--telefono BIGINT NOT NULL UNIQUE
	telefono CHAR(10) CHECK(telefono SIMILAR TO '[0-9]*') UNIQUE
	--PRIMARY KEY(curp,telefono)
	--CONSTRAINT telefono_pkey PRIMARY KEY(curp,telefono)
	--FOREIGN KEY(curp) REFERENCES operador(curp)
	--CONSTRAINT telefono_fkey FOREIGN KEY(curp) REFERENCES operador(curp)
);


/*
Tablas llaves foraneas
*/
CREATE TABLE metodoPago(
	idPago INT NOT NULL UNIQUE,
	curp CHAR(18) NOT NULL,
	cuentaPaypal INT CHECK(cuentaPaypal <> 0),
	numeroDeTarjeta INT CHECK(cuentaPaypal <> 0),
	vencimiento DATE CHECK(vencimiento > '2022-04-20'),
	--cvv INT CHECK(cvv BETWEEN 100 AND 999),
	cvv CHAR(3) CHECK(cvv SIMILAR TO '[0-9]{3}'), --PERMITE VALORES PARA CVV de 000 a 999
	esTarjeta BOOLEAN NOT NULL,
	esPaypal BOOLEAN NOT NULL
	--PRIMARY KEY(idPago)
	--CONSTRAINT metodoPago_pk PRIMARY KEY(idPago)
	--FOREIGN KEY(curp) REFERENCES usuario(curp)
	--CONSTRAINT metodoPago_fkey FOREIGN KEY(curp)
	--REFERENCES usuario(curp)
);

/*
Llave Primarias
*/

ALTER TABLE operador ADD CONSTRAINT operador_pkey PRIMARY KEY(curp);
COMMENT ON CONSTRAINT operador_pkey ON operador IS 'La llave primaria de la tabla operador';
ALTER TABLE usuario ADD CONSTRAINT usuario_pkey PRIMARY KEY(curp);
COMMENT ON CONSTRAINT usuario_pkey ON usuario IS 'La llave primaria de la tabla usuario';

/*
Llave Compuestas
*/
ALTER TABLE telefono ADD CONSTRAINT telefono_pkey PRIMARY KEY(curp,telefono);
COMMENT ON CONSTRAINT telefono_pkey ON telefono IS 'La llave compuesta de la tabla telefono';
ALTER TABLE telefono ADD CONSTRAINT telefono_fkey FOREIGN KEY(curp)
REFERENCES operador(curp) /*ON UPDATE SDASDA ON DELETE SASAS*/;
COMMENT ON CONSTRAINT telefono_fkey ON telefono IS 'La llave foranea de la tabla telefono que hace referencia al curp de operador';

/*
Llave Foraneas
*/
ALTER TABLE metodoPago ADD CONSTRAINT metodopago_pkey PRIMARY KEY(idPago);
ALTER TABLE metodoPago ADD CONSTRAINT metodopago_fkey FOREIGN KEY(curp)
REFERENCES usuario(curp);

