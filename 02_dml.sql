-- ============================================================================
-- Quiz #5 - SQL | CE 2103 Algoritmos y Estructuras de Datos II | II Semestre 2026
-- Script DML: datos de prueba (PARTE 3)
-- 12 vehículos, 6 clientes, 4 vendedores y 8 ventas
-- Ejecutar después de 01_ddl.sql
-- ============================================================================

USE miautopuntocom;

-- ----------------------------------------------------------------------------
-- Vehículos (precios de lista en dólares)
-- ----------------------------------------------------------------------------
INSERT INTO vehiculos (id_vehiculo, marca, modelo, anio, color, precio, vin, tipo, estado) VALUES
    (1,  'Toyota',  'Corolla', 2025, 'Blanco',   24500.00, 'JTDKN3DU5A0000001', 'Sedán',     'Nuevo'),
    (2,  'Toyota',  'RAV4',    2024, 'Gris',     38900.00, 'JTDKN3DU5A0000002', 'SUV',       'Nuevo'),
    (3,  'Toyota',  'Hilux',   2019, 'Negro',    29800.00, 'JTDKN3DU5A0000003', 'Camioneta', 'Usado'),
    (4,  'Honda',   'Civic',   2022, 'Rojo',     21500.00, '1HGCM826330000004', 'Sedán',     'Usado'),
    (5,  'Honda',   'CR-V',    2026, 'Azul',     36800.00, '1HGCM826330000005', 'SUV',       'Nuevo'),
    (6,  'Ford',    'Ranger',  2021, 'Plateado', 27500.00, '1FTFW1ET5B0000006', 'Camioneta', 'Usado'),
    (7,  'Nissan',  'Sentra',  2020, 'Gris',     14900.00, '3N1AB7AP5C0000007', 'Sedán',     'Usado'),
    (8,  'Nissan',  'Kicks',   2025, 'Naranja',  23800.00, '3N1AB7AP5C0000008', 'SUV',       'Nuevo'),
    (9,  'Hyundai', 'Tucson',  2023, 'Verde',    28700.00, 'KMHDH4AE5D0000009', 'SUV',       'Usado'),
    (10, 'Hyundai', 'Accent',  2024, 'Blanco',   17900.00, 'KMHDH4AE5D0000010', 'Sedán',     'Nuevo'),
    (11, 'Mazda',   'CX-5',    2022, 'Rojo',     26400.00, 'JM1BK32F580000011', 'SUV',       'Usado'),
    (12, 'Mazda',   'Mazda 3', 2025, 'Gris',     25900.00, 'JM1BK32F580000012', 'Sedán',     'Nuevo');
