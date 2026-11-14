# Proyecto Data Warehouse - Arquitectura Medallion

Ejercicio de construcción de un Data Warehouse en SQL Server aplicando la arquitectura Medallion (capas Bronze, Silver y Gold) a partir de archivos CSV de dos sistemas origen: CRM y ERP.

## Estructura de carpetas

- `00_setup/`: instrucciones básicas para levantar la base de datos.
- `01_datasets/`: archivos CSV originales (`source_crm` y `source_erp`).
- `02_docs/`: convenciones de nombres, roadmap y diagrama de flujo.
- `03_scripts/`: scripts SQL separados por capa (`bronze`, `silver`, `gold`) y el script inicial `init_database.sql`.
- `04_tests/`: consultas SQL para revisar que los datos se hayan cargado y limpiado bien.

## Pasos para ejecutar

1. Correr `03_scripts/init_database.sql` en SSMS para crear la base de datos `DataWarehouse` y los esquemas `bronze`, `silver` y `gold`.
2. Correr `03_scripts/bronze/ddl_bronze.sql` para crear las tablas de la capa Bronze.
3. Correr `03_scripts/bronze/proc_load_bronze.sql` y después ejecutar `EXEC bronze.load_bronze;` (ajustando la ruta local de los CSV si hace falta).
4. Correr `03_scripts/silver/ddl_silver.sql` y `03_scripts/silver/proc_load_silver.sql` (`EXEC silver.load_silver;`) para limpiar y pasar los datos a Silver.
5. Correr `03_scripts/gold/ddl_gold.sql` para crear las vistas finales de análisis.
