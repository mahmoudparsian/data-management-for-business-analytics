
-- Use the Superstore Relationonal database
USE Superstore;

-- 1. Top 5 customers by total sales

-- custormer_name (DimCustomer), total_sales (FactOrderDetails)
select c.customer_name,
       round(sum(f.sales), 2) as total_sales
from DimCustomers as c
inner join DimOrders as o on c.customer_id = o.customer_id
inner join FactOrderDetails as f on o.order_id = f.order_id
group by c.customer_name
order by total_sales desc
limit 5;

-- 2. Total profit per region

Select region, round(sum(profit), 2) as total_profit
FROM dimlocations as l
inner join dimorders as o on l.location_id = o.location_id
inner join factorderdetails as fo on o.order_id = fo.order_id
group by region;

-- 3. Most profitable sub-category
select  subcategory_name ,round(sum(profit), 2) as total_profit
from DimSubCategories as sc
inner join DimProducts as p on p.subcategory_id = sc.subcategory_id
inner join FactOrderDetails as fo on fo.product_id = p.product_id
group by subcategory_name
order by total_profit desc 
limit 1;

-- 4. Year-over-year sales growth

-- 5. Top 3 states with highest number of orders

-- 6. Average delivery time per ship mode






