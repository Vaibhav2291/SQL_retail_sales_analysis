-- SQL Project retail analysis - Project 1

Create database sql_project_p1;

Use sql_project_p1;

-- Create table
drop table if exists retail_sales;
Create table retail_sales 
(
			transactions_id int Primary Key,
			sale_date date,
			sale_time time,
			customer_id int,
			gender varchar(15),
			age int,
			category varchar(15),
			quantiy int,
			price_per_unit float,
			cogs float,
			total_sale float
);


-- Data Cleaning

Select *
from retail_sales
where transactions_id is NUll or
  sale_date is NUll or
  sale_time is NUll or
  customer_id is NUll or
  gender is NUll or
  age is NUll or
  category is NUll or
  quantiy is NUll or 
  price_per_unit is NUll or
  cogs is NUll or
  total_sale is NUll;
  
Delete from retail_sales
where transactions_id is NUll or
  sale_date is NUll or
  sale_time is NUll or
  customer_id is NUll or
  gender is NUll or
  age is NUll or
  category is NUll or
  quantiy is NUll or 
  price_per_unit is NUll or
  cogs is NUll or
  total_sale is NUll;
  
-- Data exploration

-- What number of sales does the business have?

Select count(*)
From retail_sales;

-- Answer: 1987

-- How many unique customers does the busines have?

Select count(distinct customer_id)
From retail_sales;

-- Answer: 155

-- List the unique catergories of products in this business.

Select distinct category
From retail_sales;

-- Beauty, Clothing, and Electronics.

-- Sale made on a particular date, June 24th, 2024 for example.

Select*
From retail_sales
Where sale_date='2022-06-24';

Select*
From retail_sales;

-- In the month of November 2022, how many times were the clothes sold in quantities greater than or equal to 4.

Select*
From retail_sales
Where date_format (sale_date, '%Y-%m')='2022-11' and category='Clothing' and quantity>=4;

-- Alternatively:

Select*
From retail_sales
Where sale_date between '2022-11-01' and '2022-11-30' and quantity >=4 and category='Clothing';

-- answer: In November 2022, Clothing was sold 17 times in quantities reater than 4.

Select*
From retail_sales;

-- Question: Calculate the toal number or orders and net sales of each of the categories in the table.

Select distinct category, count(*) total_orders, sum(total_sale) Net_Sale
From retail_sales
Group by category
order by 2 desc;

-- Question: What is the average age of customers of products from the beauty category?

Select category, round(avg(age)) avg_age
from retail_sales
where category='beauty'; 

-- Answer: 40

-- QUestion: Find all high ticket sales where the transaction value is greater than 1000

Select*
From retail_sales
Where total_sale>1000;

-- Question: Write a SQL query to find the total number of transactions made by each gender in each category

Select category, gender, count(transactions_id) 
From retail_sales
group by category, gender
Order by 1;

-- Question: Find out the average sale for each month. Find out the best selling month.

Select `year`, `month`, `avg_sale`
from (Select 
year(sale_date) `year`, month(sale_date) `month`, round(avg(total_sale)) avg_sale, 
rank() over(partition by year(sale_date) order by avg(total_sale) DESC) as 'rank'
From retail_sales
Group by year(sale_date), month(sale_date)
) as T1
Where `rank`=1;

-- Answer: In 2022, the highest average sales were recorded in July, while in 2023, February had the highest average sales.

-- Question: Identify the highest total sales by top 5 customers.

Select customer_id, sum(total_sale) as total_sales
From retail_sales
Group by customer_id
order by 2 desc limit 5;

-- Question: Write a SQL query to find out unique customers who purchased from each categories?

Select category, Count(distinct customer_id) count_of_unique_customers
From retail_sales
Group by 1;

-- Question: Wrtie a SQL query to categorize orders in three shifts (Morning<12, Afternoon between 12 and 17, Evening>17)

Select*
From retail_sales;

with Shift_wise_orders As
(Select*,
Case
When hour(sale_time)<12 then 'Morning'
When hour(sale_time) between 12 and 17 then 'Afternoon'
Else 'Evening'
End as Shift
From retail_sales)
Select Shift, count(*) Orders
From Shift_wise_orders
Group by Shift;

-- End project