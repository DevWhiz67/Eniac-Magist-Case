use magist;

#How many orders are there in the dataset? 
select count(*) 
from orders;
#there are 99.441 orders in the dataset (counting * or order_id's)
select count(product_id) 
from order_items;
#there are 98.666 different order_id's in the table and 32.951 different product id's
#there are 112.650 products being sold


#Are orders actually delivered? 
select count(*), order_status
from orders
group by order_status;
#96.478 orders have been deliverd, 2.963 not


#Is Magist having user growth? 
select count(order_id),year(order_purchase_timestamp), month(order_purchase_timestamp)
from orders
group by year(order_purchase_timestamp), month(order_purchase_timestamp)
order by year(order_purchase_timestamp) asc, month(order_purchase_timestamp) asc;
#the number of orders were growing over time (9/18 and 10/18 very few orders - the last two months)
#however 2017 better than 2018; 6000-7000 orders/month


#How many products are there on the products table?
select count(distinct product_category_name)
from products;
select count(distinct product_id)
from products;
#there are 74 different product_categories (and 32.951 different product id's = all rows)


#Which are the categories with the most products? 
select count(distinct product_id), product_category_name
from products
group by (product_category_name)
order by count(distinct product_id) desc;
#most orders are in casa_mesa_banho and esporte_lazer


#How many of those products were present in actual transactions? 
select count(distinct product_id)
from order_items;
# there are 32.951 different product_id's in the table and 11.2650 orders; 
# all products have been involved in orders


#What’s the price for the most expensive and cheapest products? 
select max(price), min(price)
from order_items;
#the lowest price is 0,85 and the highest 6735 Euro


#What are the highest and lowest payment values? 
select max(payment_value), min(payment_value)
from order_payments;
#the minimum payment value is 0 and the highest 13664.1

select sum(payment_value), order_id
from order_payments
group by order_id
order by sum(payment_value) desc;
#the maximum someone paid for an order is also 13664.1 as each order is only once in the list