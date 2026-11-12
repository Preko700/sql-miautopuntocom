-- ============================================================================
-- Quiz #5 - SQL | CE 2103 Algoritmos y Estructuras de Datos II | II Semestre 2026
-- Script DDL: creación de la base de datos, tablas y restricciones
-- Sistema de información de MiAutoPuntoCom
-- ============================================================================

DROP DATABASE IF EXISTS miautopuntocom;
CREATE DATABASE miautopuntocom
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE miautopuntocom;

-- ----------------------------------------------------------------------------
-- PARTE 1 y 2: Tablas con sus atributos, claves y restricciones
-- ----------------------------------------------------------------------------

CREATE TABLE vehiculos (
    id_vehiculo INT            NOT NULL AUTO_INCREMENT,
    marca       VARCHAR(50)    NOT NULL,
    modelo      VARCHAR(50)    NOT NULL,
    anio        SMALLINT       NOT NULL,
    color       VARCHAR(30)    NOT NULL,
    precio      DECIMAL(12,2)  NOT NULL,   -- precio de lista, en dólares
    vin         CHAR(17)       NOT NULL,
    tipo        VARCHAR(30)    NOT NULL,   -- sedán, SUV, camioneta, etc.
    estado      VARCHAR(10)    NOT NULL,

    CONSTRAINT pk_vehiculos             PRIMARY KEY (id_vehiculo),
    CONSTRAINT uq_vehiculos_vin         UNIQUE (vin),
    CONSTRAINT chk_vehiculos_vin        CHECK (CHAR_LENGTH(vin) = 17),
    -- El límite superior del año (año actual) se valida en los triggers de abajo,
    -- porque MySQL no permite funciones como CURDATE() dentro de un CHECK.
    CONSTRAINT chk_vehiculos_anio_min   CHECK (anio >= 1900),
    CONSTRAINT chk_vehiculos_precio     CHECK (precio > 0),
    CONSTRAINT chk_vehiculos_estado     CHECK (estado IN ('Nuevo', 'Usado'))
) ENGINE = InnoDB;

CREATE TABLE clientes (
    id_cliente INT           NOT NULL AUTO_INCREMENT,
    nombre     VARCHAR(50)   NOT NULL,
    apellido   VARCHAR(50)   NOT NULL,
    cedula     VARCHAR(20)   NOT NULL,
    telefono   VARCHAR(20)   NOT NULL,
    email      VARCHAR(100)  NOT NULL,
    direccion  VARCHAR(200)  NOT NULL,

    CONSTRAINT pk_clientes         PRIMARY KEY (id_cliente),
    CONSTRAINT uq_clientes_cedula  UNIQUE (cedula),
    CONSTRAINT uq_clientes_email   UNIQUE (email),
    CONSTRAINT chk_clientes_email  CHECK (email LIKE '%_@_%._%')
) ENGINE = InnoDB;

CREATE TABLE vendedores (
    id_vendedor         INT           NOT NULL AUTO_INCREMENT,
    nombre              VARCHAR(50)   NOT NULL,
    apellido            VARCHAR(50)   NOT NULL,
    cedula              VARCHAR(20)   NOT NULL,
    fecha_nacimiento    DATE          NOT NULL,  -- necesaria para validar la edad mínima
    fecha_contratacion  DATE          NOT NULL,
    comision_porcentual DECIMAL(4,2)  NOT NULL,  -- por ejemplo 5.50 = 5.5 %

    CONSTRAINT pk_vendedores         PRIMARY KEY (id_vendedor),
    CONSTRAINT uq_vendedores_cedula  UNIQUE (cedula),
    CONSTRAINT chk_vendedores_comision
        CHECK (comision_porcentual BETWEEN 0 AND 20),
    -- Los vendedores no pueden ser menores de 21 años: se verifica que hayan
    -- cumplido 21 al momento de su contratación (así también lo son hoy).
    CONSTRAINT chk_vendedores_edad
        CHECK (fecha_nacimiento <= DATE_SUB(fecha_contratacion, INTERVAL 21 YEAR))
) ENGINE = InnoDB;
