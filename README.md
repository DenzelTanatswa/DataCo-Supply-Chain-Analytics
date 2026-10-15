<div align="center">

# DataCo Supply Chain Analytics
### Exploring sales, profitability, customer behavior, and delivery performance

![Status](https://img.shields.io/badge/STATUS-IN_PROGRESS-F59E0B?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-E38C00?style=for-the-badge)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=for-the-badge&logo=jupyter&logoColor=white)

**180,519 order-item records · 65,752 orders · 20,652 customers · 118 products**

[Explore Notebooks](Notebooks) · [Browse SQL Analysis](SQL) · [LinkedIn](https://www.linkedin.com/in/denzel-chidzikwe-0a6965288/)

</div>

---

## Overview

An ongoing data analytics portfolio project using the DataCo supply chain dataset to investigate commercial performance and delivery efficiency.

The current workflow combines Python data preparation, exploratory analysis, PostgreSQL integration, and SQL business analysis. The next proposed phase is an interactive Power BI dashboard and a consolidated findings report.

**Project status:** In progress. The repository contains working analysis artifacts and recorded notebook outputs; final dashboards and recommendations are still to be developed.

## Business Questions

- How do sales and profitability vary across markets and product categories?
- Which categories generate losses?
- How does sales performance change over time?
- Which shipping modes and markets have the highest late-delivery rates?
- How do customer segments differ in spending and purchasing behavior?
- What proportion of customers place repeat orders?

## Progress

| Phase | Current evidence |
| :--- | :--- |
| Data understanding | Notebook included |
| Data cleaning and feature engineering | Notebook, cleaned CSV, and quality report included |
| Exploratory analysis | Notebook and six summary CSVs included |
| PostgreSQL integration | Notebook records a successful database connection and data import |
| SQL business analysis | Queries included for KPIs, profitability, shipping, and customers; review ongoing |
| Power BI dashboard | Proposed next phase; no report file currently included |
| Final findings and recommendations | Pending consolidated review |

## Dataset at a Glance

| Metric | Recorded value |
| :--- | ---: |
| Raw columns | 53 |
| Cleaned columns, including engineered features | 58 |
| Order-item records | 180,519 |
| Distinct orders | 65,752 |
| Distinct customers | 20,652 |
| Distinct products | 118 |
| Duplicate order-item IDs | 0 |

Metrics come from the committed data quality report and notebook outputs. Rows represent **order items**, not unique orders.

The raw dataset and a column-description file are included under `Data/Raw/`. An original dataset download URL and reuse terms should be added to the project documentation.

## Data Preparation

The cleaning notebook:

- Removes selected personal/contact fields and unused columns from the analytical output.
- Standardizes column names for Python and SQL.
- Parses order and shipping dates.
- Creates year, month, quarter, weekday, and shipping-date features.
- Calculates delivery delay and classifies delivery performance.
- Adds an on-time flag, profit margin, loss indicator, and order-value band.
- Checks duplicate IDs, missing dates, negative quantities, and sales calculations.
- Exports a cleaned dataset and quality summary.

### Selected Engineered Fields

| Field | Definition |
| :--- | :--- |
| `delivery_delay_days` | Actual shipping days minus scheduled shipping days |
| `delivery_performance` | Canceled, Late, Early, or On Time |
| `on_time_delivery_flag` | 1 for early/on-time, 0 for late, missing for canceled |
| `profit_margin_pct` | Recorded profit divided by order-item total, multiplied by 100 |
| `loss_flag` | 1 when recorded profit is negative |
| `order_value_category` | Low: up to 100; Medium: above 100 through 500; High: above 500 |

The quality report records **7,754 missing values**. The cleaning logic intentionally leaves the on-time flag undefined for canceled items, and its recorded canceled count is also 7,754. This is distinct from claiming that all analytical fields are complete.

## Preliminary Delivery Findings

Recorded cleaning outputs show:

| Delivery outcome | Order-item records |
| :--- | ---: |
| Late | 98,977 |
| Early | 41,592 |
| On Time | 32,196 |
| Canceled | 7,754 |

The exported shipping summary reports late rates of **100.00% for First Class**, **79.83% for Second Class**, **47.93% for Same Day**, and **39.77% for Standard Class**.

These are descriptive results from the dataset, not evidence that shipping mode causes delays. Validate the definitions, denominators, and coverage before making operational recommendations.

## SQL Analysis

Queries target `analytics.supply_chain_orders` and cover:

| Area | Analysis |
| :--- | :--- |
| Business KPIs | Distinct orders, customers, sales, profit, margin, and average order value |
| Time trends | Annual performance and monthly sales growth |
| Product performance | Category sales, profitability, and loss-making categories |
| Market performance | Sales, profit, and shipping comparisons |
| Delivery performance | Actual/scheduled days, delays, and late rates |
| Customer analysis | Segment behavior, repeat customers, and spending |

SQL techniques include aggregations, conditional `FILTER`, CTEs, window-based growth analysis, numeric casts, and `NULLIF` safeguards.

## Technology Stack

| Stage | Tools |
| :--- | :--- |
| Preparation and analysis | Python, Pandas, NumPy, Jupyter |
| Visualization | Matplotlib and notebook charts |
| Database integration | SQLAlchemy, psycopg2 |
| Business querying | PostgreSQL, pgAdmin |
| Planned reporting | Power BI |

## Explore Locally

### 1. Clone and Install

```bash
git clone https://github.com/DenzelTanatswa/DataCo-Supply-Chain-Analytics.git
cd DataCo-Supply-Chain-Analytics
python -m venv .venv
```

Activate the environment:

```powershell
# Windows PowerShell
.venv\Scripts\Activate.ps1
```

```bash
# macOS / Linux
source .venv/bin/activate
```

```bash
python -m pip install pandas numpy matplotlib seaborn jupyter sqlalchemy psycopg2-binary
cd Notebooks
python -m jupyter notebook
```

Run notebooks in numerical order. Some cells contain machine-specific Windows paths: update these for your local checkout. Notebook 02 also contains exploratory/out-of-order cells; review the column-standardization and date-conversion sequence before running it from a fresh kernel.

### 2. Prepare PostgreSQL

Create the database through pgAdmin or another PostgreSQL client:

```sql
CREATE DATABASE dataco_supply_chain;
```

Connect to that database, then create the schema:

```sql
CREATE SCHEMA IF NOT EXISTS analytics;
```

Run `04_PostgreSQL_Integration.ipynb`. Its connection defaults to `localhost:5432`, database `dataco_supply_chain`, and user `postgres`; adjust these as needed. The notebook prompts for the password.

The import uses `if_exists="fail"` to avoid overwriting an existing table. If it already exists, inspect it before rerunning the import.

### 3. Validate the Import

```sql
SELECT
    COUNT(*) AS order_items,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM analytics.supply_chain_orders;
```

Expected counts from committed artifacts: **180,519 items**, **65,752 orders**, and **20,652 customers**.

Open the scripts in `SQL/` to explore business questions. These instructions are based on source inspection; no fresh database import was performed for this README.

## Repository Guide

| Path | Contents |
| :--- | :--- |
| `Data/Raw/` | Source supply chain data and field descriptions |
| `Data/Cleaned/` | Prepared dataset and quality report |
| `Data/Cleaned/EDA_Summaries/` | Annual, category, market, segment, and shipping summaries |
| `Notebooks/01_Data_Understanding.ipynb` | Initial inspection |
| `Notebooks/02_Data_Cleaning.ipynb` | Cleaning and feature engineering |
| `Notebooks/03_Exploratory_Analysis.ipynb` | EDA and summaries |
| `Notebooks/04_PostgreSQL_Integration.ipynb` | Database connection and import |
| `SQL/` | Business analysis queries |

## Next Steps

- [ ] Make notebook paths portable and confirm top-to-bottom execution.
- [ ] Review SQL outputs and reconcile KPI definitions across tools.
- [ ] Check profit-field grain before treating summed profit as a final business KPI.
- [ ] Validate date coverage before comparing full-year performance.
- [ ] Build a Power BI dashboard for sales, profitability, delivery, and customers.
- [ ] Add dashboard screenshots and an editable report.
- [ ] Publish a consolidated findings report with supported recommendations.
- [ ] Add source attribution and a reproducible dependency manifest.

## Interpretation Notes

- Exclude canceled items consistently when calculating eligible delivery rates.
- Count distinct order IDs when reporting orders; row counts report order items.
- Confirm whether profit fields are item-level or repeated at order level before aggregation.
- Annual summaries include 2015–2018; confirm period completeness before inferring annual growth.
- Findings remain preliminary while the project is under development.

## Author

**Denzel Chidzikwe**  
BSc Information Technology · Big Data Analytics

[GitHub](https://github.com/DenzelTanatswa) · [LinkedIn](https://www.linkedin.com/in/denzel-chidzikwe-0a6965288/)

