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
