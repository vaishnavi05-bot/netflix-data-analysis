create database sales_behaviour_data;
use sales_behaviour_data;
create table sales_data (
Product_id varchar(50),
Sales_Date DATE,
Sales_Rep varchar(50),
Region varchar(20),
Sales_Amount Float,
Quantity_Sold int,
Product_Category varchar(50),
Unit_cost Float,
Customer_Type varchar(20),
Discount Float,
Payment_Method varchar(50),
Sales_Channel varchar(20),
Region_and_Sales_Rep varchar(100)
);
select * from sales_data;
alter table sales_data add profit float;
set sql_safe_updates =0;
update sales_data set profit = unit_price - unit_cost;
set sql_safe_updates=1;
select * from sales_data;
# which region generates highest sales
select region,format(sum(sales_amount), 2) as total_sales from sales_data group by region order by total_sales desc;
# which sales representative performs best
select sales_rep,round(sum(sales_amount),2) as total_sales,round(sum(profit),2) as total_profit,sum(quantity_sold) as total_units ,round(avg(discount)*100,2) as avg_discount_percent from sales_data group by sales_rep order by total_profit desc;
#what is the average per transaction
select payment_method as pm,round(avg(sales_amount),2) from sales_data group by pm ;
select * from sales_data;

describe sales_data;
select Payment_Method from sales_data limit 5;
alter table sales_data change Payment_Method payment_method varchar(50);
#which product category sells the most units
select product_category,sum(quantity_sold) as total_units from sales_data group by product_category order by total_units desc limit 1; 
#which category generates highest revenue
select product_category,format(sum(sales_amount),2) as highest_revenue from sales_data group by product_category order by highest_revenue desc limit 1;
#which category gives maximum profit margin
alter table sales_data change Product_Category product_category varchar(50);
alter table sales_data change profit profit varchar(50);
select * from sales_data;
select Product_Category as pc,format(sum(profit),2) as total_profit from sales_data group by Product_Category order by total_profit desc ;
#how does discount affect profit
select round(discount * 100,0) as discount_percent,round(avg(profit),2) as avg_profit from sales_data group by discount_percent order by discount_percent;
#find reps giving high discount low profit
select sales_rep,round(avg(discount*100),0) as avg_discount,round(sum(profit),2) as total_profit from sales_data group by sales_rep order by avg_discount desc; 
#how does discount affect profit?
select round(discount * 100,0) as discount_percent,round(avg(profit),2) as avg_profit from sales_data group by discount_percent order by discount_percent desc ;
#do returning customers spend more
select distinct customer_type ,round(avg(sales_amount),2) as total_spending from sales_data group by customer_type order by total_spending;
#which region & repo performs best limit 4
select region,sales_rep,round(sum(Profit),2) as total_profit from sales_data group by region,sales_rep order by total_profit desc limit 4;

