use real_time_scoring;

drop table if exists rts_api_response_log_staging;

create table rts_api_response_log_staging (
run_date timestamp,
api_response string,
lyl_id_no string,
encrypted_lyl_id_no string,
client string,
time_taken string
)
row format delimited
fields terminated by '|'
lines terminated by '\n'
stored as textfile
;

LOAD DATA INPATH '${hiveconf:input_directory}/part-*' INTO TABLE rts_api_response_log_staging;
