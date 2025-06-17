# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Sale made on a particular date, June 24th, 2024 for example.**:
```sql
Select*
From retail_sales
Where sale_date='2022-06-24';
```

2. **In the month of November 2022, how many times were the clothes sold in quantities greater than or equal to 4**:
```sql
Select*
From retail_sales
Where date_format (sale_date, '%Y-%m')='2022-11' and category='Clothing' and quantity>=4;
```
**-- Alternatively:**
```
Select*
From retail_sales
Where sale_date between '2022-11-01' and '2022-11-30' and quantity >=4 and category='Clothing';
```
3. **Calculate the total number or orders and net sales of each of the categories in the table.**:
```sql
Select distinct category, count(*) total_orders, sum(total_sale) Net_Sale
From retail_sales
Group by category
order by 2 desc;
```
4. **What is the average age of customers of products from the beauty category?.**:
```sql
Select category, round(avg(age)) avg_age
from retail_sales
where category='beauty';
```
5. **Find all high ticket sales where the transaction value is greater than 1000.**:
```sql
Select*
From retail_sales
Where total_sale>1000;
```

6. **Write a SQL query to find the total number of transactions made by each gender in each category**:
```sql
Select category, gender, count(transactions_id) 
From retail_sales
group by category, gender
Order by 1;
```
7. **Find out the average sale for each month. Find out the best selling month.**:

```sql
Select `year`, `month`, `avg_sale`
from (Select 
year(sale_date) `year`, month(sale_date) `month`, round(avg(total_sale)) avg_sale, 
rank() over(partition by year(sale_date) order by avg(total_sale) DESC) as 'rank'
From retail_sales
Group by year(sale_date), month(sale_date)
) as T1
Where `rank`=1;
```
8. **Identify the highest total sales by top 5 customers.**:
```sql
Select customer_id, sum(total_sale) as total_sales
From retail_sales
Group by customer_id
order by 2 desc limit 5;
```
9. **Write a SQL query to find out unique customers who purchased from each categories?**:
```sql
Select category, Count(distinct customer_id) count_of_unique_customers
From retail_sales
Group by 1;
```

10. **Wrtie a SQL query to categorize orders in three shifts (Morning<12, Afternoon between 12 and 17, Evening>17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.
