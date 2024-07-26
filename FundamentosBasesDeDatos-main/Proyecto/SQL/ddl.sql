DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE TABLE sucursal(
    id_sucursal SERIAL,
    nombre VARCHAR(100) NOT NULL CHECK(nombre <> ''),
    telefono VARCHAR(10) NOT NULL CHECK(telefono <> ''),
    email VARCHAR(100) NOT NULL CHECK(email <> ''),
    calle VARCHAR(100) NOT NULL CHECK(calle <> ''),
    numero VARCHAR(50) NOT NULL CHECK(numero <> ''),
    colonia VARCHAR(100) NOT NULL CHECK(colonia <> ''),
    alcaldia VARCHAR(50) NOT NULL CHECK(alcaldia <> ''),
    cp VARCHAR(5) NOT NULL CHECK(cp <> ''),
    CONSTRAINT sucursal_pk PRIMARY KEY(id_sucursal));
    
CREATE TABLE proveedor(
    rfc VARCHAR(13) NOT NULL UNIQUE CHECK(rfc <> ''),
    nombre VARCHAR(50) NOT NULL CHECK(nombre <> ''),
    CONSTRAINT proveedor_pk PRIMARY KEY(rfc));

CREATE TABLE surtir(
    rfc VARCHAR(13) NOT NULL,
    id_sucursal INT,
    CONSTRAINT surtir_pk PRIMARY KEY(rfc, id_sucursal),
    CONSTRAINT proveedor_fk FOREIGN KEY(rfc)
        REFERENCES proveedor(rfc),
    CONSTRAINT sucursal_fk FOREIGN KEY(id_sucursal)
        REFERENCES sucursal(id_sucursal));
        
CREATE TABLE telefono_proveedor(
    rfc VARCHAR(13) NOT NULL,
    telefono VARCHAR(10) NOT NULL CHECK(telefono <> ''),
    CONSTRAINT telefono_proveedor_pk PRIMARY KEY(rfc, telefono),
    CONSTRAINT proveedor_fk FOREIGN KEY(rfc)
        REFERENCES proveedor(rfc));
    
CREATE TABLE productos_inventario(
    id_producto VARCHAR(50) NOT NULL CHECK(id_producto <> ''),
    id_sucursal INT,
    nombre VARCHAR(100) NOT NULL CHECK(nombre <> ''),
    marca VARCHAR(100) NOT NULL, -- Admite cadenas vacías
    stock DECIMAL(10,2) NOT NULL CHECK(stock >= 0),
    caducidad DATE NOT NULL,
    descripcion VARCHAR(200),
    CONSTRAINT productos_inventario_pk PRIMARY KEY(id_producto, id_sucursal),
    CONSTRAINT sucursal_fk FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal));
        
CREATE TABLE historico_inventario(
    id_producto VARCHAR(50) NOT NULL,
    id_sucursal INT,
    dia_compra DATE NOT NULL,
    precio_compra DECIMAL(10,2) NOT NULL,
    CONSTRAINT historico_inventario_pk 
        PRIMARY KEY(id_producto, id_sucursal, dia_compra, precio_compra),
    CONSTRAINT productos_inventario_fk FOREIGN KEY(id_producto, id_sucursal)
        REFERENCES productos_inventario(id_producto, id_sucursal));

CREATE TABLE cliente(
    curp VARCHAR(18) UNIQUE NOT NULL CHECK(curp <> ''),
    nombre VARCHAR(200) NOT NULL CHECK(nombre <> ''),
    paterno VARCHAR(200) NOT NULL CHECK(paterno <> ''),
    materno VARCHAR(200) NOT NULL CHECK(materno <> ''),
    calle VARCHAR(200) NOT NULL CHECK(calle <> ''),
    numero VARCHAR(100) NOT NULL CHECK(numero <> ''),
    colonia VARCHAR(200) NOT NULL CHECK(colonia <> ''),
    alcaldia VARCHAR(200) NOT NULL CHECK(alcaldia <> ''),
    cp VARCHAR(5) NOT NULL CHECK(cp <> ''),
    telefono VARCHAR(10) NOT NULL CHECK(telefono <> ''),
    email VARCHAR(200) NOT NULL CHECK(email <> ''),
    puntos INT, --NULL en caso de no ser taquero de corazón
    CONSTRAINT cliente_pk PRIMARY KEY(curp));
    
