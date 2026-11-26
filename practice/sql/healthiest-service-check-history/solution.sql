with top_svx as (select 
  distinct svc_name
from svc_health
where uptime = (select max(uptime) from svc_health))

select 
  svc_name,
  checked,
  prev_checked,
  DATEDIFF(SECONDS,prev_checked,checked)/86400.0 as days_diff
from(
select 
    c.svc_name,
    h.checked,
    LAG(h.checked) OVER(PARTITION BY c.svc_name ORDER BY h.checked) as prev_checked
from svc_health h 
join top_svx c
on h.svc_name = c.svc_name)t
