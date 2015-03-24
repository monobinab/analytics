#! /bin/bash
rm -f /staging/msaha/liquidity_offer_1.txt
impala-shell -f /home/auto/msaha/rts/reports/liquidity.sql -B --output_delimiter='\t' -o /staging/msaha/liquidity_offer_1.txt
