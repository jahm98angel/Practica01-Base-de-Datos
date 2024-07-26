DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE TABLE Supervisor
(
  CURP VARCHAR(18) NOT NULL UNIQUE CHECK(CHAR_LENGTH(CURP)=18),
  telefono VARCHAR(10) NOT NULL check(CHAR_LENGTH(telefono)=10),
  calle VARCHAR(50) NOT NULL CHECK (calle <>''),
  numero VARCHAR(50) NOT NULL CHECK (numero <>''),
  estado VARCHAR(50) NOT NULL check (estado <>''),
  cp VARCHAR(5) NOT NULL CHECK(CHAR_LENGTH(cp)=5),
  fechaNac DATE NOT NULL,
  nombre VARCHAR(50) NOT NULL check (nombre <>''),
  paterno VARCHAR(50) NOT NULL check (paterno <>''),
  materno VARCHAR(50) NOT NULL check (materno <>''),
  salario FLOAT NOT NULL check(salario > 0),
  genero VARCHAR(50) NOT NULL check (genero <>''),
  periodo VARCHAR(50) NOT NULL check (periodo <>''),
  RFC VARCHAR(13) NOT NULL UNIQUE check (CHAR_LENGTH(RFC)=13),
  horaInicio TIME NOT NULL,
  horaFin TIME NOT NULL check (horaFin > horaInicio),
  PRIMARY KEY (CURP)
);

CREATE TABLE Estetica
(
  idEstetica INT NOT NULL check(idEstetica >0),
  CURPSupervisor VARCHAR(18) UNIQUE CHECK(CHAR_LENGTH(CURPSupervisor)=18),
  nombre VARCHAR(50) NOT NULL CHECK (nombre <>''),
  servicioObservacion BOOLEAN NOT NULL,
  servicioBaño BOOLEAN NOT NULL,
  telefono VARCHAR(10) NOT NULL check(CHAR_LENGTH(telefono)=10),
  calle VARCHAR(50) NOT NULL CHECK (calle <>''),
  numero VARCHAR(50) NOT NULL CHECK (numero <>''),
  estado VARCHAR(50) NOT NULL check (estado <>''),
  cp VARCHAR(5) NOT NULL CHECK(CHAR_LENGTH(cp)=5),
  numConsultorios INT NOT NULL CHECK(numConsultorios >= 0),
  horario VARCHAR(13) NOT NULL check (horario <>''),
  PRIMARY KEY (idEstetica),
  CONSTRAINT fk_supervisor_estetica
  	FOREIGN KEY (CURPSupervisor)
  		REFERENCES Supervisor(CURP)
  			ON DELETE CASCADE
);

CREATE TABLE Estilista
(
  CURP VARCHAR(18) NOT NULL UNIQUE CHECK(CHAR_LENGTH(CURP)=18),
  telefono VARCHAR(10) NOT NULL check(CHAR_LENGTH(telefono)=10),
  calle VARCHAR(50) NOT NULL CHECK (calle <>''),
  numero VARCHAR(50) NOT NULL CHECK (numero <>''),
  estado VARCHAR(50) NOT NULL check (estado <>''),
  cp VARCHAR(5) NOT NULL CHECK(CHAR_LENGTH(cp)=5),
  fechaNac DATE NOT NULL,
  nombre VARCHAR(50) NOT NULL check (nombre <>''),
  paterno VARCHAR(50) NOT NULL check (paterno <>''),
  materno VARCHAR(50) NOT NULL check (materno <>''),
  salario FLOAT NOT NULL check(salario > 0),
  genero VARCHAR(50) NOT NULL check (genero <>''),
  certificado VARCHAR(255) NOT NULL check(certificado <>''),
  PRIMARY KEY (CURP)
);

