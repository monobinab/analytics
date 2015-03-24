SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;

use real_time_scoring;
--ALTER TABLE api_storm_log DROP IF EXISTS PARTITION(year = '${hiveconf:current_year}', month = '${hiveconf:current_month}', day = '${hiveconf:current_day}');
--ALTER TABLE api_storm_log DROP IF EXISTS PARTITION(year = '${hiveconf:current_year}', month = '${hiveconf:current_month}', day = '${hiveconf:yesterday}');

insert into table api_storm_log
PARTITION(Year, Month, Day)
select
trim(head_date) as head_date,
trim(tail_date) as tail_date,
unix_timestamp(tail_date, "EEE MMM dd HH:mm:ss z yyyy") as fdate_epoch,
trim(lid) as encrypted_lyl_id_no,
trim(modelId),
trim(oldScore),
trim(newScore),
trim(minExpiry),
trim(maxExpiry),
trim(source),
year(from_unixtime(unix_timestamp(tail_date, "EEE MMM dd HH:mm:ss z yyyy"))) as year,
month(from_unixtime(unix_timestamp(tail_date, "EEE MMM dd HH:mm:ss z yyyy"))) as month,
day(from_unixtime(unix_timestamp(tail_date, "EEE MMM dd HH:mm:ss z yyyy"))) as day
from 
real_time_scoring.rts_storm_log_staging
where
unix_timestamp(tail_date, "EEE MMM dd HH:mm:ss z yyyy") >= unix_timestamp(from_unixtime(unix_timestamp() -1*60*60*24, 'yyyy-MM-dd'), 'yyyy-MM-dd')
and unix_timestamp(tail_date, "EEE MMM dd HH:mm:ss z yyyy") < unix_timestamp(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 'yyyy-MM-dd')
--and length(from_unixtime(unix_timestamp(tail_date, "EEE MMM dd HH:mm:ss z yyyy")))=10
;

