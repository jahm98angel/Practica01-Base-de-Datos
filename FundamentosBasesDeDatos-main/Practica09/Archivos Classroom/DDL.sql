/*
Script para la creación de la base de datos Transporte Colectivo
*/

--Creacion del esquema
DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

COMMENT ON SCHEMA public IS 'El esquema que viene por defecto en postgres';

--Creacion de tablas
--Llaves primarias
CREATE TABLE operador(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18) UNIQUE,  -- No acepta cadenas menores ni mayores de longitud 18
	nombre VARCHAR(50) CHECK (nombre <>''),
	apellidoPaterno VARCHAR(50)CHECK (apellidoPaterno <>''),
	apellidoMaterno VARCHAR(50)CHECK (apellidoMaterno <>''),
	horario INT NOT NULL,
	ciudad VARCHAR(50) CHECK (ciudad <>'') ,
	calle VARCHAR(50) CHECK (calle <>''),
	cp int CHECK(cp between 10000 and 99999),  -- No acepta numeros menores a 10000 , ni mayores a 99999
	genero CHAR(1) CHECK(genero = 'H' or genero = 'F'),
	gradoMaximo VARCHAR(20) CHECK(genero <> '')
	--PRIMARY KEY(curp)
	--CONSTRAINT operador_pkey PRIMARY KEY (curp)
);

COMMENT ON TABLE operador IS 'Tabla que contiene la información de los operadores';
COMMENT ON COLUMN operador.curp IS 'La CURP de los operadores que funcionan como identificador';
COMMENT ON COLUMN operador.nombre IS 'El nombre de los operadores';
COMMENT ON COLUMN operador.apellidoPaterno IS 'El apellido paterno de los operadores';
COMMENT ON COLUMN operador.apellidoMaterno IS 'El apellido materno de los operadores';
COMMENT ON COLUMN operador.horario IS 'El horario laboral de los operadores';
COMMENT ON COLUMN operador.ciudad IS 'La ciudad donde viven los operadores';
COMMENT ON COLUMN operador.calle IS 'La calle donde viven los operadores';
COMMENT ON COLUMN operador.cp IS 'El codigo postal de los operadores';
COMMENT ON COLUMN operador.genero IS 'El genero de los operadores puede ser H o F';
COMMENT ON COLUMN operador.gradoMaximo IS 'El grado maximo de los operadores';

CREATE TABLE usuario(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18) UNIQUE,
	nombre VARCHAR(50) CHECK (nombre <>''),
	apellidoPaterno VARCHAR(50)CHECK (apellidoPaterno <>''),
	apellidoMaterno VARCHAR(50)CHECK (apellidoMaterno <>''),
	nombreUsuario VARCHAR(50) CHECK (nombreUsuario <> ''),
	contrasenia VARCHAR(50) CHECK (contrasenia <> ''),
	correo VARCHAR(50) CHECK (correo <> '')
	--PRIMARY KEY(curp)
	--CONSTRAINT usuario_pkey PRIMARY KEY (curp)
);

COMMENT ON TABLE usuario IS 'Tabla que contiene la información de los operadores';
COMMENT ON COLUMN usuario.curp IS 'La CURP de los usuarios que funcionan como identificador';
COMMENT ON COLUMN usuario.nombre IS 'El nombre de los usuarios';
COMMENT ON COLUMN usuario.apellidoPaterno IS 'El apellido paterno de los usuarios';
COMMENT ON COLUMN usuario.apellidoMaterno IS 'El apellido materno de los usuarios';
COMMENT ON COLUMN usuario.nombreUsuario IS 'El nombre de usuario de los usuarios';
COMMENT ON COLUMN usuario.contrasenia IS 'La contrasenia de los usuarios';
COMMENT ON COLUMN usuario.correo IS 'El correo electronico de los usuarios';

CREATE TABLE taller(
	id_Taller INT NOT NULL UNIQUE,
	numeroMecanicos INT NOT NULL,
	ciudad VARCHAR(50) CHECK (ciudad <> ''),
	calle VARCHAR(50) CHECK (calle <> ''),
	numero INT NOT NULL,
	cp int CHECK(cp between 10000 and 99999)
	--PRIMARY KEY(id_Taller)
	--CONSTRAINT taller_pkey PRIMARY KEY (id_Taller)
);

COMMENT ON TABLE taller IS 'Tabla que contiene la información de los talleres';
COMMENT ON COLUMN taller.id_Taller IS 'El identificador de los talleres';
COMMENT ON COLUMN taller.numeroMecanicos IS 'El numero de Mecanicos que contiene el taller';
COMMENT ON COLUMN taller.ciudad IS 'La ciudad donde se localiza el taller';
COMMENT ON COLUMN taller.calle IS 'La calle donde se localiza el taller';
COMMENT ON COLUMN taller.numero IS 'El numero donde se encuentra el taller';
COMMENT ON COLUMN taller.cp IS 'El codigo postal donde se encuentra el taller';

CREATE TABLE linea(
	numeroLinea INT NOT NULL UNIQUE,
	nombreLinea VARCHAR(50) CHECK (nombreLinea <> '')
	--PRIMARY KEY(numeroLinea)
	--CONSTRAINT linea_pkey PRIMARY KEY (numeroLinea)
);

COMMENT ON TABLE linea IS 'Tabla que contiene las lineas del Metro, Tren Ligero y Metrobus ';
COMMENT ON COLUMN linea.numeroLinea IS 'Identificador de la linea';
COMMENT ON COLUMN linea.nombreLinea IS 'Nombre de la linea';

CREATE TABLE ruta(
	numeroRuta SERIAL NOT NULL UNIQUE,  -- SERIAL sirve para cuando agregemos se autoincremente si no lo definimos en la entrada
	descripcion VARCHAR(50) CHECK (descripcion <> '')
	--PRIMARY KEY(numeroRuta)
	--CONSTRAINT ruta_pkey PRIMARY KEY (numeroRuta)
);

COMMENT ON TABLE ruta IS 'Tabla que contiene las rutas de Microbus, Trolebus y RTP ';
COMMENT ON COLUMN ruta.numeroRuta IS 'Identificador de la ruta';
COMMENT ON COLUMN ruta.descripcion IS 'Descripcion de la ruta';

CREATE TABLE sitio(
	numeroSitio SERIAL NOT NULL UNIQUE,
	telefono CHAR(10) CHECK (telefono SIMILAR TO '[0-9]*'),
	--telefono BIGINT NOT NULL,
	ciudad VARCHAR(50) CHECK (ciudad <> ''),
	calle VARCHAR(50) CHECK (calle <> ''),
	numero INT NOT NULL,
	cp int CHECK(cp between 10000 and 99999)
	--PRIMARY KEY(numeroSitio)
	--CONSTRAINT sitio_pkey PRIMARY KEY (numeroSitio)
);

COMMENT ON TABLE sitio IS 'Tabla que contiene los sitios de los taxis ';
COMMENT ON COLUMN sitio.numeroSitio IS 'Identificador del sitio';
COMMENT ON COLUMN sitio.telefono IS 'El telefono del sitio';
COMMENT ON COLUMN sitio.ciudad IS 'La ciudad donde se localiza el sitio';
COMMENT ON COLUMN sitio.calle IS 'La calle donde se localiza el sitio';
COMMENT ON COLUMN sitio.numero IS 'El numero donde se encuentra el sitio';
COMMENT ON COLUMN sitio.cp IS 'El codigo postal donde se encuentra el sitio';

CREATE TABLE estacion(
	id_Estacion INT NOT NULL UNIQUE, 
	nombreEstacion VARCHAR(25) CHECK (nombreEstacion <> ''),
	horario INT NOT NULL,
	disponible BOOLEAN NOT NULL
	--PRIMARY KEY(id_Estacion)
	--CONSTRAINT estacion_pkey PRIMARY KEY (id_Estacion)
);

COMMENT ON TABLE estacion IS 'Tabla que contiene las estaciones de las rutas y lineas';
COMMENT ON COLUMN estacion.id_Estacion IS 'Identificador de la estacion';
COMMENT ON COLUMN estacion.nombreEstacion IS 'El nombre de la estacion ';
COMMENT ON COLUMN estacion.horario IS 'El horario de la estacion';
COMMENT ON COLUMN estacion.disponible IS 'La disponibilidad de la estación si se encuentra activa o no';

CREATE TABLE incidente(
	id_Incidente SERIAL NOT NULL UNIQUE,
	razon VARCHAR(50) CHECK (razon<> '')
	--PRIMARY KEY(id_Incidente)
	--CONSTRAINT incidente_pkey PRIMARY KEY (id_Incidente)
	
);

COMMENT ON TABLE incidente IS 'Tabla que en caso de existir contiene los incidentes de las estaciones';
COMMENT ON COLUMN incidente.id_Incidente IS 'Identificador del incidente';
COMMENT ON COLUMN incidente.razon IS 'La razon por el cual ocurrio el incidente';

