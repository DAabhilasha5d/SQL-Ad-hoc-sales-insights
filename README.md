# 📊 Provide Insights for Management in Consumer Goods Domain  
### Codebasics Monthly Resume Challenge #4  

---

## 📝 Project Overview  
This project is part of the **Codebasics Monthly Resume Challenge #4**, where I analyzed AtliQ Hardware’s **business data using SQL** and presented meaningful insights in a structured and engaging format.  

- 🔍 Focus: Consumer Goods Domain  
- 🛠️ Tools: SQL, Power BI, Canva  
- 📈 Goal: Deliver actionable insights for management through data storytelling  

---

## 🏢 Company Overview – AtliQ Hardware  
AtliQ Hardware (imaginary company) is a **leading manufacturer of computer hardware and accessories**, operating across four major regions:  

🌍 **Global Presence**  
- 🌎 North America (NA)  
- 🌍 Latin America (LATAM)  
- 🏰 Europe (EU)  
- 🌏 Asia-Pacific (APAC)  

🖥️ **Core Business Divisions**  
- 🔗 Networking & Storage → Routers, Switches, External Drives  
- 💻 PCs → Laptops, Desktops, Workstations  
- 🎧 Peripherals & Accessories → Keyboards, Mice, Monitors, Headsets  

---

## 📝 Problem Statement  
AtliQ Hardware faced challenges in **data-driven decision-making** due to lack of actionable insights.  
To address this, they expanded their analytics team and designed this challenge to test **SQL proficiency and business storytelling skills**.  

---

## 🎯 My Role  
As a **Junior Data Analyst**, my responsibilities included:  
- 🔍 Analyzing sales, pricing, and customer data  
- 📊 Extracting insights to support strategic decisions  
- 🎥 Presenting findings in a structured & engaging format  

---

## 🚀 My Approach  
1. 📄 **Understanding Business Needs** – Reviewed 10 ad-hoc business requests requiring insights  
2. 🔍 **Running SQL Queries** – Fetched relevant data from multiple tables  
3. 📊 **Building Dashboard in Power BI** – Transformed raw data into actionable insights  
4. 🎥 **Storytelling with Canva** – Designed engaging presentation with visuals and charts  

---

## 📂 Dataset Details  

### 🔹 Dimension Tables  
- **dim_date** → Time-based attributes (fiscal year, quarter, month order)  
- **dim_customer** → Customer details (name, platform, channel, market, region, sub-zone)  
- **dim_product** → Product details (product code, category, division, variant)  

### 🔹 Fact Tables  
- **fact_sales_monthly** → Monthly sales (date, customer_code, product_code, sold_quantity)  
- **fact_gross_price** → Pricing data (gross_price by fiscal year)  
- **fact_manufacturing_cost** → Production costs (manufacturing_cost by year)  
- **fact_pre_invoice_deductions** → Discounts before invoicing (discount % by customer & year)  

---

## 🧑‍💻 SQL Concepts Applied  
- **WHERE & ORDER BY** → Filtering & sorting data  
- **DISTINCT** → Counting unique products/customers  
- **CTEs (WITH statements)** → Modular queries for better readability  
- **GROUP BY & Aggregations** → SUM, AVG, COUNT for summaries  
- **JOINs (INNER, LEFT)** → Combining data from multiple tables  
- **DENSE_RANK() with PARTITION BY** → Ranking within categories  
- **CASE Statement** → Conditional logic in queries  
- **ROUND() & Formatting** → Presenting percentages & sales in millions  
- **HAVING vs. WHERE** → Filtering aggregated results  
- **Subqueries & Nested Queries** → Inline calculations for trends/differences  

---

## 🔑 Key Insights  

### 🌍 APAC Market Performance  
- Top markets: **India, Bangladesh, Indonesia, Australia**  
- Lower contribution: **Japan & South Korea**  

### 📊 Unique Product Growth (2021 vs. 2020)  
- Unique products increased **+36.33%** (245 → 334)  
- Product diversification drove higher demand  

### 🛒 Product Segments & Trends  
- **Notebooks & Accessories** dominate product count  
- **Networking products** had lowest count → potential gap  
- Accessories saw **34 new launches**, Notebooks +16  

### 💰 Manufacturing Costs  
- **Highest:** AQ HOME Allin1 Gen 2 – $240.54  
- **Lowest:** AQ Master Wired Mouse – $0.89  

### 🏷️ Top 5 Indian Customers by Avg. Discount (FY 2021)  
- **Highest discount:** Flipkart (30.83%), Viveks, Ezone  
- **Lowest discount:** Amazon (29.33%)  

### 📈 Monthly Gross Sales Trend  
- FY 2021: **$224.42M** vs FY 2020: **$79.50M**  
- **Peak:** Oct 2021 ($32.2M)  
- **Lowest:** Mar 2020 ($767K, likely COVID impact)  

### 📦 Quarterly Sales Distribution (2020)  
- **Q1 (33.72%)** & Q2 (32.01%) highest  
- **Q3 (9.99%)** lowest → seasonal dip  

### 📊 Total Sold Quantity Contribution  
- **Highest months:** Dec (15.33%), Nov (14.69%)  
- **Lowest month:** Mar (1.15%)  

### 🛍️ Gross Sales by Channel  
- **Retailers:** $1219.1M  
- **Direct:** $257.5M  
- **Distributors:** $188.0M  
- Retail (B2C) dominates  

### 🏆 Top 3 Best-Selling Products by Division (FY 2021)  
- **Networking & Storage:** AQ Pen Drive 2 IN 1 (701,373 units)  
- **Peripherals & Accessories:** Gaming & Maxima Mouse  
- **PC Division:** AQ Digit & AQ Velocity (lower sales comparatively)  

---

## 📌 Conclusion  
This project demonstrates **SQL-driven analytics** with clear **business storytelling**.  
It provides management with insights into:  
✔️ Regional performance  
✔️ Product growth & gaps  
✔️ Pricing & discount strategy  
✔️ Seasonal sales trends  

Helping AtliQ Hardware make **smarter, data-driven decisions** in the competitive consumer goods market.  
