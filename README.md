# 📊 Retail Pricing & Competitiveness Analytics

## 🎯 Project Overview
This repository showcases an automated data pipeline designed to tackle scalability issues in e-commerce pricing monitoring. Inspired by data challenges in global fashion marketplaces, this project demonstrates how to scale item analysis from **20 to 200 daily articles per analyst** by replacing manual validation loops with automated anomaly detection scripts.

## 🛠️ Tech Stack & Skills
- **Python (Pandas & NumPy):** Data generation, automated cleaning, and threshold filtering.
- **SQL (PostgreSQL):** Advanced querying, relational database joins, and Analytical Window Functions (`ROW_NUMBER()`).
- **Data Engineering Concept:** Transforming slow, operational data review into scalable, alert-driven insights.

## 📈 Key Insights & Business Value
- **Scalability Built-in:** The logic isolates pricing mismatches greater than 20%, allowing human teams to focus strictly on business-critical anomalies.
- **Data-Driven Strategy:** Helps Commercial Directors protect profit margins by identifying exactly which competitors are undercutting prices in real-time.

## 🚀 Structure
1. Run `analise_pricing.py` to simulate and generate the data stream.
2. Open `queries.sql` to execute analytical business logic under database structures.
