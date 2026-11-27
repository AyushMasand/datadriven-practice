select 
  user_id,
  total_amount,
  transaction_date
from(
select 
  t.user_id,
  t.total_amount,
  t.transaction_date,
  ROW_NUMBER() OVER(PARTITION BY t.user_id ORDER BY t.transaction_date,transaction_id) as rn
from transactions t)t
where rn = 2
