create table if not exists real_time_scoring.changed_scores_stats as 
select 
b.run_date as storm_run_date
,b.client
,a.source
,count(*)
from real_time_scoring.api_storm_log a
left outer join real_time_scoring.api_response_log b on a.run_date=b.run_date and a.encrypted_lyl_id_no = b.encrypted_memberid
where 
      a.minexpiry > b.run_Date
      and a.maxexpiry <= b.run_date
      and a.oldscore <> a.newscore
group by b.run_date, b.client, a.source
order by storm_run_Date, client, source
;

