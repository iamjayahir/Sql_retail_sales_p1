DROP TABLE IF EXISTS retail_Sales;
CREATE TABLE retail_Sales 
(
			transactions_id INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR (15),
			age INT,
			category VARCHAR(15),
			quantiy INT,
			price_per_unit  FLOAT,
			cogs FLOAT,
			total_sale  FLOAT

);

select * from retail_sales;

-- Record count
SELECT COUNT(*) 
FROM retail_sales;

-- DATA CLEANING
select * from retail_sales
where transactions_id is null;


-- Checking for null values
select * from retail_sales
where 
	transactions_id is null
	or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;

-- Delete null values

set sql_safe_updates = 0;

DELETE FROM retail_sales
WHERE 
	transactions_id is null
	or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;
     
-- 
SELECT COUNT(*) FROM retail_sales;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) AS Total_Sales 
FROM retail_sales; 

-- How many unique customers we have ?

SELECT COUNT(DISTINCT customer_id ) AS Customer_Count
FROM retail_sales; 

-- How many unique category we have ?

SELECT COUNT(DISTINCT category ) AS category_Count
FROM retail_sales; 

-- Data Analysis & Business Key problem & answer
SELECT * FROM retail_sales;

-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05 ?
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is  4 or more than 4 in the month of Nov-2022:
SELECT *
FROM retail_sales
WHERE 
	category = 'Clothing' 
    AND 
    sale_date like '2022-11-%'
    AND
    quantiy >= 4;
-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,count(*) AS Total_orders ,sum(total_sale) AS net_sales
from retail_sales
group by category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT  category,round(avg(age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';


-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM retail_sales
WHERE
	total_sale > 1000;
    
-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT gender,category, count(*) AS Total_orders
FROM retail_sales
GROUP BY gender, category
order by category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT YEAR, MONTH,Avg_sale
FROM(
		SELECT
			YEAR (sale_date) AS YEAR,
			MONTH(sale_date) AS MONTH,
			ROUND(AVG(total_sale),2) AS Avg_sale,
			RANK() OVER(PARTITION BY YEAR (sale_date)  ORDER BY ROUND(AVG(total_sale),2) DESC) AS rank_
		FROM retail_sales
		GROUP BY 1, 2
		ORDER BY 1,3 DESC 
	) as t1
WHERE t1.rank_ = 1;
-- 8. Write a SQL query to find the top 5 customers based on the highest total sales
SELECT
	customer_id,
    SUM(total_sale) As Total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_sale DESC
LIMIT 5 ;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
	category,
    COUNT(DISTINCT customer_id) as Customer_Count
FROM 
	retail_sales
GROUP BY
	category
ORDER BY Customer_count DESC;
    
-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_orders AS
(

			SELECT 
				*,
				CASE
					WHEN sale_time < '12:00:00' THEN 'MORNING'
					WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'AFTERNOON'
					WHEN sale_time > '17:00:00' THEN 'EVENING'
					ELSE 'NO SHIFT'
				END as shift
			FROM retail_sales
	)
SELECT 
	shift,
    COUNT(*) As Total_orders
FROM
	hourly_orders
GROUP BY shift;

-- END OF PROJECT 
    






