select memberid, rank, modelName 
from real_time_scoring.api_response_log
where upper(trim(client)) like '%TI%'
and year(run_date) = 2015
and month(run_date) = 2
and day(run_date) = 19
group by memberid, rank, modelName
order by memberid, rank, modelName;
