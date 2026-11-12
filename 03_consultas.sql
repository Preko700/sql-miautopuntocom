-- ============================================================================
-- Quiz #5 - SQL | CE 2103 Algoritmos y Estructuras de Datos II | II Semestre 2026
-- Script de consultas (PARTE 4)
-- Ejecutar después de 01_ddl.sql y 02_dml.sql
-- ============================================================================

USE miautopuntocom;

-- ----------------------------------------------------------------------------
-- 1. Listar todos los vehículos disponibles (no vendidos) ordenados por precio
--    descendente.
-- ----------------------------------------------------------------------------
SELECT ve.id_vehiculo, ve.marca, ve.modelo, ve.anio, ve.color, ve.tipo, ve.estado, ve.precio
FROM vehiculos ve
LEFT JOIN ventas v ON v.id_vehiculo = ve.id_vehiculo
WHERE v.id_venta IS NULL
ORDER BY ve.precio DESC;

-- ----------------------------------------------------------------------------
-- 2. Total de ventas realizadas por cada vendedor (nombre y cantidad de ventas).
-- ----------------------------------------------------------------------------
SELECT CONCAT(vd.nombre, ' ', vd.apellido) AS vendedor,
       COUNT(v.id_venta)                   AS cantidad_ventas
FROM vendedores vd
LEFT JOIN ventas v ON v.id_vendedor = vd.id_vendedor
GROUP BY vd.id_vendedor, vd.nombre, vd.apellido
ORDER BY cantidad_ventas DESC;

-- ----------------------------------------------------------------------------
-- 3. Ingreso total generado por cada vendedor.
-- ----------------------------------------------------------------------------
SELECT CONCAT(vd.nombre, ' ', vd.apellido) AS vendedor,
       COALESCE(SUM(v.precio_final), 0)    AS ingreso_total
FROM vendedores vd
LEFT JOIN ventas v ON v.id_vendedor = vd.id_vendedor
GROUP BY vd.id_vendedor, vd.nombre, vd.apellido
ORDER BY ingreso_total DESC;

-- ----------------------------------------------------------------------------
-- 4. Cliente que ha realizado la compra más costosa.
--    (si hubiera empate en el precio máximo, se muestran todos los clientes).
-- ----------------------------------------------------------------------------
SELECT CONCAT(c.nombre, ' ', c.apellido) AS cliente,
       c.cedula,
       ve.marca, ve.modelo,
       v.precio_final                    AS compra_mas_costosa
FROM ventas v
JOIN clientes c   ON c.id_cliente   = v.id_cliente
JOIN vehiculos ve ON ve.id_vehiculo = v.id_vehiculo
WHERE v.precio_final = (SELECT MAX(precio_final) FROM ventas);
