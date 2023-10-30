#How many sellers are there?
select *
from sellers;

select *
from order_items;

select *
from orders;


select count(distinct seller_id)
from sellers;
#there are 3095 sellers (different seller id's)


#How many tech sellers are there?

select 
	oi.order_id, p.product_id,
    price, product_category_name, seller_id
from order_items oi
left join products p
on p.product_id = oi.product_id;
#table with sellers, prices and product categories

select 
	product_category_name, count(distinct seller_id)
from order_items oi
left join products p
on p.product_id = oi.product_id
where 
	product_category_name = 'telefonia' 
    or product_category_name = 'informatica_acessorios' 
	OR product_category_name = 'pcs' 
	OR product_category_name = 'tablets_impressao_imagem'
    OR product_category_name = 'eletronicos' 
	OR product_category_name = 'eletroportateis' 
	OR product_category_name = 'audio'
	OR product_category_name = 'cine_foto'
group by product_category_name
order by count(distinct seller_id) desc;
#there are 755 different tech sellers

#what is the total amount earned by all sellers?

#create TABLE seller_product_prices as
Select
	CAST(price AS DECIMAL(10, 2)) AS price,
    seller_id, product_category_name, p.product_id, oi.order_id
from order_items oi
left join products p
on p.product_id = oi.product_id;

select
	sum(price)
from
	seller_product_prices;
#The total amount earned is 13.591.643 Euro (sum of prices of all products sold)
#Are there products sold several times (in one row)?

select
	sum(price), product_category_name
from
	seller_product_prices
where 
	product_category_name = 'telefonia' 
    or product_category_name = 'informatica_acessorios' 
	OR product_category_name = 'pcs' 
	OR product_category_name = 'tablets_impressao_imagem'
    OR product_category_name = 'eletronicos' 
	OR product_category_name = 'eletroportateis' 
	OR product_category_name = 'audio'
	OR product_category_name = 'cine_foto'
group by product_category_name
order by
	sum(price) desc;
