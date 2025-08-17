# 1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.
SELECT DISTINCT market
FROM dim_customer
WHERE customer = 'Atliq Exclusive' 
AND region = 'APAC'
ORDER BY market ASC;

#2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, unique_products_2020, unique_products_2021 and percentage_chg
WITH up_20
AS (
	SELECT COUNT(DISTINCT product_code) unique_product_20
    FROM fact_sales_monthly
    WHERE fiscal_year = 2020
)
, up_21
AS (
	SELECT COUNT(DISTINCT product_code) unique_product_21
    FROM fact_sales_monthly
    WHERE fiscal_year = 2021
)
SELECT unique_product_20,
	unique_product_21,
	ROUND(((unique_product_21 - unique_product_20) /
unique_product_20) * 100, 2) AS pct_change
FROM up_20,
	up_21;

#3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains 2 fields, segment and product_count
SELECT segment,
		COUNT(DISTINCT product_code) AS product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC;

#4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields- segment, product_count_2020, product_count_2021, difference
WITH pc_20
AS (
	SELECT p.segment, 
			COUNT(DISTINCT s.product_code) AS product_count_2020
	FROM fact_sales_monthly s
    JOIN dim_product p 
    ON s.product_code = p.product_code
    WHERE s.fiscal_year = 2020
    GROUP BY p.segment
    ),
pc_21
AS (
	SELECT p.segment,
			COUNT(DISTINCT s.product_code) AS product_count_2021
	FROM fact_sales_monthly s
    JOIN dim_product p 
    ON s.product_code = p.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY p.segment
    )
SELECT p1.segment, p1.product_count_2020,
		p2.product_count_2021,
        (p2.product_count_2021 - p1.product_count_2020) 
AS difference
FROM pc_20 p1
JOIN pc_21 p2
ON p1.segment = p2.segment
ORDER BY difference DESC;

#5. Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields: product_code, product, and manufacturing_cost
WITH r1
AS (
	SELECT p.product_code,
			p.product, 
            p.category,
            m.manufacturing_cost,
            DENSE_RANK() OVER (
            ORDER BY m.manufacturing_cost DESC) AS product_rank
	FROM fact_manufacturing_cost m
    JOIN dim_product p 
    ON m.product_code = p.product_code)
SELECT product_code,
		product,
        category,
        manufacturing_cost
FROM r1
WHERE product_rank = 1
	OR product_rank = (
		SELECT MAX(product_rank)
FROM r1)
ORDER BY r1.manufacturing_cost DESC;

#6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. The final output contains these fields: customer_code, customer, and average_discount_percentage
SELECT c.customer_code,
		c.customer,
        ROUND(AVG(pre.pre_invoice_discount_pct) * 100, 2) 
AS average_discount_percentage
FROM fact_pre_invoice_deductions pre
JOIN dim_customer c 
ON pre.customer_code = c.customer_code
WHERE pre.fiscal_year = 2021 AND 
		c.market = 'India'
GROUP BY c.customer_code, 
		c.customer
ORDER BY average_discount_percentage DESC 
LIMIT 5;

#7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . This analysis helps to get an idea of low and high-performing months and take strategic decisions. The final report contains these columns: Month, Year, and Gross sales Amount
WITH Sales_CTE AS (
    SELECT 
        s.date, 
        s.fiscal_year,
        SUM(gp.gross_price * s.sold_quantity) AS total_sales
    FROM fact_sales_monthly s
    JOIN fact_gross_price gp 
        ON s.product_code = gp.product_code
    JOIN dim_customer c
        ON s.customer_code = c.customer_code
    WHERE c.customer = 'Atliq Exclusive'
    GROUP BY s.date, s.fiscal_year
)
SELECT 
    CONCAT(MONTHNAME(s.date), ' (', YEAR(s.date), ')') AS month, 
    s.fiscal_year,
    CASE 
        WHEN total_sales >= 1e9 THEN CONCAT(ROUND(total_sales / 1e9, 2), 'B')
        WHEN total_sales >= 1e6 THEN CONCAT(ROUND(total_sales / 1e6, 2), 'M')
        WHEN total_sales >= 1e3 THEN CONCAT(ROUND(total_sales / 1e3, 2), 'K')
        ELSE ROUND(total_sales, 2)
    END AS gross_sales_amount
FROM Sales_CTE s
ORDER BY s.date;

#8. In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity, Quarter and total_sold_quantity
WITH sqr AS (
	SELECT 
		CASE
			WHEN MONTH(date) BETWEEN 9 AND 11 THEN 'Q1'
            WHEN MONTH(date) IN (12, 1, 2) THEN 'Q2'
            WHEN MONTH(date) BETWEEN 3 AND 5 THEN 'Q3'
            WHEN MONTH(date) BETWEEN 6 AND 8 THEN 'Q4'
		END AS quarter,
        SUM(sold_quantity) AS total_sold_quantity
	FROM fact_sales_monthly
    WHERE fiscal_year = 2020
    GROUP BY quarter
)
SELECT
	quarter, 
    total_sold_quantity,
    ROUND(100.0 * total_sold_quantity / SUM(total_sold_quantity)
OVER(), 2) AS pct_contrib
FROM sqr
ORDER BY total_sold_quantity DESC;

#9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields: channel gross_sales_mln, percentage
WITH gs
AS (
	SELECT c.channel,
		SUM(gp.gross_price * s.sold_quantity) AS gross_sales_mln
    FROM fact_sales_monthly s
    JOIN fact_gross_price gp
    ON s.product_code = gp.product_code
AND s.fiscal_year = gp.fiscal_year
	JOIN dim_customer c 
    ON s.customer_code = c.customer_code
    WHERE s.fiscal_year = 2021
    GROUP BY c.channel
    )
SELECT channel, 
		ROUND(gross_sales_mln / 1e6, 2) AS gross_sales_mln,
        ROUND(100.0 * gross_sales_mln / SUM(gross_sales_mln) OVER
(), 2) AS pct_contrib
FROM gs
ORDER BY pct_contrib DESC;

#10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these fields: division, product_code, product, total_sold_quantity, rank_order
WITH pr1 AS (
    SELECT 
        p.division,
        p.product_code,
        p.product,
        SUM(s.sold_quantity) AS total_sold_quantity
    FROM fact_sales_monthly s
    JOIN dim_product p
        ON p.product_code = s.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY 
        p.division,
        p.product_code,
        p.product
),
pr2 AS (
    SELECT 
        pr1.*,
        DENSE_RANK() OVER (
            PARTITION BY pr1.division
            ORDER BY total_sold_quantity DESC
        ) AS rank_order
    FROM pr1
)
SELECT *
FROM pr2
WHERE rank_order <= 3;

    
    