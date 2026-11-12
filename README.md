# Quiz #5 – SQL: MiAutoPuntoCom

Base de datos en **MySQL** para el sistema de información de la empresa MiAutoPuntoCom (vehículos, clientes, vendedores y ventas).
Curso CE 2103 Algoritmos y Estructuras de Datos II, II Semestre 2026, TEC.

## Archivos

| Archivo | Contenido |
|---|---|
| `01_ddl.sql` | **Partes 1 y 2.** Crea la base `miautopuntocom`, las 4 tablas, sus claves, restricciones y triggers. |
| `02_dml.sql` | **Parte 3.** Inserta 12 vehículos, 6 clientes, 4 vendedores y 8 ventas. |
| `03_consultas.sql` | **Parte 4.** Las 8 consultas solicitadas, numeradas igual que el enunciado. |

## Cómo ejecutarlo

En MySQL Workbench, abra cada archivo y ejecútelo **en este orden**: `01_ddl.sql`, `02_dml.sql`, `03_consultas.sql`.
Desde la terminal:

```bash
mysql -u root -p < 01_ddl.sql
mysql -u root -p < 02_dml.sql
mysql -u root -p < 03_consultas.sql
```

`01_ddl.sql` borra y vuelve a crear la base, así que se puede repetir todo el proceso desde cero.

## Modelo

```
vehiculos (id_vehiculo PK, marca, modelo, anio, color, precio, vin UNIQUE, tipo, estado)
clientes  (id_cliente PK, nombre, apellido, cedula UNIQUE, telefono, email UNIQUE, direccion)
vendedores(id_vendedor PK, nombre, apellido, cedula UNIQUE, fecha_nacimiento,
           fecha_contratacion, comision_porcentual)
ventas    (id_venta PK, id_vehiculo FK UNIQUE, id_cliente FK, id_vendedor FK,
           fecha_venta, precio_final, metodo_pago)
```

`ventas` está normalizada: solo guarda referencias a las otras tres tablas.

## Restricciones (Parte 2)

| Regla del enunciado | Cómo se implementó |
|---|---|
| Claves primarias en todas las tablas | `PRIMARY KEY` autoincremental en cada tabla |
| Integridad referencial | 3 claves foráneas en `ventas` (`ON DELETE RESTRICT`, `ON UPDATE CASCADE`) |
| UNIQUE en VIN, cédulas y emails | `uq_vehiculos_vin`, `uq_clientes_cedula`, `uq_clientes_email`, `uq_vendedores_cedula` |
| Año entre 1900 y el año actual | `CHECK (anio >= 1900)` y triggers `BEFORE INSERT/UPDATE` para el límite superior |
| Precio mayor que 0 | `CHECK (precio > 0)` (y también en `precio_final`) |
| Comisión entre 0 % y 20 % | `CHECK (comision_porcentual BETWEEN 0 AND 20)` |
| Estado solo 'Nuevo' o 'Usado' | `CHECK (estado IN ('Nuevo', 'Usado'))` |
| Vendedores de al menos 21 años | `CHECK` sobre `fecha_nacimiento` y `fecha_contratacion` |
| NOT NULL en campos obligatorios | Todos los campos son `NOT NULL` |

## Decisiones de diseño

- **Edad de los vendedores.** El enunciado no lista la fecha de nacimiento, pero es necesaria para validar los 21 años, así que se agregó la columna `fecha_nacimiento`. MySQL no permite `CURDATE()` dentro de un `CHECK`, por lo que se valida que el vendedor tuviera al menos 21 años **al ser contratado**. Eso garantiza que hoy también los tiene.
- **Año actual.** Por la misma limitación se usa un trigger para rechazar años mayores al año en curso.
- **Un vehículo se vende una sola vez.** `ventas.id_vehiculo` es `UNIQUE`.
- **Fechas de las ventas de prueba.** Son relativas a `CURDATE()`, para que la consulta del último mes devuelva datos sin importar cuándo se ejecute.
- **Consulta 7.** Muestra el promedio del precio de lista y del precio final de venta, porque el enunciado no aclara cuál de los dos se espera.
- **Consultas 4 y 8.** Si hay empates (mayor compra o marca más vendida), se muestran todos los empatados.
- **Precios.** Están en dólares.
