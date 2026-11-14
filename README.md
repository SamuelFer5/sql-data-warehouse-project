# SQL Data Warehouse Project — Arquitectura Medallion

Construcción de un almacén de datos moderno (*Data Warehouse*) en **SQL Server** implementando la **Arquitectura Medallion** (**Bronze**, **Silver** y **Gold**), integrando datos de ventas provenientes de dos sistemas de origen (**CRM** y **ERP**).

---

## 🏗️ Arquitectura de Datos (Medallion)

1. **Capa Bronze (Datos Originales):** Almacena los datos en bruto tal como vienen de los archivos CSV de origen (`CRM` y `ERP`) mediante procesos por lotes (`TRUNCATE` + `BULK INSERT`).
2. **Capa Silver (Datos Depurados):** Limpieza, estandarización, normalización de datos y creación de columnas derivadas.
3. **Capa Gold (Datos Analíticos):** Datos integrados y modelados en Esquema en Estrella (*Star Schema*: dimensiones `dim_` y hechos `fact_`) listos para reportes de BI y consultas analíticas.

---

## 📂 Estructura del Proyecto

```text
sql-data-warehouse-project/
├── 00_setup/               Guía de configuración y ejecución del entorno.
├── 01_datasets/            Archivos CSV de origen.
│   ├── source_crm/         Archivos del sistema CRM (clientes, productos, ventas).
│   └── source_erp/         Archivos del sistema ERP (categorías, ubicación, datos demográficos).
├── 02_docs/                Convenciones de nomenclatura, flujo de datos y roadmap.
├── 03_scripts/             Scripts SQL del Data Warehouse.
│   ├── init_database.sql   Crea la base de datos DataWarehouse y los esquemas.
│   ├── bronze/             DDL y Stored Procedure de carga para la capa Bronze.
│   ├── silver/             DDL y transformaciones para la capa Silver.
│   └── gold/               Vistas analíticas del modelo estrella para la capa Gold.
└── 04_tests/               Scripts de validación y calidad de datos.
```

---

## 🚀 Inicio Rápido (Capa Bronze)

1. Ejecuta [`03_scripts/init_database.sql`](03_scripts/init_database.sql) para crear la base de datos y los esquemas.
2. Ejecuta [`03_scripts/bronze/ddl_bronze.sql`](03_scripts/bronze/ddl_bronze.sql) para crear las 6 tablas de la capa Bronze.
3. Ejecuta [`03_scripts/bronze/proc_load_bronze.sql`](03_scripts/bronze/proc_load_bronze.sql) y corre `EXEC bronze.load_bronze;` para cargar los CSV.
4. Ejecuta [`04_tests/quality_checks_bronze.sql`](04_tests/quality_checks_bronze.sql) para validar la integridad de la carga.

Consulta la documentación detallada en [`02_docs/data_flow_bronze.md`](02_docs/data_flow_bronze.md) y [`02_docs/convenciones_nomenclatura_es.md`](02_docs/convenciones_nomenclatura_es.md).
