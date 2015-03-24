#! /bin/bash

cd /home/auto/msaha/rts/api/final;
current_timestamp=`date +%Y-%m-%d'  '%H':'%M`
echo $current_timestamp
current_day=`date +%d`
yesterday=$(date '+%d' -d "1 day ago")

current_month=`date +%m`
current_year=`date +%Y`

sql_dir=/home/auto/msaha/rts/api/final
sql_file=step3.sql


hive -hiveconf current_year=${current_year} current_month=${current_month} current_day=${current_day} yesterday=${yesterday} -f ${sql_dir}/${sql_file} 
ret_code=$?
case ${ret_code} in
     0) printf "\nAPI api_response_log_all table insert job successful \n" >> /home/auto/msaha/rts/api/final/logs/load_api.log
     printf "\nAPI api_response_log_all table insert job success with Return Code=${ret_code}\n"| mailx -s "API api_response_log_all table insert job Success" -a /home/auto/msaha/rts/api/final/logs/step3.log msaha$searshc.com;;
     *) printf "\nAPI api_response_log_all table insert failed\n" >> /home/auto/msaha/rts/api/final/logs/load_api.log
     printf "\nAPI api_response_log_all table insert job failed with Return Code=${ret_code}\n"| mailx -s "api_response_log_all table insert Failed" -a /home/auto/msaha/rts/api/final/logs/step3.log msaha$searshc.com
     exit 1 ;;
esac