CREATE TABLE Veterinario
(
  CURP VARCHAR(18) NOT NULL UNIQUE CHECK(CHAR_LENGTH(CURP)=18),
  telefono VARCHAR(10) NOT NULL check(CHAR_LENGTH(telefono)=10),
  calle VARCHAR(50) NOT NULL CHECK (calle <>''),
  numero VARCHAR(50) NOT NULL CHECK (numero <>''),
  estado VARCHAR(50) NOT NULL check (estado <>''),
  cp VARCHAR(5) NOT NULL CHECK(CHAR_LENGTH(cp)=5),
  fechaNac DATE NOT NULL,
  nombre VARCHAR(50) NOT NULL check (nombre <>''),
  paterno VARCHAR(50) NOT NULL check (paterno <>''),
  materno VARCHAR(50) NOT NULL check (materno <>''),
  salario FLOAT NOT NULL check(salario > 0),
  genero VARCHAR(50) NOT NULL check (genero <>''),
  RFC VARCHAR(13) NOT NULL UNIQUE check (CHAR_LENGTH(RFC)=13),
  horaInicio TIME NOT NULL,
  horaFin TIME NOT NULL check (horaFin > horaInicio),
  pacientesAct INT NOT NULL CHECK(pacientesAct BETWEEN 0 AND 4),
  PRIMARY KEY (CURP)
);

CREATE TABLE Producto
(
  codigo VARCHAR(12) NOT NULL check(codigo <>''),
  tipo VARCHAR(50) NOT NULL check(tipo <>''),
  cantidadInventario INT NOT NULL check (cantidadInventario >= 0),
  archivoImg VARCHAR(500) NOT NULL check (archivoImg <>''),
  caducidad DATE,
  precio FLOAT NOT NULL check (precio >= 0),
  nombre VARCHAR(50) check (nombre <>''),
  descripcion VARCHAR(500),
  PRIMARY KEY (codigo)
);

CREATE TABLE Dueño
(
  CURP VARCHAR(18) NOT NULL UNIQUE CHECK(CHAR_LENGTH(CURP)=18),
  telefono VARCHAR(10) NOT NULL check(CHAR_LENGTH(telefono)=10),
  calle VARCHAR(50) NOT NULL CHECK (calle <>''),
  numero VARCHAR(50) NOT NULL CHECK (numero <>''),
  estado VARCHAR(50) NOT NULL check (estado <>''),
  cp VARCHAR(5) NOT NULL CHECK(CHAR_LENGTH(cp)=5),
  fechaNac DATE NOT NULL,
  nombre VARCHAR(50) NOT NULL check (nombre <>''),
  paterno VARCHAR(50) NOT NULL check (paterno <>''),
  materno VARCHAR(50) NOT NULL check (materno <>''),
  esFrequente BOOLEAN NOT NULL,
  email VARCHAR(320),
  PRIMARY KEY (CURP)
);

CREATE TABLE Mascota
(
  Nombre VARCHAR(16) NOT NULL UNIQUE,
  CURPDueño VARCHAR(18) NOT NULL CHECK(CHAR_LENGTH(CURPDueño)=18),
  peso FLOAT NOT NULL check(peso >= 0),
  edad INT NOT NULL check(edad >= 0),
  especie VARCHAR(50) NOT NULL check(especie <>''),
  PRIMARY KEY (Nombre, CURPDueño),
  CONSTRAINT fk_dueño_mascota
  	FOREIGN KEY (CURPDueño)
  		REFERENCES Dueño (CURP)
  			ON DELETE CASCADE
);

CREATE TABLE Tarjeta
(
  numTarjeta VARCHAR(16) NOT NULL check (CHAR_LENGTH(numTarjeta)=16),
  CURPDueño VARCHAR(18) NOT NULL CHECK(CHAR_LENGTH(CURPDueño)=18),
  vencimiento DATE NOT NULL,
  titular VARCHAR (150) NOT NULL CHECK(titular <>''),
  PRIMARY KEY (numTarjeta, CURPDueño),
  CONSTRAINT fk_dueño_tarjeta
  	FOREIGN KEY (CURPDueño)
  		REFERENCES Dueño (CURP)
  			ON DELETE CASCADE
);

