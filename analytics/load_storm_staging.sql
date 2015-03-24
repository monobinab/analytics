drop table real_time_scoring.rts_storm_log_staging;

create table if not exists real_time_scoring.rts_storm_log_staging (
head_date string,
tail_date string,
lid string,
modelId string,
oldScore string,
newScore string,
minExpiry string,
maxExpiry string,
source string
)
row format delimited
fields terminated by '|'
lines terminated by '\n'
stored as textfile
;

LOAD DATA INPATH '${hiveconf:input_directory}/part-*' INTO TABLE real_time_scoring.rts_storm_log_staging;
--load data inpath '/tmp/adhoc_storm_2/part*' into table real_time_scoring.rts_storm_log_staging;
