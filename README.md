# 🛒 E-Commerce Sales Analysis

> **End-to-end data analyst portfolio project** using Excel, SQL, and Power BI to uncover sales trends, profitability drivers, and customer behavior in a simulated e-commerce dataset.

---

## 📌 Project Overview

This project analyzes **2,000 e-commerce transactions** across 2 years (2023–2024), covering 6 product categories and 5 regions. The goal is to deliver actionable business insights through:

- **Data cleaning & exploration** in Excel
- **Business-logic queries** in SQL
- **Interactive dashboard** in Power BI

---

## 🎯 Business Questions Answered

| # | Question |
|---|---|
| 1 | What are the total revenue, profit, and order trends over time? |
| 2 | Which product categories drive the most revenue and margin? |
| 3 | How does region impact sales performance? |
| 4 | What is the return rate and its revenue impact? |
| 5 | How do discounts affect profit margins? |
| 6 | Who are the highest-value customers? |
| 7 | Which shipping method is most used and most profitable? |
| 8 | What is the year-over-year growth? |

---

## 🗂️ Repository Structure

```
ecommerce-sales-analysis/
│
├── data/
│   ├── raw_orders.csv                  # Source dataset (2,000 rows)
│   ├── Ecommerce_Sales_Analysis.xlsx   # Excel workbook (5 sheets)
│   └── generate_data.py                # Script to regenerate dataset
│
├── sql/
│   ├── 01_schema.sql                   # Table schema & indexes
│   └── 02_analysis_queries.sql         # 10 business analysis queries
│
├── reports/
│   ├── PowerBI_Setup_Guide.md          # Step-by-step Power BI instructions
│   └── Ecommerce_Sales_Dashboard.pbix  # Power BI dashboard (add after building)
│
└── README.md
```

---

## 📊 Excel Workbook — Sheet Breakdown

| Sheet | Description |
|---|---|
| `Raw_Data` | Full dataset with filters, color-coded, formatted |
| `Monthly_Summary` | Aggregated monthly KPIs with totals row |
| `Category_Performance` | Revenue & profit by category, ranked |
| `Region_Analysis` | Regional breakdown with market share |
| `KPI_Summary` | Key metrics dashboard (snapshot view) |

---

## 🗄️ SQL Queries — Summary

| Query | Description |
|---|---|
| Q1 | Overall KPI Summary |
| Q2 | Monthly Revenue & Profit Trend |
| Q3 | Revenue by Category (with RANK) |
| Q4 | Top 10 Products by Revenue |
| Q5 | Regional Performance + Market Share |
| Q6 | Order Status Distribution |
| Q7 | Shipping Method Analysis |
| Q8 | Customer Segmentation (RFM-lite) |
| Q9 | Discount Band Impact on Margin |
| Q10 | Year-over-Year Growth (LAG window function) |

---

## 📈 Key Findings

- 📦 **Electronics** is the top revenue category, driven by high unit prices
- 🌍 The **West** and **North** regions contribute the highest revenue
- 💸 Higher discounts (>15%) reduce average profit margin by ~12 percentage points
- ↩️ Return rate sits at ~10%, representing significant revenue leakage
- 📅 Revenue shows consistent **month-over-month growth** through 2023–2024
- 🚀 **Express shipping** correlates with higher average order values

---

## 🛠️ Tools & Tech Stack

| Tool | Purpose |
|---|---|
| **Microsoft Excel** | Data cleaning, summaries, KPI view |
| **SQL (MySQL / PostgreSQL)** | Business queries, aggregations, window functions |
| **Power BI Desktop** | Interactive dashboard & visual storytelling |
| **Python** | Dataset generation (pandas, openpyxl) |

---

## 🚀 How to Use This Project

### Option A — Excel Only
1. Open `data/Ecommerce_Sales_Analysis.xlsx`
2. Explore each sheet — filters are enabled on `Raw_Data`

### Option B — SQL
1. Run `sql/01_schema.sql` to create the table
2. Import `data/raw_orders.csv` into your database
3. Run queries in `sql/02_analysis_queries.sql`

### Option C — Power BI Dashboard
1. Open Power BI Desktop
2. Follow `reports/PowerBI_Setup_Guide.md` step by step
3. Build and explore the 3-page interactive dashboard

### Regenerate Dataset
```bash
pip install pandas openpyxl
python data/generate_data.py
python data/build_excel.py
```

---

## 📬 Contact

**[Your Name]**  
📧 your.email@example.com  
🔗 [LinkedIn](https://linkedin.com/in/yourprofile)  
💻 [GitHub](https://github.com/yourusername)

---

*This is a portfolio project using synthetically generated data for demonstration purposes.*