CREATE TABLE ReciboProducto
(
  numRecibo VARCHAR(255) NOT NULL check(numRecibo <>''),
  IdEstetica INT NOT NULL,
  CURPDueño VARCHAR(18) NOT NULL check(CHAR_LENGTH(CURPDueño)=16),
  tipoDePago VARCHAR(50) NOT NULL check(tipoDePago <>''), 
  precio FLOAT NOT NULL check(precio >=0),
  PRIMARY KEY (numRecibo),
  CONSTRAINT fk_estetica_reciboproducto
  	FOREIGN KEY (IdEstetica)
  		REFERENCES Estetica (IdEstetica)
  			ON DELETE CASCADE,
  CONSTRAINT fk_dueño_reciboproducto
  	FOREIGN KEY (CURPDueño)
  		REFERENCES Dueño (CURP)
  			ON DELETE CASCADE
);

CREATE TABLE ReciboServicio
(
  numRecibo VARCHAR(255) NOT NULL check(numRecibo <>''),
  IdEstetica INT NOT NULL,
  CURPDueño VARCHAR(18) NOT NULL check(CHAR_LENGTH(CURPDueño)=18),
  tipoDePago VARCHAR(50) NOT NULL check(tipoDePago <>''), 
  precio FLOAT NOT NULL check(precio >=0),
  PRIMARY KEY (numRecibo),
  CONSTRAINT fk_estetica_reciboservicio
  	FOREIGN KEY (IdEstetica)
  		REFERENCES Estetica (IdEstetica)
  			ON DELETE CASCADE,
  CONSTRAINT fk_dueño_reciboservicio
  	FOREIGN KEY (CURPDueño)
  		REFERENCES Dueño (CURP)
  			ON DELETE CASCADE
);

CREATE TABLE ConsultaEmergencia
(
  idServicio VARCHAR(255) NOT NULL check(idServicio <>''),
  CURPVeterinario VARCHAR (18) NOT NULL check(CHAR_LENGTH(CURPVeterinario)=18),
  numRecibo VARCHAR(255) NOT NULL check(numRecibo <>''),
  CURPDueño VARCHAR(18) NOT NULL check(CHAR_LENGTH(CURPDueño)=18),
  nombreMascota VARCHAR(50) NOT NULL check(nombreMascota <>''),
  sintomas VARCHAR(500) NOT NULL check(sintomas <>''),
  codigo INT NOT NULL,
  procedimiento VARCHAR(1500) NOT NULL check(procedimiento <>''),
  precio FLOAT NOT NULL check(precio >= 0),
  PRIMARY KEY (idServicio),
  CONSTRAINT fk_veterinario_emergencia
  	FOREIGN KEY (CURPVeterinario)
  		REFERENCES Veterinario (CURP)
  			ON DELETE CASCADE,
  CONSTRAINT fk_mascota_emergencia
  	FOREIGN KEY (nombreMascota, CURPDueño)
  		REFERENCES Mascota (nombre, CURPDueño)
  			ON DELETE CASCADE,
  CONSTRAINT fk_recibo_emergencia
  	FOREIGN KEY (numRecibo)
  		REFERENCES ReciboServicio (numRecibo)
  			ON DELETE CASCADE
);

CREATE TABLE ConsultaNormal
(
  idServicio VARCHAR(255) NOT NULL check(idServicio <>''),
  CURPVeterinario VARCHAR (18) NOT NULL check(CHAR_LENGTH(CURPVeterinario)=18),
  numRecibo VARCHAR(255) NOT NULL check(numRecibo <>''),
  CURPDueño VARCHAR(18) NOT NULL check(CHAR_LENGTH(CURPDueño)=18),
  nombreMascota VARCHAR(50) NOT NULL check(nombreMascota <>''),
  fechaRevision DATE NOT NULL,
  motivo VARCHAR(500) NOT NULL check(motivo <>''),
  precio FLOAT NOT NULL check(precio >= 0),
  estado VARCHAR(50) NOT NULL check(motivo <>''),
  PRIMARY KEY (idServicio),
  CONSTRAINT fk_veterinario_consulta
  	FOREIGN KEY (CURPVeterinario)
  		REFERENCES Veterinario (CURP)
  			ON DELETE CASCADE,
  CONSTRAINT fk_mascota_consulta
  	FOREIGN KEY (nombreMascota, CURPDueño)
  		REFERENCES Mascota (nombre, CURPDueño)
  			ON DELETE CASCADE,
  CONSTRAINT fk_recibo_consulta
  	FOREIGN KEY (numRecibo)
  		REFERENCES ReciboServicio (numRecibo)
  			ON DELETE CASCADE
);

