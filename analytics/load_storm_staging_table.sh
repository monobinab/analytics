#! /bin/bash
cd /home/auto/msaha/rts/storm
current_timestamp=`date +%Y-%m-%d'  '%H':'%M`
echo $current_timestamp
#current_month=Feb
current_month=`date +%b`
current_year=`date +%Y`

input_parentdir=/tmp/storm

sql_dir=/home/auto/msaha/rts/storm/
sql_file=load_storm_staging.sql

input_directory=${input_parentdir}/$current_month/$current_year
echo "data directory is : " ${input_directory}
#export ${input_directory}

hive -hiveconf input_directory=${input_directory} -f ${sql_dir}/${sql_file}
