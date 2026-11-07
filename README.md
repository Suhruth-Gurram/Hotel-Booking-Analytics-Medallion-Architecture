
# Hotel Booking Analytics Using Databricks | Medallion Architecture 🚀

### End-to-End Data Engineering Project Using Lakeflow Spark Declarative Pipelines

## 📌 Project Overview

This project focuses on building an end-to-end Hotel Booking Analytics Platform using Databricks SQL and Lakeflow Spark Declarative Pipelines.

The objective is to transform raw hotel booking data into clean, reliable, and business-ready datasets using the Medallion Architecture (Bronze, Silver, and Gold layers).

The project demonstrates data ingestion, data cleaning, data transformation, data quality validation, and dashboard development.

## 🎯 Project Objectives

- Ingest raw hotel booking data into Databricks.
- Implement Medallion Architecture.
- Build Bronze, Silver, and Gold data layers.
- Identify and remove duplicate records.
- Handle missing and inconsistent values.
- Validate booking dates and room rates.
- Create business-level summary tables.
- Build an interactive dashboard for business insights.

## 🛠️ Technologies Used

- Databricks
- Databricks SQL
- Lakeflow Spark Declarative Pipelines
- Unity Catalog
- Medallion Architecture
- SQL
- Databricks AI/BI Dashboards

## 📂 Dataset Overview

The project uses a synthetic Hotel Booking Dataset containing:

- 1,316 records
- 20 columns
- Hotel booking information for 2025

### Important Columns

| Column | Description |
|---|---|
| booking_id | Unique booking identifier |
| guest_id | Guest identifier |
| booking_date | Booking date |
| check_in_date | Guest check-in date |
| check_out_date | Guest check-out date |
| hotel_name | Hotel name |
| city | Hotel location |
| room_type | Type of room |
| booking_channel | Booking source |
| room_rate | Price per night |
| total_amount | Total booking amount |
| booking_status | Completed or Cancelled |

## 🏗️ Medallion Architecture

The project follows a three-layer Medallion Architecture.

![Medallion Architecture](architecture/medallion_architecture.png)

### Architecture Workflow

Source CSV → Bronze Layer → Silver Layer → Gold Layer → Dashboard

### Architecture Workflow

Source CSV → Bronze Layer → Silver Layer → Gold Layer → Dashboard

### 1. Bronze Layer – Raw Data

- Ingested the original hotel booking CSV file.
- Stored source records without business-level cleaning.
- Added source file information and load timestamp.
- Created the Bronze streaming table.

### 2. Silver Layer – Data Cleaning

Performed data cleaning and validation operations.

- Removed duplicate booking records.
- Removed extra spaces using TRIM().
- Standardized text using INITCAP().
- Handled missing values using COALESCE().
- Calculated missing nights using DATEDIFF().
- Calculated missing total amounts.
- Validated check-in and check-out dates.
- Identified negative room rates.
- Separated invalid records into a rejected table.

### 3. Gold Layer – Business Aggregations

Created business-ready summary tables.

| Gold Table | Purpose |
|---|---|
| gold_monthly_bookings | Monthly booking and revenue trends |
| gold_hotel_summary | Hotel and regional performance |
| gold_room_type_summary | Room type performance |
| gold_channel_summary | Booking channel and cancellation analysis |
| gold_data_quality | Data quality and reconciliation |


<img width="957" height="462" alt="image" src="https://github.com/user-attachments/assets/be372a99-4375-41b6-95ec-544a42b54cc6" />



## 📊 Dashboard Development

Created a dashboard using Databricks AI/BI Dashboards to visualize business performance.

### Dashboard Pages

**1. Overview**
- Total bookings
- Net revenue
- Room nights
- Cancelled bookings
- Monthly revenue trends
- Revenue by city

**2. Hotels, Rooms & Channels**
- Hotel-wise revenue
- Average daily rate
- Room type performance
- Average guest rating
- Booking channel cancellation rate

**3. Data Quality**
- Bronze record count
- Clean records
- Rejected records
- Duplicate records
- Data quality checks
- Reconciliation results

  <img width="1252" height="825" alt="image" src="https://github.com/user-attachments/assets/e50961a0-b563-40f0-ac50-802138687f59" />

  published link:https://dbc-d929a080-5434.cloud.databricks.com/dashboardsv3/01f1da9c688d11fa991b0d3b3fbce2a7/published?o=7474657309836429


## 🧹 Data Quality & Validation

Implemented data quality checks to improve the reliability of the booking data.

Key validations include:

- Duplicate booking identification.
- Missing value handling.
- Invalid date identification.
- Negative room rate validation.
- Data reconciliation.

Reconciliation formula:

Bronze Rows = Clean Rows + Rejected Rows + Duplicate Rows Removed

## 📈 Business Insights

The Gold layer supports analysis of:

- Monthly booking trends.
- Hotel and city-wise revenue.
- Room type performance.
- Booking channel performance.
- Cancellation rates.
- Revenue generated from completed bookings.

Cancelled bookings are retained in the Silver layer but excluded from Gold revenue calculations.


## 🚀 Key Learnings

Through this project, I gained practical experience in:

- Building end-to-end data pipelines.
- Implementing Medallion Architecture.
- Working with Databricks SQL.
- Using Lakeflow Spark Declarative Pipelines.
- Data cleaning and transformation.
- Implementing data quality checks.
- Creating business-ready datasets.
- Developing interactive dashboards.

## 👨‍💻 Project Information

**Project:** Hotel Booking Analytics Platform

**Domain:** Data Engineering

**Architecture:** Medallion Architecture

**Platform:** Databricks

**Language:** SQL

**Project Type:** End-to-End Data Engineering Project

---

⭐ If you find this project useful, feel free to explore the repository!