--Llaves compuestas
CREATE TABLE telefono(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	telefono CHAR(10) CHECK (telefono SIMILAR TO '[0-9]*')
	--PRIMARY KEY(curp,telefono),
	--FOREIGN KEY(curp) REFERENCES operador(curp)
	--CONSTRAINT telefono_pkey PRIMARY KEY (curp,telefono),
	--CONSTRAINT telefono_fkey FOREIGN KEY (curp)
    --REFERENCES operador (curp)
);

COMMENT ON TABLE telefono IS 'Tabla que contiene todos los telefonos que posee un operador';
COMMENT ON COLUMN telefono.curp IS 'La CURP del operador';
COMMENT ON COLUMN telefono.telefono IS 'Uno de los telefonos que puede tener los operadores';

CREATE TABLE tipoVehiculo(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	tipoVehiculo VARCHAR(50) CHECK(tipoVehiculo <> '')
	--PRIMARY KEY(curp,tipoVehiculo),
	--FOREIGN KEY(curp) REFERENCES operador(curp)
	--CONSTRAINT tipoVehiculo_pkey PRIMARY KEY (curp,tipoVehiculo),
	--CONSTRAINT tipoVehiculo_fkey FOREIGN KEY (curp)
    --REFERENCES operador (curp)
);

COMMENT ON TABLE tipoVehiculo IS 'Tabla que contiene todos los tipos de vehiculos que maneja el operador';
COMMENT ON COLUMN tipoVehiculo.curp IS 'La CURP del operador';
COMMENT ON COLUMN tipoVehiculo.tipoVehiculo IS 'Uno de los tipos de vehiculos que puede manejan los operadores';

CREATE TABLE dias(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	dias VARCHAR(50) CHECK(dias <> '')
	--PRIMARY KEY(curp,dias),
	--FOREIGN KEY(curp) REFERENCES operador(curp)
	--CONSTRAINT dias_pkey PRIMARY KEY (curp,dias),
	--CONSTRAINT dias_fkey FOREIGN KEY (curp)
    --REFERENCES operador (curp)
);

COMMENT ON TABLE dias IS 'Tabla que contiene todos los dias en el cual trabaja un operador';
COMMENT ON COLUMN dias.curp IS 'La CURP del operador';
COMMENT ON COLUMN dias.dias IS 'Uno de dias en la cual trabajan los operadores';

CREATE TABLE Licencia(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	numeroDeLicencia INT NOT NULL,
	duracion INT NOT NULL,
	fechaVencimiento DATE NOT NULL
	--PRIMARY KEY(curp,numeroDeLicencia),
	--FOREIGN KEY(curp) REFERENCES operador(curp)
	--CONSTRAINT licencia_pkey PRIMARY KEY (curp,numeroDeLicencia),
	--CONSTRAINT licencia_fkey FOREIGN KEY (curp)
    --REFERENCES operador (curp)
);

COMMENT ON TABLE Licencia IS 'Tabla que guarda la licencia de conducir de los operadores';
COMMENT ON COLUMN Licencia.curp IS 'La CURP del operador';
COMMENT ON COLUMN Licencia.numeroDeLicencia IS 'El numero de licencia que sirve para identificar a la Licencia';
COMMENT ON COLUMN Licencia.duracion IS 'La duracion de vigencia de la licencia de conducir';
COMMENT ON COLUMN Licencia.fechaVencimiento IS 'Fecha de Vencimiento de la licencia de conducir';

CREATE TABLE examenMedico(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Examen SERIAL NOT NULL,
	peso INT NOT NULL,
	talla INT NOT NULL,
	presion INT NOT NULL,
	status VARCHAR(50) CHECK (status <> ''),
	cedula INT NOT NULL,
	fecha DATE CHECK(fecha >= '2000-01-01'),
	hora INT NOT NULL
	--PRIMARY KEY(curp,id_Examen),
	--FOREIGN KEY(curp) REFERENCES operador(curp)
	--CONSTRAINT examen_pkey PRIMARY KEY (curp,id_Examen),
	--CONSTRAINT examen_fkey FOREIGN KEY (curp)
    --REFERENCES operador (curp)
);

COMMENT ON TABLE examenMedico IS 'Tabla que guarda el examen medico que realizaron los operadores';
COMMENT ON COLUMN examenMedico.curp IS 'La CURP del operador que realizo el examen medico';
COMMENT ON COLUMN examenMedico.id_Examen IS 'El identificador del examen medico';
COMMENT ON COLUMN examenMedico.peso IS 'El peso del operador que realizo el examen medico';
COMMENT ON COLUMN examenMedico.talla IS 'La talla del operador que realizo el examen medico';
COMMENT ON COLUMN examenMedico.presion IS 'La presion del operador que realizo el examen medico';
COMMENT ON COLUMN examenMedico.status IS 'El status del examen medico';
COMMENT ON COLUMN examenMedico.cedula IS 'La cedula del medio que aplico el examen medico';
COMMENT ON COLUMN examenMedico.fecha IS 'La fecha que se realizo el examen medico';
COMMENT ON COLUMN examenMedico.hora IS 'La hora en que se realizo el examen medico';

CREATE TABLE especialidad(
	id_Taller INT NOT NULL,
	especialidad VARCHAR(50) CHECK (especialidad <> '')
	--PRIMARY KEY(id_Taller,especialidad),
	--FOREIGN KEY(id_Taller) REFERENCES taller(id_Taller)
	--CONSTRAINT especialidad_pkey PRIMARY KEY (id_Taller,especialidad),
	--CONSTRAINT especialidad_fkey FOREIGN KEY (id_Taller)
    --REFERENCES taller (id_Taller)
);

COMMENT ON TABLE especialidad IS 'Tabla que guarda las especialidades que tiene un taller';
COMMENT ON COLUMN especialidad.id_Taller IS 'El identificador del taller';
COMMENT ON COLUMN especialidad.especialidad IS 'Una de las especialidades del taller';

CREATE TABLE tipoTransporte(
	id_Estacion INT NOT NULL,
	tipoTransporte VARCHAR(50) CHECK (tipoTransporte <> '')
	--PRIMARY KEY(id_Estacion,tipoTransporte),
	--FOREIGN KEY(id_Estacion) REFERENCES estacion(id_Estacion)
	--CONSTRAINT tipoTransporte_pkey PRIMARY KEY (id_Estacion,tipoTransporte),
	--CONSTRAINT tipoTransporte_fkey FOREIGN KEY (id_Estacion)
    --REFERENCES estacion (id_Estacion)
);

COMMENT ON TABLE tipoTransporte IS 'Tabla que guarda los tipos de transporte que contiene una estacion';
COMMENT ON COLUMN tipoTransporte.id_Estacion IS 'El identificador de la estacion';
COMMENT ON COLUMN tipoTransporte.tipoTransporte IS 'Uno de los tipos de transporte que contiene una estacion';

CREATE TABLE lineaIncidente(
	id_Incidente SERIAL NOT NULL,
	lineaIncidente VARCHAR(50) CHECK (lineaIncidente <> '')
	--PRIMARY KEY(id_Incidente,lineaIncidente),
	--FOREIGN KEY(id_Incidente) REFERENCES incidente(id_Incidente)
	--CONSTRAINT lineaIncidente_pkey PRIMARY KEY (id_Incidente,lineaIncidente),
	--CONSTRAINT lineaIncidente_fkey FOREIGN KEY (id_Incidente)
    --REFERENCES incidente (id_Incidente)
);

COMMENT ON TABLE lineaIncidente IS 'Tabla que guarda en caso de ocurrir la linea afectada por algun incidente de las estaciones';
COMMENT ON COLUMN lineaIncidente.id_Incidente IS 'El identificador del Incidente';
COMMENT ON COLUMN lineaIncidente.lineaIncidente IS 'Una de las lineas que afecto el incidente';

--Llaves Foraneas

CREATE TABLE metro(
	id_Vehiculo SERIAL NOT NULL UNIQUE,
	numeroLinea INT NOT NULL,
	operando BOOLEAN NOT NULL,
	capacidadPasajeros INT NOT NULL,
	inicioOperacion DATE NOT NULL
	--PRIMARY KEY(id_Vehiculo),
	--FOREIGN KEY(numeroLinea) REFERENCES linea(numeroLinea)
	--CONSTRAINT metro_pkey PRIMARY KEY (id_Vehiculo),
	--CONSTRAINT metro_fkey FOREIGN KEY (numeroLinea)
    --REFERENCES linea(numeroLinea)
);

COMMENT ON TABLE metro IS 'Tabla que contiene la informacion del vehiculo metro';
COMMENT ON COLUMN metro.id_Vehiculo IS 'El identificador del metro';
COMMENT ON COLUMN metro.numeroLinea IS 'El identificador de la linea';
COMMENT ON COLUMN metro.operando IS 'Nos indica si esta activo el metro';
COMMENT ON COLUMN metro.capacidadPasajeros IS 'La capacidad de pasajeros que permite el metro';
COMMENT ON COLUMN metro.inicioOperacion IS 'El inicio de operaciones del metro';

