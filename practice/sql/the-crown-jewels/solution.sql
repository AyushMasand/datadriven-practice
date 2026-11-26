with top_products as (select 
    product_id,
    total_revenue
  from(select 
  product_id,
  sum(total_amount) as total_revenue,
  dense_rank() over(order by sum(total_amount) desc) as rn
 from transactions 
 where product_id is not null
 group by product_id)t
 where rn < 6)
 
 select 
     p.product_name,
     d.total_revenue
 from products p
 join top_products d 
 on d.product_id = p.product_id
