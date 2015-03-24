use real_time_scoring;

add jar /home/auto/msaha/rts/api/final/joda-time-2.3.jar;
add jar /home/auto/msaha/rts/api/final/brickhouse-0.7.0.jar;

create temporary function json_map as 'brickhouse.udf.json.JsonMapUDF';
create temporary function json_split as 'brickhouse.udf.json.JsonSplitUDF';

SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;

ALTER TABLE api_response_log DROP IF EXISTS PARTITION(year = '${hiveconf:current_year}', month = '{hiveconf:current_month}', day = '{hiveconf:current_day}');
ALTER TABLE api_response_log DROP IF EXISTS PARTITION(year = '${hiveconf:current_year}', month = '{hiveconf:current_month}', day = '{hiveconf:yesterday}');

insert into table api_response_log
partition(Year, Month, Day)   
select
    t.run_date,
    trim(t.client),
    trim(COALESCE(t.lyl_id_no, v1.memberId, v1.memberId2)) as memberId,
    trim(t.encrypted_lyl_id_no),
    trim(COALESCE(v3.modelName, v3.modelName2)) as modelName, 
    trim(COALESCE(v3.rank, v3.rank2)) as rank, 
    trim(t.time_taken),
    trim(v1.status),
    trim(v1.statusCode),
    trim(v1.lastUpdated),
    --COALESCE(v1.scoresInfo, v1.rankedModels) as scoreJson
    trim(v3.modelId), 
    trim(v3.category), trim(v3.tag), trim(v3.tagId), trim(v3.score), trim(v3.totalScore), trim(v3.percentile), trim(v3.scorePercentile), 
    trim(v3.index),
    trim(v3.mdTag),
    trim(v3.occasion),
    trim(v3.subBusinessUnit),
    trim(v3.businessUnit),
    trim(v3.scoreDate),
    year(to_date(run_date)) as year,
    month(to_date(run_date)) as month,
    day(to_date(run_date)) as day
from rts_api_response_log_staging t
lateral view json_tuple(api_response, 'status', 'statusCode', 'memberId', 'MemberId', 'lastUpdated', 'scoresInfo', 'Ranked Models') v1 as status, statusCode, memberId, memberId2, lastUpdated, scoresInfo, rankedModels
    lateral view explode(json_split(COALESCE(v1.scoresInfo, v1.rankedModels))) v2 as scoreInfo
        lateral view json_tuple(v2.scoreInfo, 'modelId',  'ModelName', 'modelName', 'category', 'tag', 'tagId', 'score', 'totalScore', 'percentile', 'scorePercentile', 'Rank', 'rank', 'index', 'mdTag', 'occassion', 'subBusinessUnit', 'businessUnit', 'scoreDate') v3  as modelId, modelName, modelName2, category, tag, tagId, score, totalScore, percentile, scorePercentile, rank, rank2, index, mdTag, occasion, subBusinessUnit, businessUnit, scoreDate 
where
unix_timestamp(run_date) >= unix_timestamp(from_unixtime(unix_timestamp() -1*60*60*24, 'yyyy-MM-dd'), 'yyyy-MM-dd')
and unix_timestamp(run_date) < unix_timestamp(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 'yyyy-MM-dd')
;

