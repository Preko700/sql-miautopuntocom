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
