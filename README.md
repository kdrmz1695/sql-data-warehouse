# SQL Data Warehouse Project

This repository contains my implementation of a SQL Server data warehouse project built with a **Bronze / Silver / Gold** architecture.

## Important Note

This project is **not my original idea**.  
I built it by following the excellent teaching and project walkthrough shared by **Baraa from the Data with Baraa YouTube channel**.

I used his guidance to practice data warehousing concepts, SQL development, ETL logic, and dimensional modeling.  
Full credit for the original project structure, learning flow, and teaching approach goes to **Data with Baraa**.

## Attribution

This project was created as a **learning implementation** based on the content published by **Data with Baraa**.

- YouTube Channel: **Data with Baraa**
- Project inspiration: **SQL Data Warehouse from Scratch**
- Original educational repository and materials belong to their respective creator

If you are reviewing this repository, please treat it as a **practice / portfolio learning project**, not as an original end-to-end concept authored entirely by me.

---

## Project Overview

The goal of this project is to build a simple modern data warehouse in **SQL Server** using a layered architecture:

- **Bronze Layer** → raw data ingestion from CSV files
- **Silver Layer** → data cleansing, transformation, and standardization
- **Gold Layer** → analytical views for reporting and business use

The data comes from multiple source systems and is transformed into a more analytics-friendly structure.

---

## Architecture

### 1. Bronze Layer
The bronze layer stores raw data loaded from CSV files without major transformation.

Tables created in this layer include:

- `bronze.crm_cust_info`
- `bronze.crm_prd_info`
- `bronze.crm_sales_details`
- `bronze.erp_loc_a101`
- `bronze.erp_cust_az12`
- `bronze.erp_px_cat_g1v2`

### 2. Silver Layer
The silver layer applies cleaning and transformation logic such as:

- removing duplicates
- trimming unwanted spaces
- standardizing text values
- fixing invalid or missing values
- converting dates into proper SQL date types
- preparing product/category keys
- normalizing customer, product, and sales data

### 3. Gold Layer
The gold layer contains analytics-ready views:

- `gold.dim_customers`
- `gold.dim_products`
- `gold.fact_sales`

These views are designed for reporting and dimensional analysis.

---

## Project Files

### Database setup
- `init_database.sql`  
  Creates the `DataWarehouse` database and the `bronze`, `silver`, and `gold` schemas.

### Bronze layer
- `create bronze table.sql`  
  Creates the bronze tables.
- `load bronze layer.sql`  
  Loads raw CSV data into bronze tables using `BULK INSERT`.

### Silver layer
- `create silver table.sql`  
  Creates the silver tables.
- `load silver layer.sql`  
  Cleans and loads data from bronze into silver.

Additional transformation logic is also explored in:
- `silver prd cust table.sql`
- `prd_info table for silver.sql`
- `silver-sales detail table last one.sql`

### Gold layer
- `gold layer final.sql`  
  Builds the final dimensional views for customer, product, and sales analysis.

---

## Data Processing Highlights

### Customer data
- removes duplicate customer records using `ROW_NUMBER()`
- keeps the latest record by `cst_create_date`
- standardizes marital status values
- standardizes gender values
- enriches customer data with ERP birth date and country fields

### Product data
- extracts category ID from product key
- standardizes product line values
- replaces null costs with `0`
- calculates `prd_end_dt` using `LEAD()` for current/historical product version handling

### Sales data
- converts integer-based date fields into SQL `DATE`
- handles invalid date values
- validates business rules such as:
  - sales = quantity × price
- repairs invalid sales or price values where possible

---

## Gold Layer Output

### `gold.dim_customers`
Customer dimension with:
- surrogate key
- customer ID / number
- first and last name
- marital status
- create date
- birth date
- gender
- country

### `gold.dim_products`
Product dimension with:
- surrogate key
- product ID / number
- category ID
- product name
- cost
- product line
- category and subcategory
- maintenance info

### `gold.fact_sales`
Fact table/view with:
- order number
- product key
- customer key
- order / ship / due dates
- sales amount
- quantity
- price

---

## How to Run

1. Run `init_database.sql`
2. Run `create bronze table.sql`
3. Run `create silver table.sql`
4. Run `load bronze layer.sql`
5. Run `load silver layer.sql`
6. Run `gold layer final.sql`

---

## Tech Stack

- SQL Server
- T-SQL
- SSMS
- CSV source files
- Medallion Architecture

---

## Learning Goals

This project helped me practice:

- data warehouse layering
- ETL workflow design
- SQL data cleaning
- dimensional modeling
- surrogate key generation
- analytical view creation

---

## Credit

This repository is a practice implementation based on the work and teaching of **Baraa / Data with Baraa**.  
Please check out the original creator’s content for the full learning experience and original explanation.

I am sharing this repository as part of my learning journey and SQL/data engineering practice.
