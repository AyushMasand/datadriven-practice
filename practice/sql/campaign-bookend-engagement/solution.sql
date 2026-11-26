with imp as (
select 
  ad_campaign,
  DATETRUNC(DAY,MIN(impression_time)) as first_imp_date,
  DATETRUNC(DAY,MAX(impression_time)) as last_imp_date,
  count(impression_id) as impressions
from ad_impressions
group by ad_campaign)

select 
    i.ad_campaign,
    SUM(CASE 
       WHEN i.first_imp_date = DATETRUNC(DAY,a.impression_time) THEN 1
    END) * 100.0 / i.impressions AS first_day_pct,
    SUM(CASE 
       WHEN i.last_imp_date = DATETRUNC(DAY,a.impression_time) THEN 1
    END) * 100.0 / i.impressions AS last_day_pct
from imp i 
join ad_impressions a 
on a.ad_campaign = i.ad_campaign
group by i.ad_campaign
