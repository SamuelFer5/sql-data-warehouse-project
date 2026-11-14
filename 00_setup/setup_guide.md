# Guía de configuración

Pasos para ejecutar el proyecto en SQL Server Management Studio (SSMS):

1. Abrir y ejecutar `03_scripts/init_database.sql` para crear la base de datos `DataWarehouse` y los tres esquemas (`bronze`, `silver`, `gold`).
2. Ejecutar `03_scripts/bronze/ddl_bronze.sql` para crear las 6 tablas iniciales.
3. En `03_scripts/bronze/proc_load_bronze.sql`, revisar que la ruta de los archivos CSV apunte a la carpeta `01_datasets` de tu computadora, ejecutar el script para crear el procedimiento y luego correr:
   ```sql
   EXEC bronze.load_bronze;
   ```
4. Usar las consultas de `04_tests/quality_checks_bronze.sql` para comprobar que las tablas tengan datos.