CREATE TABLE trenLigero(
	id_Vehiculo SERIAL NOT NULL UNIQUE,
	numeroLinea INT NOT NULL,
	operando BOOLEAN NOT NULL,
	capacidadPasajeros INT NOT NULL,
	inicioOperacion DATE NOT NULL
	--PRIMARY KEY(id_Vehiculo),
	--FOREIGN KEY(numeroLinea) REFERENCES linea(numeroLinea)
	--CONSTRAINT trenLigero_pkey PRIMARY KEY (id_Vehiculo),
	--CONSTRAINT trenLigero_fkey FOREIGN KEY (numeroLinea)
    --REFERENCES linea(numeroLinea)
);

COMMENT ON TABLE trenLigero IS 'Tabla que contiene la informacion del vehiculo Tren Ligero';
COMMENT ON COLUMN trenLigero.id_Vehiculo IS 'El identificador del Tren Ligero';
COMMENT ON COLUMN trenLigero.numeroLinea IS 'El identificador de la linea';
COMMENT ON COLUMN trenLigero.operando IS 'Nos indica si esta activo el Tren Ligero';
COMMENT ON COLUMN trenLigero.capacidadPasajeros IS 'La capacidad de pasajeros que permite el Tren Ligero';
COMMENT ON COLUMN trenLigero.inicioOperacion IS 'El inicio de operaciones del Tren Ligero';

CREATE TABLE metroBus(
	id_Vehiculo SERIAL NOT NULL UNIQUE,
	numeroLinea INT NOT NULL,
	operando BOOLEAN NOT NULL,
	capacidadPasajeros INT NOT NULL,
	inicioOperacion DATE NOT NULL
	--PRIMARY KEY(id_Vehiculo),
	--FOREIGN KEY(numeroLinea) REFERENCES linea(numeroLinea)
	--CONSTRAINT metroBus_pkey PRIMARY KEY (id_Vehiculo),
	--CONSTRAINT metroBus_fkey FOREIGN KEY (numeroLinea)
    --REFERENCES linea(numeroLinea)
);

COMMENT ON TABLE metroBus IS 'Tabla que contiene la informacion del vehiculo Metro Bus';
COMMENT ON COLUMN metroBus.id_Vehiculo IS 'El identificador del Metro Bus';
COMMENT ON COLUMN metroBus.numeroLinea IS 'El identificador de la linea';
COMMENT ON COLUMN metroBus.operando IS 'Nos indica si esta activo el Metro Bus';
COMMENT ON COLUMN metroBus.capacidadPasajeros IS 'La capacidad de pasajeros que permite el Metro Bus';
COMMENT ON COLUMN metroBus.inicioOperacion IS 'El inicio de operaciones del Metro Bus';

CREATE TABLE microBuses(
	id_Vehiculo SERIAL NOT NULL UNIQUE,
	numeroRuta INT NOT NULL,
	operando BOOLEAN NOT NULL,
	capacidadPasajeros INT NOT NULL,
	inicioOperacion DATE NOT NULL
	--PRIMARY KEY(id_Vehiculo),
	--FOREIGN KEY(numeroRuta) REFERENCES ruta(numeroRuta)
	--CONSTRAINT microBuses_pkey PRIMARY KEY (id_Vehiculo),
	--CONSTRAINT microBuses_fkey FOREIGN KEY (numeroRuta)
    --REFERENCES ruta(numeroRuta)
);

COMMENT ON TABLE microBuses IS 'Tabla que contiene la informacion del vehiculo Micro Bus';
COMMENT ON COLUMN microBuses.id_Vehiculo IS 'El identificador del Micro Bus';
COMMENT ON COLUMN microBuses.numeroRuta IS 'El identificador de la Ruta';
COMMENT ON COLUMN microBuses.operando IS 'Nos indica si esta activo el Micro Bus';
COMMENT ON COLUMN microBuses.capacidadPasajeros IS 'La capacidad de pasajeros que permite el Micro Bus';
COMMENT ON COLUMN microBuses.inicioOperacion IS 'El inicio de operaciones del Micro Bus';

CREATE TABLE rtp(
	id_Vehiculo SERIAL NOT NULL UNIQUE,
	numeroRuta INT NOT NULL,
	operando BOOLEAN NOT NULL,
	capacidadPasajeros INT NOT NULL,
	inicioOperacion DATE NOT NULL
	--PRIMARY KEY(id_Vehiculo),
	--FOREIGN KEY(numeroRuta) REFERENCES ruta(numeroRuta)
	--CONSTRAINT rtp_pkey PRIMARY KEY (id_Vehiculo),
	--CONSTRAINT rtp_fkey FOREIGN KEY (numeroRuta)
    --REFERENCES ruta(numeroRuta)
);

COMMENT ON TABLE rtp IS 'Tabla que contiene la informacion del vehiculo RTP';
COMMENT ON COLUMN rtp.id_Vehiculo IS 'El identificador del RTP';
COMMENT ON COLUMN rtp.numeroRuta IS 'El identificador de la Ruta';
COMMENT ON COLUMN rtp.operando IS 'Nos indica si esta activo el RTP';
COMMENT ON COLUMN rtp.capacidadPasajeros IS 'La capacidad de pasajeros que permite el RTP';
COMMENT ON COLUMN rtp.inicioOperacion IS 'El inicio de operaciones del RTP';

CREATE TABLE troleBus(
	id_Vehiculo SERIAL NOT NULL UNIQUE,
	numeroRuta INT NOT NULL,
	operando BOOLEAN NOT NULL,
	capacidadPasajeros INT NOT NULL,
	inicioOperacion DATE NOT NULL	
	--PRIMARY KEY(id_Vehiculo),
	--FOREIGN KEY(numeroRuta) REFERENCES ruta(numeroRuta)
	--CONSTRAINT troleBus_pkey PRIMARY KEY (id_Vehiculo),
	--CONSTRAINT troleBus_fkey FOREIGN KEY (numeroRuta)
    --REFERENCES ruta(numeroRuta)
);

COMMENT ON TABLE troleBus IS 'Tabla que contiene la informacion del vehiculo TroleBus';
COMMENT ON COLUMN troleBus.id_Vehiculo IS 'El identificador del TroleBus';
COMMENT ON COLUMN troleBus.numeroRuta IS 'El identificador de la Ruta';
COMMENT ON COLUMN troleBus.operando IS 'Nos indica si esta activo el TroleBus';
COMMENT ON COLUMN troleBus.capacidadPasajeros IS 'La capacidad de pasajeros que permite el RTP';
COMMENT ON COLUMN troleBus.inicioOperacion IS 'El inicio de operaciones del RTP';

CREATE TABLE taxi(
	id_Vehiculo SERIAL NOT NULL UNIQUE,
	numeroSitio INT NOT NULL,
	operando BOOLEAN NOT NULL,
	capacidadPasajeros INT NOT NULL,
	inicioOperacion DATE NOT NULL
	--PRIMARY KEY(id_Vehiculo),
	--FOREIGN KEY(numeroSitio) REFERENCES sitio(numeroSitio)
	--CONSTRAINT taxi_pkey PRIMARY KEY (id_Vehiculo),
	--CONSTRAINT taxi_fkey FOREIGN KEY (numeroSitio)
    --REFERENCES sitio(numeroSitio)
);

COMMENT ON TABLE taxi IS 'Tabla que contiene la informacion del vehiculo Taxi';
COMMENT ON COLUMN taxi.id_Vehiculo IS 'El identificador del Taxi';
COMMENT ON COLUMN taxi.numeroSitio IS 'El identificador del Sitio';
COMMENT ON COLUMN taxi.operando IS 'Nos indica si esta activo el Taxi';
COMMENT ON COLUMN taxi.capacidadPasajeros IS 'La capacidad de pasajeros que permite el Taxi';
COMMENT ON COLUMN taxi.inicioOperacion IS 'El inicio de operaciones del Taxi';

