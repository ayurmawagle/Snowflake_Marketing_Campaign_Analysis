# Snowflake Marketing Campaign Analysis

## Project Overview

This project demonstrates an end-to-end marketing campaign analysis using Snowflake, focusing on building a structured data pipeline and deriving insights through robust analytical SQL queries.  
It covers the full process from database and schema creation, data ingestion from external stages, transformation through views, loading into final tables, and extensive data analysis.  
The project concludes with plans to connect the structured Snowflake data to Power BI for dashboard development.

The aim is to simulate a real-world cloud data pipeline and analytical workflow using Snowflake as the data warehouse and SQL for data engineering and business intelligence purposes.

---

## Dataset Information

- **Source:** [Kaggle: Marketing Campaign Performance Dataset](https://www.kaggle.com/datasets/manishabhatt22/marketing-campaign-performance-dataset)
- **Description:**  
  The dataset contains information on marketing campaign performance, including campaign types, channels, customer targeting attributes (gender, age, location, language), engagement scores, acquisition cost, ROI, clicks, impressions, and campaign dates.

---

## Project Workflow

### 1. Data Ingestion and Setup
- Created a new Snowflake database (`CAMPAIGN`) and schema (`PERF`).
- Defined a custom file format to correctly parse the staged CSV file.
- Staged the marketing campaign dataset for ingestion.
- Created a view (`VIEW_T1`) to transform raw staged data by:
  - Parsing and splitting combined fields like target gender and age.
  - Removing extraneous text (e.g., 'days', dollar signs).
  - Casting fields into correct data types (e.g., DECIMAL, DATE).
  - Extracting campaign year and month for time-series analysis.

### 2. Data Loading (ELT Process)
- Inserted the transformed view data into a permanent structured table `MARKPERF`.
- Implemented an ELT (Extract → Load → Transform) strategy to enable scalable, cloud-native transformation inside Snowflake.

---

## Analysis Performed

### Campaign Overview
- Calculated the average campaign duration by campaign type.
- Calculated the average campaign duration by channel.
- Computed the total number of campaigns and total acquisition cost per company and campaign type.
- Identified campaign types with the highest average ROI.
- Found companies with the lowest average ROI campaigns.

### Demographic Overview
- Counted the number of campaigns targeted toward Men and Women.
- Compared average engagement scores between gender-targeted campaigns.
- Analysed the distribution of ROI across the top customer segments.

### Location Overview
- Identified locations with the most number of campaigns.
- Analysed top-performing locations based on average ROI.

### Time-Series and Trend Overview
- Analysed month-wise average acquisition costs.
- Compared previous and current month's acquisition costs using window functions.
- Analysed month-wise average impressions.
- Identified the top 3 months with the highest total acquisition costs.
- Studied the trend of engagement scores over months.
- Calculated running totals of acquisition costs across months.
- Measured monthly differences in acquisition costs.

### Conversion and Engagement Overview
- Calculated click-to-conversion rates by campaign type.
- Found average conversion rates by channel.
- Identified customer segments with the highest average number of clicks.
- Found the maximum duration and maximum impressions by campaign and channel combination.
- Analysed how the ROI changed from one campaign to the next for each company.
- Ranked campaign types per channel based on average conversion rate.

---

## SQL Techniques Used

- **CTEs (Common Table Expressions):**  
  Used for modular and readable intermediate transformations during month-wise trend analyses and running totals.
  
- **Window Functions:**  
  Applied `LAG()` and `SUM() OVER()` functions to perform previous month comparisons, ROI change tracking, and running totals.

- **Aggregations and Grouping:**  
  Utilized `AVG()`, `SUM()`, `COUNT()`, and `ROUND()` for computing key metrics such as average ROI, total acquisition costs, and engagement scores.

- **String Functions:**  
  Used functions like `SPLIT_PART()`, `RTRIM()`, `REPLACE()`, and `LTRIM()` for cleaning and parsing text fields.

- **Date Functions:**  
  Applied `DATE_PART()` and `MONTHNAME()` to extract useful time components for time-series analysis.

- **Ranking and Ordering:**  
  Used `RANK() OVER (PARTITION BY ...)` to rank campaign types per channel based on performance.

- **Casting and Type Conversions:**  
  Applied explicit casting (`::INT`, `::VARCHAR`, `::DECIMAL`) to ensure data consistency during transformations.

- **HAVING Clause and Conditional Filtering:**  
  Applied `HAVING` clauses for targeted demographic analysis (e.g., only Men or Women targeted campaigns).

- **Data Cleaning During Ingestion:**  
  Implemented cleaning steps during the view creation process to ensure ingestion-ready structured data.

---

## Repository Structure

```
Snowflake_Marketing_Campaign_Analysis/
├── analysis/
│   └── analysis_queries.sql             # Analytical SQL queries
├── data/
│   └── marketing_campaign_dataset.csv   # Raw dataset from Kaggle
├── etl/
│   └── setup_etl.sql                     # Database, schema, staging, transformation, and loading scripts
├── README.md
```

---

## Technologies Used

- Snowflake (Data Warehouse)
- SQL (Snowflake dialect)
- Power BI (for planned dashboard visualization)
- Kaggle (Data Source)

---

## Next Steps

- Connect the Snowflake `MARKPERF` table to Power BI Desktop to build an interactive Power BI dashboard.
---

## Conclusion

This project provided hands-on experience with Snowflake's cloud data warehousing capabilities, demonstrating skills in building data pipelines, performing ELT operations, and conducting comprehensive business data analysis using SQL.  
It represents a complete workflow typical in real-world data analytics environments, showcasing strong proficiency in SQL, data engineering practices, and readiness for business intelligence dashboard development.

---
