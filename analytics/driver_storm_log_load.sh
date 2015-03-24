#! /bin/bash
/home/auto/msaha/rts/storm/storm_log_stream.sh > /home/auto/msaha/rts/storm/logs/storm_log_stream.log 2>&1

ret_code=$?
printf "\nStatus of streaming job=$ret_code\n" > /home/auto/msaha/rts/storm/logs/process_flow_status.log
case ${ret_code} in
     0) printf "\nstreaming job successful storm_log_stream.sh\n" >> /home/auto/msaha/rts/storm/logs/process_flow_status.log;;
     *) printf "\nstreaming job Failed storm_log_stream.sh\n" >> /home/auto/msaha/rts/storm/logs/process_flow_status.log
     printf "\nRTS Storm Logs streaming job Failed storm_log_stream.sh\n with Return Code=${ret_code}"| mailx -s "API Log streaming job Failed" -a /home/auto/msaha/rts/storm/logs/storm_log_stream.log msaha$searshc.com
     exit 1 ;;
esac

/home/auto/msaha/rts/storm/load_storm_staging_table.sh > /home/auto/msaha/rts/storm/logs/load_storm_staging_table.log 2>&1

ret_code=$?
printf "\nStatus of Storm logs staging table create job=$ret_code\n" >> /home/auto/msaha/rts/storm/logs/process_flow_status.log
case ${ret_code} in
     0) printf "\nStorm logs staging table create job successful load_storm_staging_table.sh\n" >> /home/auto/msaha/rts/storm/logs/load_storm_staging_table.log;;
     *) printf "\nStorm logs staging table create job failed load_storm_staging_table.sh\n" >> /home/auto/msaha/rts/storm/logs/load_storm_staging_table.log
     printf "\nRTS Storm logs staging table create job failed load_storm_staging_table.sh\n with Return Code=${ret_code}"| mailx -s "API Log staging table create job Failed" -a /home/auto/msaha/rts/storm/logs/load_rts_api.log msaha$searshc.com
     exit 1 ;;
esac

/home/auto/msaha/rts/storm/insert_storm_log_partition.sh > /home/auto/msaha/rts/storm/logs/insert_storm_log_partition.log 2>&1

ret_code=$?
printf "\nStatus of Create log Table job=$ret_code\n" >> /home/auto/msaha/rts/storm/logs/process_flow_status.log
case ${ret_code} in
     0) printf "\nStatus of Create log Table job successful insert_storm_log_partition.sh\n" >> /home/auto/msaha/rts/storm/logs/insert_storm_log_partition.log;;
     *) printf "\nStatus of Create log Table failed insert_storm_log_partition.sh\n" >> /home/auto/msaha/rts/storm/logs/insert_storm_log_partition.log
     printf "\nRTS Storm Logs Create log Table failed insert_storm_log_partition.sh\n with Return Code=${ret_code}"| mailx -s "RTS Storm Logs Create log Table failed insert_storm_log_partition.sh" -a /home/auto/msaha/rts/storm/logs/insert_storm_log_partition.log msaha$searshc.com
     exit 1 ;;
esac

~
~