CREATE TABLE manejarMetro(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES operador(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES metro(id_Vehiculo)
	--CONSTRAINT manejarMetro_fkey1 FOREIGN KEY (curp)
    --REFERENCES operador(curp),
	--CONSTRAINT manejarMetro_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES metro(id_Vehiculo)
	
);

COMMENT ON TABLE manejarMetro IS 'Tabla que contiene la informacion de aquellos operadores que manejan metro';
COMMENT ON COLUMN manejarMetro.curp IS 'El identificador del operador';
COMMENT ON COLUMN manejarMetro.id_Vehiculo IS 'El identificador del metro';

CREATE TABLE manejarTrenLigero(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES operador(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES trenLigero(id_Vehiculo)
	--CONSTRAINT manejarTrenLigero_fkey1 FOREIGN KEY (curp)
    --REFERENCES operador(curp),
	--CONSTRAINT manejarTrenLigero_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES trenLigero(id_Vehiculo)
);

COMMENT ON TABLE manejarTrenLigero IS 'Tabla que contiene la informacion de aquellos operadores que manejan tren ligero';
COMMENT ON COLUMN manejarTrenLigero.curp IS 'El identificador del operador';
COMMENT ON COLUMN manejarTrenLigero.id_Vehiculo IS 'El identificador del Tren Ligero';

CREATE TABLE manejarMetroBus(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES operador(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES metroBus(id_Vehiculo)
	--CONSTRAINT manejarMetroBus_fkey1 FOREIGN KEY (curp)
    --REFERENCES operador(curp),
	--CONSTRAINT manejarMetroBus_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES metroBus(id_Vehiculo)
);

COMMENT ON TABLE manejarMetroBus IS 'Tabla que contiene la informacion de aquellos operadores que manejan metro bus';
COMMENT ON COLUMN manejarMetroBus.curp IS 'El identificador del operador';
COMMENT ON COLUMN manejarMetroBus.id_Vehiculo IS 'El identificador del Metro Bus';

CREATE TABLE manejarMicroBuses(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES operador(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES microBuses(id_Vehiculo)
	--CONSTRAINT manejarMicroBuses_fkey1 FOREIGN KEY (curp)
    --REFERENCES operador(curp),
	--CONSTRAINT manejarMicroBuses_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES microBuses(id_Vehiculo)
);

COMMENT ON TABLE manejarMicroBuses IS 'Tabla que contiene la informacion de aquellos operadores que manejan micro bus';
COMMENT ON COLUMN manejarMicroBuses.curp IS 'El identificador del operador';
COMMENT ON COLUMN manejarMicroBuses.id_Vehiculo IS 'El identificador del Micro Bus';

CREATE TABLE manejarRTP(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES operador(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES rtp(id_Vehiculo)
	--CONSTRAINT manejarRTP_fkey1 FOREIGN KEY (curp)
    --REFERENCES operador(curp),
	--CONSTRAINT manejarRTP_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES rtp(id_Vehiculo)
);

COMMENT ON TABLE manejarRTP IS 'Tabla que contiene la informacion de aquellos operadores que manejan RTP';
COMMENT ON COLUMN manejarRTP.curp IS 'El identificador del operador';
COMMENT ON COLUMN manejarRTP.id_Vehiculo IS 'El identificador del RTP';

CREATE TABLE manejarTrolebus(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES operador(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES troleBus(id_Vehiculo)
	--CONSTRAINT manejarTroleBus_fkey1 FOREIGN KEY (curp)
    --REFERENCES operador(curp),
	--CONSTRAINT manejarTroleBus_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES troleBus(id_Vehiculo)
	
);

COMMENT ON TABLE manejarTrolebus IS 'Tabla que contiene la informacion de aquellos operadores que manejan TroleBus';
COMMENT ON COLUMN manejarTrolebus.curp IS 'El identificador del operador';
COMMENT ON COLUMN manejarTrolebus.id_Vehiculo IS 'El identificador del TroleBus';

CREATE TABLE manejarTaxi(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES operador(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES taxi(id_Vehiculo)
	--CONSTRAINT manejarTaxi_fkey1 FOREIGN KEY (curp)
    --REFERENCES operador(curp),
	--CONSTRAINT manejarTaxi_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES taxi(id_Vehiculo)
);

COMMENT ON TABLE manejarTaxi IS 'Tabla que contiene la informacion de aquellos operadores que manejan Taxi';
COMMENT ON COLUMN manejarTaxi.curp IS 'El identificador del operador';
COMMENT ON COLUMN manejarTaxi.id_Vehiculo IS 'El identificador del Taxi';

CREATE TABLE pagarMetro(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES usuario(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES metro(id_Vehiculo)
	--CONSTRAINT pagarMetro_fkey1 FOREIGN KEY (curp)
    --REFERENCES usuario(curp),
	--CONSTRAINT pagarMetro_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES metro(id_Vehiculo)
	
);

COMMENT ON TABLE pagarMetro IS 'Tabla que contiene la informacion de aquellos usuarios que pagaron el metro';
COMMENT ON COLUMN pagarMetro.curp IS 'El identificador del usuario';
COMMENT ON COLUMN pagarMetro.id_Vehiculo IS 'El identificador del metro';

CREATE TABLE pagarTrenLigero(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES usuario(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES trenLigero(id_Vehiculo)
	--CONSTRAINT pagarTrenLigero_fkey1 FOREIGN KEY (curp)
    --REFERENCES usuario(curp),
	--CONSTRAINT pagarTrenLigero_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES trenLigero(id_Vehiculo)
);

COMMENT ON TABLE pagarTrenLigero IS 'Tabla que contiene la informacion de aquellos usuarios que pagaron el Tren Ligero';
COMMENT ON COLUMN pagarTrenLigero.curp IS 'El identificador del usuario';
COMMENT ON COLUMN pagarTrenLigero.id_Vehiculo IS 'El identificador del Tren Ligero';

CREATE TABLE pagarMetroBus(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES usuario(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES metroBus(id_Vehiculo)
	--CONSTRAINT pagarMetroBus_fkey1 FOREIGN KEY (curp)
    --REFERENCES usuario(curp),
	--CONSTRAINT pagarMetroBus_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES metroBus(id_Vehiculo)
);

COMMENT ON TABLE pagarMetroBus IS 'Tabla que contiene la informacion de aquellos usuarios que pagaron el MetroBus';
COMMENT ON COLUMN pagarMetroBus.curp IS 'El identificador del usuario';
COMMENT ON COLUMN pagarMetroBus.id_Vehiculo IS 'El identificador del MetroBus';

CREATE TABLE pagarMicroBuses(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES usuario(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES microBuses(id_Vehiculo)
	--CONSTRAINT pagarMicroBuses_fkey1 FOREIGN KEY (curp)
    --REFERENCES usuario(curp),
	--CONSTRAINT pagarMicroBuses_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES microBuses(id_Vehiculo)
);

COMMENT ON TABLE pagarMicroBuses IS 'Tabla que contiene la informacion de aquellos usuarios que pagaron el MicroBus';
COMMENT ON COLUMN pagarMicroBuses.curp IS 'El identificador del usuario';
COMMENT ON COLUMN pagarMicroBuses.id_Vehiculo IS 'El identificador del MicroBus';

CREATE TABLE pagarRTP(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES usuario(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES rtp(id_Vehiculo)
	--CONSTRAINT pagarRTP_fkey1 FOREIGN KEY (curp)
    --REFERENCES usuario(curp),
	--CONSTRAINT pagarRTP_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES rtp(id_Vehiculo)
);

COMMENT ON TABLE pagarRTP IS 'Tabla que contiene la informacion de aquellos usuarios que pagaron el RTP';
COMMENT ON COLUMN pagarRTP.curp IS 'El identificador del usuario';
COMMENT ON COLUMN pagarRTP.id_Vehiculo IS 'El identificador del RTP';

CREATE TABLE pagarTrolebus(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES usuario(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES troleBus(id_Vehiculo)
	--CONSTRAINT pagarTroleBus_fkey1 FOREIGN KEY (curp)
    --REFERENCES usuario(curp),
	--CONSTRAINT pagarTroleBus_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES troleBus(id_Vehiculo)
	
);

COMMENT ON TABLE pagarTrolebus IS 'Tabla que contiene la informacion de aquellos usuarios que pagaron el Trolebus';
COMMENT ON COLUMN pagarTrolebus.curp IS 'El identificador del usuario';
COMMENT ON COLUMN pagarTrolebus.id_Vehiculo IS 'El identificador del Trolebus';


CREATE TABLE pagarTaxi(
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	id_Vehiculo SERIAL NOT NULL
	--FOREIGN KEY(curp) REFERENCES usuario(curp),
	--FOREIGN KEY(id_Vehiculo) REFERENCES taxi(id_Vehiculo)
	--CONSTRAINT pagarTaxi_fkey1 FOREIGN KEY (curp)
    --REFERENCES usuario(curp),
	--CONSTRAINT pagarTaxi_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES taxi(id_Vehiculo)
);

COMMENT ON TABLE pagarTaxi IS 'Tabla que contiene la informacion de aquellos usuarios que pagaron el Taxi';
COMMENT ON COLUMN pagarTaxi.curp IS 'El identificador del usuario';
COMMENT ON COLUMN pagarTaxi.id_Vehiculo IS 'El identificador del Taxi';

CREATE TABLE repararMetro(
	id_Taller INT NOT NULL,
	id_Vehiculo SERIAL NOT NULL,
	fechaIngreso DATE NOT NULL,
	fechaSalida DATE NOT NULL,
	razon VARCHAR(50) CHECK(razon <> '')
	--FOREIGN KEY(id_Taller) REFERENCES taller(id_Taller),
	--FOREIGN KEY(id_Vehiculo) REFERENCES metro(id_Vehiculo)
	--CONSTRAINT repararMetro_fkey1 FOREIGN KEY (taller)
    --REFERENCES taller(id_Taller),
	--CONSTRAINT repararMetro_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES metro(id_Vehiculo)

);

COMMENT ON TABLE repararMetro IS 'Tabla que contiene la informacion de reparacion del metro';
COMMENT ON COLUMN repararMetro.id_Taller IS 'El identificador del taller';
COMMENT ON COLUMN repararMetro.id_Vehiculo IS 'El identificador del metro';
COMMENT ON COLUMN repararMetro.fechaIngreso IS 'La fecha de ingreso al taller';
COMMENT ON COLUMN repararMetro.fechaSalida IS 'La fecha de salida del taller';
COMMENT ON COLUMN repararMetro.razon IS 'La razon de la reparacion del Metro';

CREATE TABLE repararTrenLigero(
	id_Taller INT NOT NULL,
	id_Vehiculo SERIAL NOT NULL,
	fechaIngreso DATE NOT NULL,
	fechaSalida DATE NOT NULL,
	razon VARCHAR(50) CHECK(razon <> '')
	--FOREIGN KEY(id_Taller) REFERENCES taller(id_Taller),
	--FOREIGN KEY(id_Vehiculo) REFERENCES trenLigero(id_Vehiculo)
	--CONSTRAINT repararTrenLigero_fkey1 FOREIGN KEY (taller)
    --REFERENCES taller(id_Taller),
	--CONSTRAINT repararTrenLigero_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES trenLigero(id_Vehiculo)
);

COMMENT ON TABLE repararTrenLigero IS 'Tabla que contiene la informacion de reparacion del Tren Ligero';
COMMENT ON COLUMN repararTrenLigero.id_Taller IS 'El identificador del taller';
COMMENT ON COLUMN repararTrenLigero.id_Vehiculo IS 'El identificador del Tren Ligero';
COMMENT ON COLUMN repararTrenLigero.fechaIngreso IS 'La fecha de ingreso al taller';
COMMENT ON COLUMN repararTrenLigero.fechaSalida IS 'La fecha de salida del taller';
COMMENT ON COLUMN repararTrenLigero.razon IS 'La razon de la reparacion del Tren Ligero';

CREATE TABLE repararMetroBus(
	id_Taller INT NOT NULL,
	id_Vehiculo SERIAL NOT NULL,
	fechaIngreso DATE NOT NULL,
	fechaSalida DATE NOT NULL,
	razon VARCHAR(50) CHECK(razon <> '')
	--FOREIGN KEY(id_Taller) REFERENCES taller(id_Taller),
	--FOREIGN KEY(id_Vehiculo) REFERENCES metroBus(id_Vehiculo)
	--CONSTRAINT repararMetroBus_fkey1 FOREIGN KEY (taller)
    --REFERENCES taller(id_Taller),
	--CONSTRAINT repararMetroBus_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES metroBus(id_Vehiculo)
);

COMMENT ON TABLE repararMetroBus IS 'Tabla que contiene la informacion de reparacion del Metro Bus';
COMMENT ON COLUMN repararMetroBus.id_Taller IS 'El identificador del taller';
COMMENT ON COLUMN repararMetroBus.id_Vehiculo IS 'El identificador del Metro Bus';
COMMENT ON COLUMN repararMetroBus.fechaIngreso IS 'La fecha de ingreso al taller';
COMMENT ON COLUMN repararMetroBus.fechaSalida IS 'La fecha de salida del taller';
COMMENT ON COLUMN repararMetroBus.razon IS 'La razon de la reparacion del Metro Bus';

CREATE TABLE repararMicroBuses(
	id_Taller INT NOT NULL,
	id_Vehiculo SERIAL NOT NULL,
	fechaIngreso DATE NOT NULL,
	fechaSalida DATE NOT NULL,
	razon VARCHAR(50) CHECK(razon <> '')
	--FOREIGN KEY(id_Taller) REFERENCES taller(id_Taller),
	--FOREIGN KEY(id_Vehiculo) REFERENCES microBuses(id_Vehiculo)
	--CONSTRAINT repararMicroBuses_fkey1 FOREIGN KEY (taller)
    --REFERENCES taller(id_Taller),
	--CONSTRAINT repararMicroBuses_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES microBuses(id_Vehiculo)
);

COMMENT ON TABLE repararMicroBuses IS 'Tabla que contiene la informacion de reparacion del MicroBus';
COMMENT ON COLUMN repararMicroBuses.id_Taller IS 'El identificador del taller';
COMMENT ON COLUMN repararMicroBuses.id_Vehiculo IS 'El identificador del MicroBus';
COMMENT ON COLUMN repararMicroBuses.fechaIngreso IS 'La fecha de ingreso al taller';
COMMENT ON COLUMN repararMicroBuses.fechaSalida IS 'La fecha de salida del taller';
COMMENT ON COLUMN repararMicroBuses.razon IS 'La razon de la reparacion del MicroBus';

CREATE TABLE repararRTP(
	id_Taller INT NOT NULL,
	id_Vehiculo SERIAL NOT NULL,
	fechaIngreso DATE NOT NULL,
	fechaSalida DATE NOT NULL,
	razon VARCHAR(50) CHECK(razon <> '')
	--FOREIGN KEY(id_Taller) REFERENCES taller(id_Taller),
	--FOREIGN KEY(id_Vehiculo) REFERENCES rtp(id_Vehiculo)
	--CONSTRAINT repararRTP_fkey1 FOREIGN KEY (taller)
    --REFERENCES taller(id_Taller),
	--CONSTRAINT repararRTP_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES rtp(id_Vehiculo)
);

COMMENT ON TABLE repararRTP IS 'Tabla que contiene la informacion de reparacion del RTP';
COMMENT ON COLUMN repararRTP.id_Taller IS 'El identificador del taller';
COMMENT ON COLUMN repararRTP.id_Vehiculo IS 'El identificador del RTP';
COMMENT ON COLUMN repararRTP.fechaIngreso IS 'La fecha de ingreso al taller';
COMMENT ON COLUMN repararRTP.fechaSalida IS 'La fecha de salida del taller';
COMMENT ON COLUMN repararRTP.razon IS 'La razon de la reparacion del RTP';

CREATE TABLE repararTrolebus(
	id_Taller INT NOT NULL,
	id_Vehiculo SERIAL NOT NULL,
	fechaIngreso DATE NOT NULL,
	fechaSalida DATE NOT NULL,
	razon VARCHAR(50) CHECK(razon <> '')
	--FOREIGN KEY(id_Taller) REFERENCES taller(id_Taller),
	--FOREIGN KEY(id_Vehiculo) REFERENCES troleBus(id_Vehiculo)
	--CONSTRAINT repararTrolebus_fkey1 FOREIGN KEY (taller)
    --REFERENCES taller(id_Taller),
	--CONSTRAINT repararTrolebus_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES troleBus(id_Vehiculo)
);

COMMENT ON TABLE repararTrolebus IS 'Tabla que contiene la informacion de reparacion del TroleBus';
COMMENT ON COLUMN repararTrolebus.id_Taller IS 'El identificador del taller';
COMMENT ON COLUMN repararTrolebus.id_Vehiculo IS 'El identificador del TroleBus';
COMMENT ON COLUMN repararTrolebus.fechaIngreso IS 'La fecha de ingreso al taller';
COMMENT ON COLUMN repararTrolebus.fechaSalida IS 'La fecha de salida del taller';
COMMENT ON COLUMN repararTrolebus.razon IS 'La razon de la reparacion del TroleBus';

CREATE TABLE repararTaxi(
	id_Taller INT NOT NULL,
	id_Vehiculo SERIAL NOT NULL,
	fechaIngreso DATE NOT NULL,
	fechaSalida DATE NOT NULL,
	razon VARCHAR(50) CHECK(razon <> '')
	--FOREIGN KEY(id_Taller) REFERENCES taller(id_Taller),
	--FOREIGN KEY(id_Vehiculo) REFERENCES taxi(id_Vehiculo)
	--CONSTRAINT repararTaxi_fkey1 FOREIGN KEY (taller)
    --REFERENCES taller(id_Taller),
	--CONSTRAINT repararTaxi_fkey2 FOREIGN KEY (id_Vehiculo)
    --REFERENCES taxi(id_Vehiculo)
);

COMMENT ON TABLE repararTaxi IS 'Tabla que contiene la informacion de reparacion del Taxi';
COMMENT ON COLUMN repararTaxi.id_Taller IS 'El identificador del taller';
COMMENT ON COLUMN repararTaxi.id_Vehiculo IS 'El identificador del Taxi';
COMMENT ON COLUMN repararTaxi.fechaIngreso IS 'La fecha de ingreso al taller';
COMMENT ON COLUMN repararTaxi.fechaSalida IS 'La fecha de salida del taller';
COMMENT ON COLUMN repararTaxi.razon IS 'La razon de la reparacion del Taxi';

CREATE TABLE MetodoPago(
	idPago INT NOT NULL UNIQUE,
	curp CHAR(18) NOT NULL CHECK(CHAR_LENGTH(curp)=18),
	cuentaPaypal INT CHECK(cuentaPaypal BETWEEN 100000 AND 999999),
	numeroDeTarjeta INT CHECK(numeroDeTarjeta <> 0) ,
	vencimiento DATE CHECK(vencimiento > '2022-01-01'),
	cvv INT CHECK (cvv between 100 and 999),
	esTarjeta BOOLEAN NOT NULL,
	esPaypal BOOLEAN NOT NULL
	--PRIMARY KEY(idPago),
	--FOREIGN KEY(curp) REFERENCES usuario(curp)
	--CONSTRAINT MetodoPago_pkey PRIMARY KEY (idPago),
	--CONSTRAINT MetodoPago_fkey FOREIGN KEY (curp)
    --REFERENCES usuario(curp),
);

COMMENT ON TABLE MetodoPago IS 'Tabla que contiene la información de los metodos de pago';
COMMENT ON COLUMN MetodoPago.idPago IS 'El identificador del Metodo de Pago';
COMMENT ON COLUMN MetodoPago.curp IS 'El curp de los usuarios que tienen algun metodo de pago';
COMMENT ON COLUMN MetodoPago.cuentaPaypal IS 'El numero de la cuenta de paypal en caso de que lo tenga el usuario';
COMMENT ON COLUMN MetodoPago.numeroDeTarjeta IS 'El numero de tarjeta en caso de que lo tenga el usuario';
COMMENT ON COLUMN MetodoPago.vencimiento IS 'El dia y mes de vencimiento que tiene la tarjeta';
COMMENT ON COLUMN MetodoPago.cvv IS 'El cvv que tiene la tarjeta del usuario';
COMMENT ON COLUMN MetodoPago.esTarjeta IS 'Valor Booleano que indica si el metodo de pago es tarjeta';
COMMENT ON COLUMN MetodoPago.esPaypal IS 'Valor Booleano que indica si el metodo de pago es por paypal';

CREATE TABLE componerse(
	id_Estacion INT NOT NULL,
	numeroLinea INT NOT NULL
	--FOREIGN KEY(id_Estacion) REFERENCES estacion(id_Estacion)
	--FOREIGN KEY(numeroLinea) REFERENCES linea(numeroLinea)
	--CONSTRAINT componerse_fkey1 FOREIGN KEY (id_Estacion)
    --REFERENCES estacion(id_Estacion),
	--CONSTRAINT componerse_fkey2 FOREIGN KEY (numeroLinea)
    --REFERENCES linea(numeroLinea),
);

COMMENT ON TABLE componerse IS 'Tabla que contiene la información de las estaciones que contiene lineas';
COMMENT ON COLUMN componerse.id_Estacion IS 'El identificador de la estacion';
COMMENT ON COLUMN componerse.numeroLinea IS 'El identificador de la linea';

CREATE TABLE contar(
	id_Estacion INT NOT NULL,
	numeroRuta SERIAL NOT NULL
	--FOREIGN KEY(id_Estacion) REFERENCES estacion(id_Estacion)
	--FOREIGN KEY(numeroRuta) REFERENCES ruta(numeroRuta)
	--CONSTRAINT contar_fkey1 FOREIGN KEY (id_Estacion)
    --REFERENCES estacion(id_Estacion),
	--CONSTRAINT contar_fkey2 FOREIGN KEY (numeroRuta)
    --REFERENCES ruta(numeroRuta)
);

COMMENT ON TABLE contar IS 'Tabla que contiene la información de las estaciones que contiene rutas';
COMMENT ON COLUMN contar.id_Estacion IS 'El identificador de la estacion';
COMMENT ON COLUMN contar.numeroRuta IS 'El identificador de la ruta';

CREATE TABLE deshabilitar(
	id_Estacion INT NOT NULL,
	id_Incidente SERIAL NOT NULL,
	fechaReApertura DATE NOt NULL
	--FOREIGN KEY(id_Estacion) REFERENCES estacion(id_Estacion)
	--FOREIGN KEY(id_Incidente) REFERENCES incidente(id_Incidente)
	--CONSTRAINT deshabilitar_fkey1 FOREIGN KEY (id_Estacion)
    --REFERENCES estacion(id_Estacion),
	--CONSTRAINT deshabilitar_fkey2 FOREIGN KEY (id_Incidente)
    --REFERENCES incidente(id_Incidente)
);

COMMENT ON TABLE deshabilitar IS 'Tabla que contiene la informacion de las estaciones que sufrieron algun incidente';
COMMENT ON COLUMN deshabilitar.id_Estacion IS 'El identificador de la estacion';
COMMENT ON COLUMN deshabilitar.id_Incidente IS 'El identificador del incidente';
COMMENT ON COLUMN deshabilitar.fechaReApertura IS 'La fecha de reapertura de la estación que sufrio algun incidente';

/*
Integridad Referencial
*/
--Llaves Primarias
ALTER TABLE operador ADD CONSTRAINT operador_pkey PRIMARY KEY (curp);

COMMENT ON CONSTRAINT operador_pkey ON operador IS 'La llave primaria de la tabla operador';

ALTER TABLE usuario ADD CONSTRAINT usuario_pkey PRIMARY KEY (curp);

COMMENT ON CONSTRAINT usuario_pkey ON usuario IS 'La llave primaria de la tabla usuario';

ALTER TABLE taller ADD CONSTRAINT taller_pkey PRIMARY KEY (id_Taller);

COMMENT ON CONSTRAINT taller_pkey ON taller IS 'La llave primaria de la tabla taller';

ALTER TABLE linea ADD CONSTRAINT linea_pkey PRIMARY KEY (numeroLinea);

COMMENT ON CONSTRAINT linea_pkey ON linea IS 'La llave primaria de la tabla linea';

ALTER TABLE ruta ADD CONSTRAINT ruta_pkey PRIMARY KEY (numeroRuta);

COMMENT ON CONSTRAINT ruta_pkey ON ruta IS 'La llave primaria de la tabla ruta';

ALTER TABLE sitio ADD CONSTRAINT sitio_pkey PRIMARY KEY (numeroSitio);

COMMENT ON CONSTRAINT sitio_pkey ON sitio IS 'La llave primaria de la tabla sitio';

ALTER TABLE estacion ADD CONSTRAINT estacion_pkey PRIMARY KEY (id_Estacion);

COMMENT ON CONSTRAINT estacion_pkey ON estacion IS 'La llave primaria de la tabla estacion';

ALTER TABLE incidente ADD CONSTRAINT incidente_pkey PRIMARY KEY (id_Incidente);

COMMENT ON CONSTRAINT incidente_pkey ON incidente IS 'La llave primaria de la tabla incidente';

--Llaves Compuestas
ALTER TABLE telefono ADD CONSTRAINT telefono_pkey PRIMARY KEY (curp,telefono);
COMMENT ON CONSTRAINT telefono_pkey ON telefono IS 'La llave compuesta de la tabla telefono';
ALTER TABLE telefono ADD CONSTRAINT telefono_fkey FOREIGN KEY (curp)
REFERENCES operador (curp) /*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT telefono_fkey ON telefono IS 'La llave foranea de la tabla telefono que referencia a operador';

ALTER TABLE tipoVehiculo ADD CONSTRAINT tipoVehiculo_pkey PRIMARY KEY (curp,tipoVehiculo);
COMMENT ON CONSTRAINT tipoVehiculo_pkey ON tipoVehiculo IS 'La llave compuesta de la tabla tipoVehiculo';
ALTER TABLE tipoVehiculo ADD CONSTRAINT tipoVehiculo_fkey FOREIGN KEY (curp)
REFERENCES operador (curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT tipoVehiculo_fkey ON tipoVehiculo IS 'La llave foranea de la tabla tipoVehiculo que referencia a operador';

ALTER TABLE dias ADD CONSTRAINT dias_pkey PRIMARY KEY (curp,dias);
COMMENT ON CONSTRAINT dias_pkey ON dias IS 'La llave compuesta de la tabla dias';
ALTER TABLE dias ADD CONSTRAINT dias_fkey FOREIGN KEY (curp)
REFERENCES operador (curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT dias_fkey ON dias IS 'La llave foranea de la tabla dias que referencia a operador';

ALTER TABLE licencia ADD CONSTRAINT licencia_pkey PRIMARY KEY (curp,numeroDeLicencia);
COMMENT ON CONSTRAINT licencia_pkey ON licencia IS 'La llave compuesta de la tabla licencia';
ALTER TABLE licencia ADD CONSTRAINT licencia_fkey FOREIGN KEY (curp)
REFERENCES operador (curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT licencia_fkey ON licencia IS 'La llave foranea de la tabla licencia que referencia a operador';

ALTER TABLE examenMedico ADD CONSTRAINT examen_pkey PRIMARY KEY (curp,id_Examen);
COMMENT ON CONSTRAINT examen_pkey ON examenMedico IS 'La llave compuesta de la tabla examenMedico';
ALTER TABLE examenMedico ADD CONSTRAINT examen_fkey FOREIGN KEY (curp)
REFERENCES operador (curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT examen_fkey ON examenMedico IS 'La llave foranea de la tabla examenMedico que referencia a operador';

ALTER TABLE especialidad ADD CONSTRAINT especialidad_pkey PRIMARY KEY (id_Taller,especialidad);
COMMENT ON CONSTRAINT especialidad_pkey ON especialidad IS 'La llave compuesta de la tabla especialidad';
ALTER TABLE especialidad ADD CONSTRAINT especialidad_fkey FOREIGN KEY (id_Taller)
REFERENCES taller (id_Taller)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT especialidad_fkey ON especialidad IS 'La llave foranea de la tabla especialidad que referencia a taller';

ALTER TABLE tipoTransporte ADD CONSTRAINT tipoTransporte_pkey PRIMARY KEY (id_Estacion,tipoTransporte);
COMMENT ON CONSTRAINT tipoTransporte_pkey ON tipoTransporte IS 'La llave compuesta de la tabla tipoTransporte';
ALTER TABLE tipoTransporte ADD CONSTRAINT tipoTransporte_fkey FOREIGN KEY (id_Estacion)
REFERENCES estacion (id_Estacion)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT tipoTransporte_fkey ON tipoTransporte IS 'La llave foranea de la tabla tipoTransporte que referencia a estacion';

ALTER TABLE lineaIncidente ADD CONSTRAINT lineaIncidente_pkey PRIMARY KEY (id_Incidente,lineaIncidente);
COMMENT ON CONSTRAINT lineaIncidente_pkey ON lineaIncidente IS 'La llave compuesta de la tabla lineaIncidente';
ALTER TABLE lineaIncidente ADD CONSTRAINT lineaIncidente_fkey FOREIGN KEY (id_Incidente)
REFERENCES incidente (id_Incidente)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT lineaIncidente_fkey ON lineaIncidente IS 'La llave foranea de la tabla lineaIncidente que referencia a incidente';

--Llaves Foraneas
ALTER TABLE metro ADD CONSTRAINT metro_pkey PRIMARY KEY (id_Vehiculo);
COMMENT ON CONSTRAINT metro_pkey ON metro IS 'La llave primaria de la tabla metro';
ALTER TABLE metro ADD CONSTRAINT metro_fkey FOREIGN KEY (numeroLinea)
REFERENCES linea(numeroLinea)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT metro_fkey ON metro IS 'La llave foranea de la tabla metro que referencia a linea';

ALTER TABLE trenLigero ADD CONSTRAINT trenLigero_pkey PRIMARY KEY (id_Vehiculo);
COMMENT ON CONSTRAINT trenLigero_pkey ON trenLigero IS 'La llave primaria de la tabla trenLigero';
ALTER TABLE trenLigero ADD CONSTRAINT trenLigero_fkey FOREIGN KEY (numeroLinea)
REFERENCES linea(numeroLinea)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT trenLigero_fkey ON trenLigero IS 'La llave foranea de la tabla trenLigero que referencia a linea';

ALTER TABLE metroBus ADD CONSTRAINT metroBus_pkey PRIMARY KEY (id_Vehiculo);
COMMENT ON CONSTRAINT metroBus_pkey ON metroBus IS 'La llave primaria de la tabla metroBus';
ALTER TABLE metroBus ADD CONSTRAINT metroBus_fkey FOREIGN KEY (numeroLinea)
REFERENCES linea(numeroLinea)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT metroBus_fkey ON metroBus IS 'La llave foranea de la tabla metroBus que referencia a linea';

ALTER TABLE microBuses ADD CONSTRAINT microBuses_pkey PRIMARY KEY (id_Vehiculo);
COMMENT ON CONSTRAINT microBuses_pkey ON microBuses IS 'La llave primaria de la tabla microBuses';
ALTER TABLE microBuses ADD CONSTRAINT microBuses_fkey FOREIGN KEY (numeroRuta)
REFERENCES ruta(numeroRuta)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT microBuses_fkey ON microBuses IS 'La llave foranea de la tabla microBuses que referencia a ruta';

ALTER TABLE rtp ADD CONSTRAINT rtp_pkey PRIMARY KEY (id_Vehiculo);
COMMENT ON CONSTRAINT rtp_pkey ON rtp IS 'La llave primaria de la tabla rtp';
ALTER TABLE rtp ADD CONSTRAINT rtp_fkey FOREIGN KEY (numeroRuta)
REFERENCES ruta(numeroRuta)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT rtp_fkey ON rtp IS 'La llave foranea de la tabla rtp que referencia a ruta';

ALTER TABLE troleBus ADD CONSTRAINT troleBus_pkey PRIMARY KEY (id_Vehiculo);
COMMENT ON CONSTRAINT troleBus_pkey ON troleBus IS 'La llave primaria de la tabla troleBus';
ALTER TABLE troleBus ADD CONSTRAINT troleBus_fkey FOREIGN KEY (numeroRuta)
REFERENCES ruta(numeroRuta)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT troleBus_fkey ON troleBus IS 'La llave foranea de la tabla troleBus que referencia a ruta';

ALTER TABLE taxi ADD CONSTRAINT taxi_pkey PRIMARY KEY (id_Vehiculo);
COMMENT ON CONSTRAINT taxi_pkey ON taxi IS 'La llave primaria de la tabla taxi';
ALTER TABLE taxi ADD CONSTRAINT taxi_fkey FOREIGN KEY (numeroSitio)
REFERENCES sitio(numeroSitio)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT taxi_fkey ON taxi IS 'La llave foranea de la tabla taxi que referencia a sitio';

ALTER TABLE manejarMetro ADD CONSTRAINT manejarMetro_fkey1 FOREIGN KEY (curp)
REFERENCES operador(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarMetro_fkey1 ON manejarMetro IS 'La llave foranea de la tabla manejarMetro que referencia a operador';
ALTER TABLE manejarMetro ADD CONSTRAINT manejarMetro_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES metro(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarMetro_fkey2 ON manejarMetro IS 'La llave foranea de la tabla manejarMetro que referencia a metro';

ALTER TABLE manejarTrenLigero ADD CONSTRAINT manejarTrenLigero_fkey1 FOREIGN KEY (curp)
REFERENCES operador(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarTrenLigero_fkey1 ON manejarTrenLigero IS 'La llave foranea de la tabla manejarTrenLigero que referencia a operador';
ALTER TABLE manejarTrenLigero ADD CONSTRAINT manejarTrenLigero_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES trenLigero(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarTrenLigero_fkey2 ON manejarTrenLigero IS 'La llave foranea de la tabla manejarTrenLigero que referencia a trenLigero';

ALTER TABLE manejarMetroBus ADD CONSTRAINT manejarMetroBus_fkey1 FOREIGN KEY (curp)
REFERENCES operador(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarMetroBus_fkey1 ON manejarMetroBus IS 'La llave foranea de la tabla manejarMetroBus que referencia a operador';
ALTER TABLE manejarMetroBus ADD CONSTRAINT manejarMetroBus_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES metroBus(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarMetroBus_fkey2 ON manejarMetroBus IS 'La llave foranea de la tabla manejarMetroBus que referencia a metroBus';

ALTER TABLE manejarMicroBuses ADD CONSTRAINT manejarMicroBuses_fkey1 FOREIGN KEY (curp)
REFERENCES operador(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarMicroBuses_fkey1 ON manejarMicroBuses IS 'La llave foranea de la tabla manejarMicroBuses que referencia a operador';
ALTER TABLE manejarMicroBuses ADD CONSTRAINT manejarMicroBuses_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES microBuses(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarMicroBuses_fkey2 ON manejarMicroBuses IS 'La llave foranea de la tabla manejarMicroBuses que referencia a microBuses';

ALTER TABLE manejarRTP ADD CONSTRAINT manejarRTP_fkey1 FOREIGN KEY (curp)
REFERENCES operador(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarRTP_fkey1 ON manejarRTP IS 'La llave foranea de la tabla manejarRTP que referencia a operador';
ALTER TABLE manejarRTP ADD CONSTRAINT manejarRTP_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES rtp(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarRTP_fkey2 ON manejarRTP IS 'La llave foranea de la tabla manejarRTP que referencia a RTP';

ALTER TABLE manejarTroleBus ADD CONSTRAINT manejarTroleBus_fkey1 FOREIGN KEY (curp)
REFERENCES operador(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarTroleBus_fkey1 ON manejarTroleBus IS 'La llave foranea de la tabla manejarTroleBus que referencia a operador';
ALTER TABLE manejarTroleBus ADD CONSTRAINT manejarTroleBus_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES troleBus(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarTroleBus_fkey2 ON manejarTroleBus IS 'La llave foranea de la tabla manejarTroleBus que referencia a troleBus';

ALTER TABLE manejarTaxi ADD CONSTRAINT manejarTaxi_fkey1 FOREIGN KEY (curp)
REFERENCES operador(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarTaxi_fkey1 ON manejarTaxi IS 'La llave foranea de la tabla manejarTaxi que referencia a operador';
ALTER TABLE manejarTaxi ADD CONSTRAINT manejarTaxi_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES taxi(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT manejarTaxi_fkey2 ON manejarTaxi IS 'La llave foranea de la tabla manejarTaxi que referencia a taxi';

ALTER TABLE pagarMetro ADD CONSTRAINT pagarMetro_fkey1 FOREIGN KEY (curp)
REFERENCES usuario(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarMetro_fkey1 ON pagarMetro IS 'La llave foranea de la tabla pagarMetro que referencia a usuario';
ALTER TABLE pagarMetro ADD CONSTRAINT pagarMetro_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES metro(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarMetro_fkey2 ON pagarMetro IS 'La llave foranea de la tabla pagarMetro que referencia a metro';

ALTER TABLE pagarTrenLigero ADD CONSTRAINT pagarTrenLigero_fkey1 FOREIGN KEY (curp)
REFERENCES usuario(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarTrenLigero_fkey1 ON pagarTrenLigero IS 'La llave foranea de la tabla pagarTrenLigero que referencia a usuario';
ALTER TABLE pagarTrenLigero ADD CONSTRAINT pagarTrenLigero_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES trenLigero(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarTrenLigero_fkey2 ON pagarTrenLigero IS 'La llave foranea de la tabla pagarTrenLigero que referencia a trenLigero';

ALTER TABLE pagarMetroBus ADD CONSTRAINT pagarMetroBus_fkey1 FOREIGN KEY (curp)
REFERENCES usuario(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarMetroBus_fkey1 ON pagarMetroBus IS 'La llave foranea de la tabla pagarMetroBus que referencia a usuario';
ALTER TABLE pagarMetroBus ADD CONSTRAINT pagarMetroBus_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES metroBus(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarMetroBus_fkey2 ON pagarMetroBus IS 'La llave foranea de la tabla pagarMetroBus que referencia a metroBus';

ALTER TABLE pagarMicroBuses ADD CONSTRAINT pagarMicroBuses_fkey1 FOREIGN KEY (curp)
REFERENCES usuario(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarMicroBuses_fkey1 ON pagarMicroBuses IS 'La llave foranea de la tabla pagarMicroBuses que referencia a usuario';
ALTER TABLE pagarMicroBuses ADD CONSTRAINT pagarMicroBuses_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES microBuses(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarMicroBuses_fkey2 ON pagarMicroBuses IS 'La llave foranea de la tabla pagarMicroBuses que referencia a microBuses';

ALTER TABLE pagarRTP ADD CONSTRAINT pagarRTP_fkey1 FOREIGN KEY (curp)
REFERENCES usuario(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarRTP_fkey1 ON pagarRTP IS 'La llave foranea de la tabla pagarRTP que referencia a usuario';
ALTER TABLE pagarRTP ADD CONSTRAINT pagarRTP_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES rtp(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarRTP_fkey2 ON pagarRTP IS 'La llave foranea de la tabla pagarRTP que referencia a rtp';

ALTER TABLE pagarTroleBus ADD CONSTRAINT pagarTroleBus_fkey1 FOREIGN KEY (curp)
REFERENCES usuario(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarTroleBus_fkey1 ON pagarTroleBus IS 'La llave foranea de la tabla pagarTroleBus que referencia a usuario';
ALTER TABLE pagarTroleBus ADD CONSTRAINT pagarTroleBus_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES troleBus(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarTroleBus_fkey2 ON pagarTroleBus IS 'La llave foranea de la tabla pagarTroleBus que referencia a troleBus';

ALTER TABLE pagarTaxi ADD CONSTRAINT pagarTaxi_fkey1 FOREIGN KEY (curp)
REFERENCES usuario(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarTaxi_fkey1 ON pagarTaxi IS 'La llave foranea de la tabla pagarTaxi que referencia a usuario';
ALTER TABLE pagarTaxi ADD CONSTRAINT pagarTaxi_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES taxi(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT pagarTaxi_fkey2 ON pagarTaxi IS 'La llave foranea de la tabla pagarTaxi que referencia a taxi';

ALTER TABLE repararMetro ADD CONSTRAINT repararMetro_fkey1 FOREIGN KEY (id_Taller)
REFERENCES taller(id_Taller)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararMetro_fkey1 ON repararMetro IS 'La llave foranea de la tabla reparaMetro que referencia a taller';
ALTER TABLE repararMetro ADD CONSTRAINT repararMetro_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES metro(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararMetro_fkey2 ON repararMetro IS 'La llave foranea de la tabla reparaMetro que referencia a metro';

ALTER TABLE repararTrenLigero ADD CONSTRAINT repararTrenLigero_fkey1 FOREIGN KEY (id_Taller)
REFERENCES taller(id_Taller)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararTrenLigero_fkey1 ON repararTrenLigero IS 'La llave foranea de la tabla repararTrenLigero que referencia a taller';
ALTER TABLE repararTrenLigero ADD CONSTRAINT repararTrenLigero_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES trenLigero(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararTrenLigero_fkey2 ON repararTrenLigero IS 'La llave foranea de la tabla repararTrenLigero que referencia a trenLigero';

ALTER TABLE repararMetroBus ADD CONSTRAINT repararMetroBus_fkey1 FOREIGN KEY (id_Taller)
REFERENCES taller(id_Taller)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararMetroBus_fkey1 ON repararMetroBus IS 'La llave foranea de la tabla repararMetroBus que referencia a taller';
ALTER TABLE repararMetroBus ADD CONSTRAINT repararMetroBus_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES metroBus(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararMetroBus_fkey2 ON repararMetroBus IS 'La llave foranea de la tabla repararMetroBus que referencia a MetroBus';

ALTER TABLE repararMicroBuses ADD CONSTRAINT repararMicroBuses_fkey1 FOREIGN KEY  (id_Taller)
REFERENCES taller(id_Taller)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararMicroBuses_fkey1 ON repararMicroBuses IS 'La llave foranea de la tabla repararMicroBuses que referencia a taller';
ALTER TABLE repararMicroBuses ADD CONSTRAINT repararMicroBuses_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES microBuses(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararMicroBuses_fkey2 ON repararMicroBuses IS 'La llave foranea de la tabla repararMicroBuses que referencia a microBuses';

ALTER TABLE repararRTP ADD CONSTRAINT repararRTP_fkey1 FOREIGN KEY  (id_Taller)
REFERENCES taller(id_Taller)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararRTP_fkey1 ON repararRTP IS 'La llave foranea de la tabla repararRTP que referencia a taller';
ALTER TABLE repararRTP ADD CONSTRAINT repararRTP_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES rtp(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararRTP_fkey2 ON repararRTP IS 'La llave foranea de la tabla repararRTP que referencia a rtp';

ALTER TABLE repararTroleBus ADD CONSTRAINT repararTroleBus_fkey1 FOREIGN KEY (id_Taller)
REFERENCES taller(id_Taller)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararTroleBus_fkey1 ON repararTroleBus IS 'La llave foranea de la tabla repararTroleBus que referencia a taller';
ALTER TABLE repararTroleBus ADD CONSTRAINT repararTroleBus_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES troleBus(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararTroleBus_fkey2 ON repararTroleBus IS 'La llave foranea de la tabla repararTroleBus que referencia a troleBus';

ALTER TABLE repararTaxi ADD CONSTRAINT repararTaxi_fkey1 FOREIGN KEY (id_Taller)
REFERENCES taller(id_Taller)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararTaxi_fkey1 ON repararTaxi IS 'La llave foranea de la tabla repararTaxi que referencia a taller';
ALTER TABLE repararTaxi ADD CONSTRAINT repararTaxi_fkey2 FOREIGN KEY (id_Vehiculo)
REFERENCES taxi(id_Vehiculo)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT repararTaxi_fkey2 ON repararTaxi IS 'La llave foranea de la tabla repararTaxi que referencia a taxi';

ALTER TABLE MetodoPago ADD CONSTRAINT paypal_pkey PRIMARY KEY (idPago);
COMMENT ON CONSTRAINT paypal_pkey ON MetodoPago IS 'La llave primaria de la tabla MetodoPago';
ALTER TABLE MetodoPago ADD CONSTRAINT paypal_fkey FOREIGN KEY (curp)
REFERENCES usuario(curp)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT paypal_fkey ON MetodoPago IS 'La llave foranea de la tabla MetodoPago que referencia a usuario';

ALTER TABLE componerse ADD CONSTRAINT componerse_fkey1 FOREIGN KEY (id_Estacion)
REFERENCES estacion(id_Estacion)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT componerse_fkey1 ON componerse IS 'La llave foranea de la tabla componerse que referencia a estacion';
ALTER TABLE componerse ADD CONSTRAINT componerse_fkey2 FOREIGN KEY (numeroLinea)
REFERENCES linea(numeroLinea)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT componerse_fkey2 ON componerse IS 'La llave foranea de la tabla componerse que referencia a linea';

ALTER TABLE contar ADD CONSTRAINT contar_fkey1 FOREIGN KEY (id_Estacion)
REFERENCES estacion(id_Estacion)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT contar_fkey1 ON contar IS 'La llave foranea de la tabla contar que referencia a estacion';
ALTER TABLE contar ADD CONSTRAINT contar_fkey2 FOREIGN KEY (numeroRuta)
REFERENCES ruta(numeroRuta)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT contar_fkey2 ON contar IS 'La llave foranea de la tabla contar que referencia a ruta';

ALTER TABLE deshabilitar ADD CONSTRAINT deshabilitar_fkey1 FOREIGN KEY (id_Estacion)
REFERENCES estacion(id_Estacion)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT deshabilitar_fkey1 ON deshabilitar IS 'La llave foranea de la tabla deshabilitar que referencia a estacion';
ALTER TABLE deshabilitar ADD CONSTRAINT deshabilitar_fkey2 FOREIGN KEY (id_Incidente)
REFERENCES incidente(id_Incidente)/*ON UPDATE  ON DELETE*/;
COMMENT ON CONSTRAINT deshabilitar_fkey2 ON deshabilitar IS 'La llave foranea de la tabla deshabilitar que referencia a incidente';