rmf /tmp/api_response_log
REGISTER /home/auto/msaha/rts/api/final/udf.jar;
register /home/auto/msaha/rts/api/final/encryption.jar
define BASE64Encryption com.shc.pig.udf.BASE64Encryption();

A = LOAD '/tmp/{$current_month}/{$current_year}'
USING PigStorage('|') AS (
run_date
,api_response
,memberId
,client
,time_taken
)
;

B = FOREACH A GENERATE 
run_date
,api_response
,memberId
,BASE64Encryption(memberId)         
,client      
,time_taken
;

store B into '/tmp/api_response_log' USING PigStorage('|');
