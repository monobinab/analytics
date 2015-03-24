#! /bin/bash
cd /home/auto/msaha/rts/storm
current_timestamp=`date +%Y-%m-%d'  '%H':'%M`
echo $current_timestamp
#current_month=Feb
current_month=`date +%b`
current_year=`date +%Y`

run_directory=/home/auto/msaha/rts/storm
input_parentdir=/incoming/rts/flume
input_directory=${input_parentdir}/$current_month/$current_year
#input_directory=/smith/rts/storm/incoming
#input_directory=${input_parentdir}/Jan/2015

out_parentdir=/tmp/storm

out_directory=${out_parentdir}/$current_month/$current_year
#out_directory=${out_parentdir}/Jan/2015

hadoop fs -rm -r -skipTrash ${out_parentdir}/$current_month/$current_year
#hadoop fs -rm -r -skipTrash ${out_parentdir}/Jan/2015
echo "removed out directory" 

hadoop jar /opt/cloudera/parcels/CDH-5.1.2-1.cdh5.1.2.p470.103/lib/hadoop-mapreduce/hadoop-streaming-2.3.0-cdh5.1.2.jar \
-reducer NONE \
-file /home/auto/msaha/rts/storm/storm_logs_parser_daily.py -mapper /home/auto/msaha/rts/storm/storm_logs_parser_daily.py \
-input ${input_directory}/storm-.*[0-9] \
-output ${out_directory}
