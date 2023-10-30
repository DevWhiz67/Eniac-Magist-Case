
#Why is the number of orders going down?

select 
	*
from 
	order_reviews;
    
    
select 
	count(review_id), review_score,
    year(review_creation_date)
from 
	order_reviews
group by 
	review_score,
    year(review_creation_date)
order by 
	review_score asc,
    year(review_creation_date) asc;
#the score has improved from 2016 (31% score 1 or2) to 2017 and stayed the same from 2017 to 2018 (14% score 1 or 2)

select 
	*
from 
	order_reviews
where
	review_score = 1;
    
#checking delivery data for specific orders
select
	*
from
	orders
where
	order_id = '162b2345ef3cc0551c0a32058840a2ec';
