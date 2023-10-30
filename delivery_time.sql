select *
from orders;


select 
	order_id, 
    order_purchase_timestamp, order_delivered_customer_date, order_status 
    order_estimated_delivery_date
from orders;


#create table delivery_time as
SELECT 
	TIMESTAMPDIFF(day, order_purchase_timestamp, order_delivered_customer_date) AS delivery_time, 
    TIMESTAMPDIFF(day, order_delivered_customer_date, order_estimated_delivery_date) AS days_faster_than_estimate, 
	order_id
FROM orders;

#create table delivery_time_status as
SELECT 
	TIMESTAMPDIFF(day, order_purchase_timestamp, order_delivered_customer_date) AS delivery_time, 
    TIMESTAMPDIFF(day, order_delivered_customer_date, order_estimated_delivery_date) AS days_faster_than_estimate, 
	order_id, order_status
FROM orders;


#What is the average time between order being placed and the product being deliverd?
SELECT 
	avg(delivery_time),
    avg(days_faster_than_estimate)
FROM delivery_time;
#Average delivery time is 12 days and deliverys are 11 days faster in average than estimated (for all orders that have been deliverd = 96.478 orders)

SELECT 
	avg(delivery_time),
    avg(days_faster_than_estimate),
    order_status,
    count(order_id)
FROM delivery_time_status
group by order_status;
#96.478 orders delivered, 1.107 orders shipped, 609 unavailable, 625 canceled (0,6%), 314 invoiced, 301 processed, 2 approved, 5 created


#How many orders are delivered with delay?
SELECT 
	avg(delivery_time),
    avg(days_faster_than_estimate),
    order_status, count(order_id)
FROM delivery_time_status
where days_faster_than_estimate < 0
group by order_status;
#6.534 orders are delayed (33 days delivery time, on average 11 days delayed) = 7%


#Is there a pattern for the delayed orders?
#create table delivery_delay as
SELECT 
	delivery_time,
	days_faster_than_estimate,
    order_status, order_id
FROM delivery_time_status
where days_faster_than_estimate < 0;


#Comparison of shipping date and shipping limit date
select 
o.order_id, order_delivered_carrier_date, shipping_limit_date
from orders o
join order_items o_i
on o.order_id = o_i.order_id;


# join of tables to get product information on delayed orders
#create table delivery_products as
select 
	o.order_id, p.product_id, order_status, 
    order_purchase_timestamp, 
    order_delivered_carrier_date, shipping_limit_date, 
    order_delivered_customer_date, order_estimated_delivery_date,
    price, product_category_name, 
    product_weight_g
from orders o
left join order_items o_i
on o.order_id = o_i.order_id
left join products p
on p.product_id = o_i.product_id;

select 
	product_category_name,
    count(distinct delivery_delay.order_id)
from delivery_delay
left join delivery_products
on delivery_delay.order_id = delivery_products.order_id
group by 
	product_category_name
order by 
	count(delivery_delay.order_id) desc;
#291 orders in telefonia =(7%) were delayed, 417 orders in informatica_acessorios (=6%)

# how many oders are ther in telefonia and informatica_acessorios?
select 
	product_category_name,
    count(distinct order_id)
from delivery_products
group by product_category_name;
#there are 4199 in telefonia and 6689 in informatica_acessorios


select 
	count(delivery_products.product_id),
    case
		when product_weight_g <= 1000 then 'light'
        when product_weight_g <= 1000 then 'medium heavy'
        when product_weight_g <= 10000 then 'heavy'
	else 'very heavy'
    end as product_weight
from delivery_delay
left join delivery_products
on delivery_delay.order_id = delivery_products.order_id
group by product_weight;
#There are 4126 light (below 1 kg) products delayed, 2658 heavy products (10-1oo kg) and 481 very heavy (>100kg)

