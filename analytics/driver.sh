#! /bin/bash
/home/auto/msaha/rts/api/final/step1.sh > /home/auto/msaha/rts/api/final/logs/step1.log 2>&1
/home/auto/msaha/rts/api/final/encrypt_id.sh > /home/auto/msaha/rts/api/final/logs/pig_encrypt_id.log 2>&1
/home/auto/msaha/rts/api/final/step2.sh > /home/auto/msaha/rts/api/final/logs/step2.log 2>&1
/home/auto/msaha/rts/api/final/step3.sh > /home/auto/msaha/rts/api/final/logs/step3.log 2>&1
exit 0
