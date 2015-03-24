#! /bin/bash
cd /home/auto/msaha/rts/storm
current_timestamp=`date +%Y-%m-%d'  '%H':'%M`
echo $current_timestamp
#current_month=Feb
current_month=`date +%b`
current_year=`date +%Y`
current_day=`date +%d`
yesterday=$(date '+%d' -d "1 day ago")
yesterday_full=$(date '+%Y-%m-%d' -d "1 day ago")

sql_dir=/home/auto/msaha/rts/storm
sql_file=insert_storm_log_partition.sql


hive -hiveconf current_year=${current_year} current_month=${current_month} current_day=${current_day} yesterday=${yesterday} yesterday_full=${yesterday_full} -f ${sql_dir}/${sql_file}
