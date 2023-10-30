#Is there growth in the technology segment?

select *
from product_price_category;

select year(order_purchase_timestamp), month(order_purchase_timestamp), order_id
from orders;

SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(o.order_id) AS order_count,
    product_category_name
FROM orders o
JOIN product_price_category ppc
ON o.order_id = ppc.order_id
where product_category_name = 'telefonia'
GROUP BY 
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp),
    product_category_name
ORDER BY 
    order_year ASC, 
    order_month ASC;
    #NUmber of orders in telefonia has increased until 2/18. Since then it is decreasing
    
    
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(o.order_id) AS order_count,
    product_category_name
FROM orders o
JOIN product_price_category ppc
ON o.order_id = ppc.order_id
where product_category_name = 'informatica_acessorios'
GROUP BY 
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp),
    product_category_name
ORDER BY 
    order_year ASC, 
    order_month ASC;
#NUmber of orders of informatica_acessorios has increased until 2/18. Since then it is decreasing

SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(o.order_id) AS order_count,
    product_category_name
FROM orders o
JOIN product_price_category ppc
ON o.order_id = ppc.order_id
where product_category_name = 'pcs'
GROUP BY 
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp),
    product_category_name
ORDER BY 
    order_year ASC, 
    order_month ASC;
#NUmber of orders of pcs has increased until 9/17. Since then it is decreasing (low number of orders anyway 41 max)
