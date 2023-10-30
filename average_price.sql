#average price for all products is 121 Euro
SELECT 
    ROUND(AVG(price)) AS average_price,
    COUNT(DISTINCT product_id) AS unique_products_count,
    COUNT(product_id) AS products_count
from
	product_price_category;


#average price for technology products (broad definition)
SELECT 
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
    END; 
    #the average price is 113 Euro (compared to 122 in all other categories)
    
    
#average price for technology products (narrow definition)
SELECT 
    ROUND(AVG(price)) AS average_price,
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
    product_pricegroup_category
GROUP BY 
    CASE 
        WHEN product_category_name = 'informatica_acessorios' 
            OR product_category_name = 'pcs' 
            OR product_category_name = 'tablets_impressao_imagem' 
            OR product_category_name = 'telefonia'
            THEN 'Technology'
        ELSE 'others'
    END; 
#the average price is 116 Euro (compared to 121 in all other categories)