CREATE TABLE Medicamento
(
  idServicio VARCHAR(255) NOT NULL check(idServicio <>''),
  medicamento VARCHAR(50) NOT NULL check(medicamento <>''),
  PRIMARY KEY (idServicio, medicamento),
  CONSTRAINT fk_servicio_medicamento
  	FOREIGN KEY (idServicio)
  		REFERENCES ConsultaNormal (idServicio)
  			ON DELETE CASCADE
);

CREATE TABLE TratEstetico
(
  idServicio VARCHAR(255) NOT NULL check(idServicio <>''),
  CURPEstilista VARCHAR (18) NOT NULL check (CHAR_LENGTH(CURPEstilista)=18),
  numRecibo VARCHAR(255) NOT NULL check(numRecibo <>''),
  CURPDueño VARCHAR(18) NOT NULL check (CHAR_LENGTH(CURPDueño)=18),
  nombreMascota VARCHAR(50) NOT NULL check(nombreMascota <>''),
  tipo VARCHAR(50) NOT NULL check(tipo <>''),
  precio FLOAT NOT NULL check(precio >=0),
  PRIMARY KEY (idServicio),
  CONSTRAINT fk_estilista_tratestetico
  	FOREIGN KEY (CURPEstilista)
  		REFERENCES Estilista (CURP)
  			ON DELETE CASCADE,
  CONSTRAINT fk_mascota_tratestetico
  	FOREIGN KEY (nombreMascota, CURPDueño)
  		REFERENCES Mascota (nombre, CURPDueño)
  			ON DELETE CASCADE,
  CONSTRAINT fk_recibo_tratestetico
  	FOREIGN KEY (numRecibo)
  		REFERENCES ReciboServicio (numRecibo)
  			ON DELETE CASCADE
);

CREATE TABLE Vender
(
  idEstetica INT NOT NULL check(idEstetica > 0),
  codigo VARCHAR(12) NOT NULL check(codigo <>''),
  CONSTRAINT fk_estetica_vender
  	FOREIGN KEY (idEstetica)
  		REFERENCES Estetica (idEstetica)
  			ON DELETE CASCADE,
  FOREIGN KEY (codigo) REFERENCES Producto (codigo)
);

CREATE TABLE Anexar
(
  codigo VARCHAR(12) NOT NULL,
  numRecibo VARCHAR(255) NOT NULL check(numRecibo <>''),
  CONSTRAINT fk_recibo_anexar
  	FOREIGN KEY (numRecibo)
  		REFERENCES ReciboProducto (numRecibo)
  			ON DELETE CASCADE,
  CONSTRAINT fk_producto_anexar
  	FOREIGN KEY (codigo)
  		REFERENCES Producto (codigo)
  			ON DELETE CASCADE
);

CREATE TABLE TrabajarEstilista
(
  idEstetica INT NOT NULL check(idEstetica > 0),
  CURPEstilista VARCHAR(18) NOT NULL check (CHAR_LENGTH(CURPEstilista)=18),
  CONSTRAINT fk_estetica_trabajoestilista
  	FOREIGN KEY (idEstetica)
  		REFERENCES Estetica (idEstetica)
  			ON DELETE CASCADE,
  CONSTRAINT fk_estilista_trabajoestilista
  	FOREIGN KEY (CURPEstilista)
  		REFERENCES Estilista (CURP)
  			ON DELETE CASCADE
);

CREATE TABLE TrabajarVeterinario
(
  idEstetica INT NOT NULL check(idEstetica > 0),
  CURPVeterinario VARCHAR(18) NOT NULL check (CHAR_LENGTH(CURPVeterinario)=18),
  CONSTRAINT fk_estetica_trabajoveterinario
  	FOREIGN KEY (idEstetica)
  		REFERENCES Estetica (idEstetica)
  			ON DELETE CASCADE,
  CONSTRAINT fk_veterinario_trabajoveterinario
  	FOREIGN KEY (CURPVeterinario)
  		REFERENCES Veterinario (CURP)
  			ON DELETE CASCADE
);
