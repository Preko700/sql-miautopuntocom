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

-- ----------------------------------------------------------------------------
-- Clientes (datos ficticios)
-- ----------------------------------------------------------------------------
INSERT INTO clientes (id_cliente, nombre, apellido, cedula, telefono, email, direccion) VALUES
    (1, 'María',   'Solano Vargas',   '1-0845-0231', '8812-3456', 'maria.solano@example.com',  'Cartago, Paraíso, 200 m sur de la iglesia'),
    (2, 'José',    'Rojas Cordero',   '3-0412-0987', '8723-1190', 'jose.rojas@example.com',     'Cartago, Centro, Barrio Los Ángeles'),
    (3, 'Daniela', 'Castro Mora',     '1-1190-0345', '6045-7721', 'daniela.castro@example.com', 'San José, Curridabat, Granadilla'),
    (4, 'Luis',    'Jiménez Araya',   '2-0678-0412', '7011-2288', 'luis.jimenez@example.com',   'Alajuela, San Ramón, Centro'),
    (5, 'Andrea',  'Brenes Salazar',  '3-0533-0764', '8390-5512', 'andrea.brenes@example.com',  'Heredia, Santo Domingo, Santa Rosa'),
    (6, 'Carlos',  'Quesada Núñez',   '1-0976-0158', '8604-9033', 'carlos.quesada@example.com', 'San José, Escazú, San Rafael');

-- ----------------------------------------------------------------------------
-- Vendedores (datos ficticios)
-- ----------------------------------------------------------------------------
INSERT INTO vendedores (id_vendedor, nombre, apellido, cedula, fecha_nacimiento, fecha_contratacion, comision_porcentual) VALUES
    (1, 'Fernando', 'Arce Monge',    '3-0388-0521', '1988-03-14', '2018-02-01', 5.00),
    (2, 'Paola',    'Vindas Chaves', '1-1021-0674', '1993-07-22', '2021-05-10', 3.50),
    (3, 'Esteban',  'Mora Pacheco',  '3-0455-0812', '1990-11-05', '2019-09-16', 4.00),
    (4, 'Karla',    'Ulate Segura',  '1-1345-0209', '2001-01-30', '2023-03-01', 6.50);

-- ----------------------------------------------------------------------------
-- Ventas
-- Las fechas son relativas a la fecha de ejecución (CURDATE) para que la
-- consulta de "último mes" siempre tenga datos de prueba, sin importar el día.
-- Vendedor 1: 3 ventas | Vendedor 2: 2 | Vendedor 3: 2 | Vendedor 4: 1
-- Cliente 1 y cliente 2 compran dos veces. Quedan sin vender los vehículos 5, 7, 9 y 12.
-- ----------------------------------------------------------------------------
INSERT INTO ventas (id_venta, id_vehiculo, id_cliente, id_vendedor, fecha_venta, precio_final, metodo_pago) VALUES
    (1, 3,  1, 1, DATE_SUB(CURDATE(), INTERVAL 75 DAY), 28900.00, 'Financiamiento'),
    (2, 4,  2, 2, DATE_SUB(CURDATE(), INTERVAL 60 DAY), 21000.00, 'Efectivo'),
    (3, 11, 3, 1, DATE_SUB(CURDATE(), INTERVAL 40 DAY), 26000.00, 'Tarjeta'),
    (4, 6,  4, 3, DATE_SUB(CURDATE(), INTERVAL 33 DAY), 27000.00, 'Financiamiento'),
    (5, 1,  1, 1, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 24500.00, 'Tarjeta'),
    (6, 2,  5, 3, DATE_SUB(CURDATE(), INTERVAL 12 DAY), 38500.00, 'Financiamiento'),
    (7, 10, 6, 2, DATE_SUB(CURDATE(), INTERVAL 6 DAY),  17500.00, 'Efectivo'),
    (8, 8,  2, 4, DATE_SUB(CURDATE(), INTERVAL 2 DAY),  23800.00, 'Tarjeta');
