#! /bin/bash

cd /home/auto/msaha/rts/api/final;
current_timestamp=`date +%Y-%m-%d'  '%H':'%M`
echo $current_timestamp
current_month=`date +%b`
current_year=`date +%Y`

script_dir=/home/auto/msaha/rts/api/final
script_file=encrypt_loyalty_id.pig


pig -param current_year=${current_year} -param current_month=${current_month} -f ${script_dir}/${script_file} 
ret_code=$?
case ${ret_code} in
     0) printf "\nAPI Member id encrypt job successful \n" >> /home/auto/msaha/rts/api/final/logs/load_api.log;;
     *) printf "\nAPI Member id encrypt failed\n" >> /home/auto/msaha/rts/api/final/logs/load_api.log
     printf "\nAPI Member Id Encrypt job failed with Return Code=${ret_code}\n"| mailx -s "API Member Id Encrypt job Failed" -a /home/auto/msaha/rts/api/final/logs/pig_encrypt_id.log msaha$searshc.com
     exit 1 ;;
esac