CREATE TABLE empleado(
    curp VARCHAR(18) NOT NULL UNIQUE CHECK(curp <> ''),
    id_sucursal INT NOT NULL,
    rfc VARCHAR(13) NOT NULL UNIQUE CHECK(rfc <> ''),
    nss VARCHAR(11) NOT NULL UNIQUE CHECK(nss <> ''),
    fecha_nac DATE NOT NULL,
    fecha_contratacion DATE NOT NULL,
    es_cajero BOOLEAN NOT NULL,
    es_repartidor BOOLEAN NOT NULL, 
    es_tortillero BOOLEAN NOT NULL,
    es_taquero BOOLEAN NOT NULL,
    es_parrillero BOOLEAN NOT NULL,
    es_mesero BOOLEAN NOT NULL,
    CONSTRAINT empleado_pk PRIMARY KEY(curp),
    CONSTRAINT cliente_fk FOREIGN KEY(curp)
        REFERENCES cliente(curp));

CREATE TABLE ticket(
    curp_empleado VARCHAR(18) NOT NULL,
    curp_cliente VARCHAR(18) NOT NULL,
    num_ticket SERIAL,
    a_domicilio BOOLEAN NOT NULL,
    fecha DATE NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    CONSTRAINT ticket_pk PRIMARY KEY(num_ticket),
    CONSTRAINT empleado_fk FOREIGN KEY(curp_empleado)
        REFERENCES empleado(curp),
    CONSTRAINT cliente_fk FOREIGN KEY(curp_cliente)
        REFERENCES cliente(curp));
        
CREATE TABLE comida(
    clave_venta SERIAL,
    nombre VARCHAR(200) NOT NULL CHECK (nombre <> ''),
    descripcion VARCHAR(500) NOT NULL,
    CONSTRAINT comida_pk PRIMARY KEY(clave_venta));


CREATE TABLE salsas(
    clave_venta SERIAL,
    recomendacion VARCHAR(500) NOT NULL,
    nombre VARCHAR(200) NOT NULL CHECK (nombre <> ''),
    cantidad INT NOT NULL,
    picor VARCHAR(10) NOT NULL,
    CONSTRAINT salsas_pk PRIMARY KEY(clave_venta));
    
CREATE TABLE ingredientes_comida(
    clave_venta INT,
    nombre VARCHAR(50),
    cantidad DECIMAL(10,2),
    CONSTRAINT ingredientes_comida_pk PRIMARY KEY(clave_venta, nombre, cantidad),
    CONSTRAINT comida_fk FOREIGN KEY(clave_venta) 
        REFERENCES comida(clave_venta));
        
CREATE TABLE ingredientes_salsas(
    clave_venta INT,
    nombre VARCHAR(50),
    cantidad DECIMAL(10,2),
    CONSTRAINT ingredientes_salsas_pk PRIMARY KEY(clave_venta, nombre, cantidad),
    CONSTRAINT salsas_fk FOREIGN KEY(clave_venta) 
        REFERENCES salsas(clave_venta));

CREATE TABLE historico_comida(
    clave_venta INT,
    precio DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT historico_comida_pk PRIMARY KEY(clave_venta, precio, fecha),
    CONSTRAINT comida_fk FOREIGN KEY(clave_venta)
        REFERENCES comida(clave_venta));
        
CREATE TABLE historico_salsas(
    clave_venta INT,
    precio DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT historico_salsas_pk PRIMARY KEY(clave_venta, precio, fecha),
    CONSTRAINT salsas_fk FOREIGN KEY(clave_venta)
        REFERENCES salsas(clave_venta));        

CREATE TABLE registrar_comida(
    num_ticket INT,
    clave_venta INT,
    cantidad INT NOT NULL CHECK(cantidad >= 1),
    CONSTRAINT registrar_comida_pk PRIMARY KEY(num_ticket, clave_venta),
    CONSTRAINT ticket_fk FOREIGN KEY(num_ticket)
        REFERENCES ticket(num_ticket),
    CONSTRAINT comida_fk FOREIGN KEY(clave_venta)
        REFERENCES comida(clave_venta));

CREATE TABLE registrar_salsas(
    num_ticket INT,
    clave_venta INT,
    cantidad INT NOT NULL CHECK(cantidad >= 1),
    CONSTRAINT registrar_salsas_pk PRIMARY KEY(num_ticket, clave_venta),
    CONSTRAINT ticket_fk FOREIGN KEY(num_ticket)
        REFERENCES ticket(num_ticket),
    CONSTRAINT salsas_fk FOREIGN KEY(clave_venta)
        REFERENCES salsas(clave_venta));
        
CREATE TABLE transporte(
    curp VARCHAR(18) NOT NULL,
    id_transporte VARCHAR(10) NOT NULL CHECK(id_transporte <> ''),
    modelo VARCHAR(50) NOT NULL CHECK(modelo <> ''),
    tipo VARCHAR(20) NOT NULL CHECK(tipo <> ''),
    marca VARCHAR(20) NOT NULL CHECK(marca <> ''),
    licencia VARCHAR(50),
    CONSTRAINT transporte_pk PRIMARY KEY(curp, id_transporte),
    CONSTRAINT empleado_fk FOREIGN KEY(curp)
        REFERENCES empleado(curp));
