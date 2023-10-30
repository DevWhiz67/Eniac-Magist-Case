use magist;

#what categories of tech products does Magist have?

select distinct(product_category_name)
from products;

select * 
from product_category_name_translation;

# the relevant categories for Eniac I will look at are informatica_acessorios, pcs, tablets_impressao_imagem, telefonia
#optional are eletronicos, audio, eletronicos, eletroportateis, cine_foto

#created a new table with products, prices and categories
create table product_price_category as
select p.product_id, price, product_category_name, order_id
from products p
join order_items oi
on p.product_id = oi.product_id
order by price desc;

select *
from product_price_category;

#create a table with pricegroups
create table products_pricegroups_categories as
select 
	product_id,product_category_name, order_id,
    CASE 
        WHEN price <= 50 THEN '50'
        WHEN price <= 100 THEN '100'
        WHEN price <= 250 THEN '250'
        WHEN price <= 500 THEN '500'
        WHEN price <= 750 THEN '750'
        WHEN price <= 1000 THEN '1000'
        WHEN price <= 2500 THEN '2500'
        ELSE '5000'
    END AS price_group
FROM 
    product_price_category;

#content new table:
select *
from products_pricegroups_categories;


#Number of products sold by category and price segment
select 
    COUNT(DISTINCT product_id) AS unique_products_count,
    COUNT(product_id) AS products_count,
    price_group, product_category_name
FROM 
    products_pricegroups_categories
GROUP BY 
	price_group, product_category_name
order by 
	price_group asc,
    product_category_name asc;


#Group by Technology and others (first only with 4 categories)
SELECT 
    price_group, 
    COUNT(DISTINCT product_id) AS unique_products_count,
    COUNT(product_id) AS products_count,
    CASE 
        WHEN product_category_name = 'informatica_acessorios' 
            OR product_category_name = 'pcs' 
            OR product_category_name = 'tablets_impressao_imagem' 
            OR product_category_name = 'telefonia'
            THEN 'Technology'
        ELSE 'others'
    END AS technology_category
FROM 
    products_pricegroups_categories
GROUP BY 
    CASE 
        WHEN product_category_name = 'informatica_acessorios' 
            OR product_category_name = 'pcs' 
            OR product_category_name = 'tablets_impressao_imagem' 
            OR product_category_name = 'telefonia'
            THEN 'Technology'
        ELSE 'others'
    END, 
    price_group
order by technology_category, price_group asc;

#Group by Technology and others (now with a broader definition - 8 categories)    
SELECT 
    price_group, 
    ROUND(AVG(price)) AS average_price,
    COUNT(DISTINCT product_id) AS unique_products_count,
    COUNT(product_id) AS products_count,
    CASE 
        WHEN product_category_name = 'informatica_acessorios' 
            OR product_category_name = 'pcs' 
            OR product_category_name = 'tablets_impressao_imagem' 
            OR product_category_name = 'telefonia'
            OR product_category_name = 'eletronicos' 
            OR product_category_name = 'eletroportateis' 
            OR product_category_name = 'audio'
            OR product_category_name = 'cine_foto'
            THEN 'Technology_broad'
        ELSE 'others'
    END AS technology_category
FROM 
    product_pricegroup_category
GROUP BY 
    CASE 
        WHEN product_category_name = 'informatica_acessorios' 
            OR product_category_name = 'pcs' 
            OR product_category_name = 'tablets_impressao_imagem' 
            OR product_category_name = 'telefonia'
            OR product_category_name = 'eletronicos' 
            OR product_category_name = 'eletroportateis' 
            OR product_category_name = 'audio'
            OR product_category_name = 'cine_foto'
            THEN 'Technology_broad'
        ELSE 'others'
    END, 
    price_group
order by technology_category, price_group asc; 

  
   
