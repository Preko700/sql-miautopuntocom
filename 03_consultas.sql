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

-- ----------------------------------------------------------------------------
-- 5. Vehículos vendidos en el último mes con información del cliente comprador.
-- ----------------------------------------------------------------------------
SELECT v.fecha_venta,
       ve.marca, ve.modelo, ve.anio, ve.vin,
       v.precio_final,
       CONCAT(c.nombre, ' ', c.apellido) AS cliente,
       c.cedula, c.telefono, c.email
FROM ventas v
JOIN vehiculos ve ON ve.id_vehiculo = v.id_vehiculo
JOIN clientes c   ON c.id_cliente   = v.id_cliente
WHERE v.fecha_venta BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE()
ORDER BY v.fecha_venta DESC;

-- ----------------------------------------------------------------------------
-- 6. Comisión ganada por cada vendedor según sus ventas
--    (precio final de cada venta x porcentaje de comisión del vendedor).
-- ----------------------------------------------------------------------------
SELECT CONCAT(vd.nombre, ' ', vd.apellido)                                AS vendedor,
       vd.comision_porcentual                                             AS comision_pct,
       COALESCE(SUM(v.precio_final), 0)                                   AS ingreso_total,
       ROUND(COALESCE(SUM(v.precio_final), 0) * vd.comision_porcentual / 100, 2) AS comision_ganada
FROM vendedores vd
LEFT JOIN ventas v ON v.id_vendedor = vd.id_vendedor
GROUP BY vd.id_vendedor, vd.nombre, vd.apellido, vd.comision_porcentual
ORDER BY comision_ganada DESC;

-- ----------------------------------------------------------------------------
-- 7. Promedio de precios de los vehículos vendidos, agrupados por tipo.
--    Se muestran el promedio del precio de lista y el del precio final de venta.
-- ----------------------------------------------------------------------------
SELECT ve.tipo,
       COUNT(*)                       AS vehiculos_vendidos,
       ROUND(AVG(ve.precio), 2)       AS promedio_precio_lista,
       ROUND(AVG(v.precio_final), 2)  AS promedio_precio_final
FROM ventas v
JOIN vehiculos ve ON ve.id_vehiculo = v.id_vehiculo
GROUP BY ve.tipo
ORDER BY promedio_precio_final DESC;

-- ----------------------------------------------------------------------------
-- 8. Marca de vehículo que se ha vendido más veces
--    (si hay empate, se muestran todas las marcas empatadas).
-- ----------------------------------------------------------------------------
WITH ventas_por_marca AS (
    SELECT ve.marca, COUNT(*) AS total_ventas
    FROM ventas v
    JOIN vehiculos ve ON ve.id_vehiculo = v.id_vehiculo
    GROUP BY ve.marca
)
SELECT marca, total_ventas
FROM ventas_por_marca
WHERE total_ventas = (SELECT MAX(total_ventas) FROM ventas_por_marca);
