select 
    s.content_type,
    count(v.view_id) as view_count
from content_items s
join content_views v 
on v.content_id = s.content_id
group by s.content_type
