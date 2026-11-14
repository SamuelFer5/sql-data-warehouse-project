# Guía de Configuración del Proyecto (Setup Guide)

Sigue estos pasos en orden para inicializar y ejecutar el almacén de datos en **SQL Server Management Studio (SSMS)**.

---

## Requisitos Previos
- **Microsoft SQL Server** (Express, Developer o Enterprise).
- **SQL Server Management Studio (SSMS)**.
- Repositorio clonado localmente.

---

## Orden de Ejecución de Scripts

### 1. Inicializar la Base de Datos y Esquemas
Ejecuta el script [`03_scripts/init_database.sql`](../03_scripts/init_database.sql) en SSMS.
- Crea la base de datos `DataWarehouse`.
- Crea los esquemas `bronze`, `silver` y `gold`.

### 2. Crear las Tablas de la Capa Bronze (DDL)
Ejecuta el script [`03_scripts/bronze/ddl_bronze.sql`](../03_scripts/bronze/ddl_bronze.sql).
- Crea las 6 tablas correspondientes a los sistemas `CRM` y `ERP` dentro del esquema `bronze`.

### 3. Crear y Ejecutar el Procedimiento Almacenado de Carga (Bronze)
1. Abre [`03_scripts/bronze/proc_load_bronze.sql`](../03_scripts/bronze/proc_load_bronze.sql).
   *(Nota: Verifica que las rutas de los archivos CSV en `BULK INSERT` coincidan con la ubicación local de tu carpeta `01_datasets`).*
2. Ejecuta el script para compilar el procedimiento `bronze.load_bronze`.
3. Ejecuta la carga de datos con:
   ```sql
   EXEC bronze.load_bronze;
   ```

### 4. Validar la Carga de la Capa Bronze
Ejecuta el script [`04_tests/quality_checks_bronze.sql`](../04_tests/quality_checks_bronze.sql) para comprobar que los esquemas, columnas y conteos de filas sean correctos.
