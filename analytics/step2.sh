#! /bin/bash
cd /home/auto/msaha/rts/api/final;

#input_parentdir=/smith/rts/pig
input_parentdir=/tmp
sql_dir=/home/auto/msaha/rts/api/final
sql_file=step2.sql

input_directory=${input_parentdir}/api_response_log

echo "data directory is : " ${input_directory}
#export ${input_directory}

hive -hiveconf input_directory=${input_directory} -f ${sql_dir}/${sql_file} 
ret_code=$?
case ${ret_code} in
     0) printf "\nAPI staging table load job successful \n" >> /home/auto/msaha/rts/api/final/logs/load_api.log;;
     *) printf "\nAPI staging table load job job failed\n" >> /home/auto/msaha/rts/api/final/logs/load_api.log
     printf "\nAPI staging table load job failed with Return Code=${ret_code}\n"| mailx -s "API staging table load job Failed" -a /home/auto/msaha/rts/api/final/logs/step2.log msaha$searshc.com
     exit 1 ;;
esac
exit 0

