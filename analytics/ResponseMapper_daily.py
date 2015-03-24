#!/usr/bin/env python
# this script create requests
import sys
from datetime import date, timedelta, datetime
# from os.path import basename
# import csv

# input comes from STDIN (standard input)
for line in sys.stdin:
   try:	
	if "|" not in line:
	    #possibly old format
	    run_date="";
            responseJson="";
            timeTaken="";
            lyl_id_no="";
            client="";
	    strTokens = line.split("api:");
	    if len(strTokens) < 2:
        	#sys.stderr.write("Error in:" + line);
        	continue;

    	    dateStr = strTokens[0]
    	    if dateStr is not None:
            	dateStr_1 = dateStr.lstrip("PERSIST:") #.replace("2015:","2015|",1)
        	n = len(dateStr_1)
        	if dateStr_1 is not None and len(dateStr_1) >= 2:
            		dateStr_2 = dateStr_1[0:n-2]
        		current_format = " %a %b %d %H:%M:%S %Z %Y"
        		dateStr_3 = datetime.strptime(dateStr_2, current_format)
			if datetime.strptime(dateStr_3, '%Y-%m-%d %H:%M:%S') < datetime.combine((date.today()-timedelta(days=1)), datetime.min.time()):
			  continue;
        		run_date = str(dateStr_3)

    	    apiStr = strTokens[1];
    	    if apiStr is not None:
          	ind1 = apiStr.rfind(",");
        	if ind1 >= 0 and len(apiStr) >= 1:
            		apiStr1 = apiStr[0:ind1];
            		client = apiStr[ind1+1:];

            		if apiStr1 is not None:
                		ind2=apiStr1.rfind(",");
                		if ind2 >= 0 and len(apiStr1) >= 1:
                    			apiStr11 = apiStr1[0:ind2];
                    			lyl_id_no = apiStr1[ind2+1:];

           	if apiStr.strip().startswith('response: {"status":"success"'):
            	    if apiStr11 is not None:
                	apiResponseStr = apiStr11.split("time taken:");
                	if len(apiResponseStr) >= 2 and apiResponseStr[0] is not None:
                    		responseJson=apiResponseStr[0].strip().lstrip("response:").strip();
                    		timeTaken=apiResponseStr[1];

            	    outline = run_date.strip() + "|" + responseJson + "|" + lyl_id_no.strip() + "|" + client.strip()+ "|" + timeTaken.strip();
                    # write the results to STDOUT (standard output);
                    print '%s' % (outline);	

        #new format records
	else:
	     	dateStr_3="";
	     	apiStr="";

		if  'api: response | {"status":"success"' in line:
			strTokens = line.split(": api: response ");
			dateStr = strTokens[0];
			if dateStr is not None:
				dateStr_1 = dateStr.lstrip("PERSIST:").strip();
				current_format = "%a %b %d %H:%M:%S %Z %Y"
				dateStr_2 = datetime.strptime(dateStr_1, current_format) 
				dateStr_3 = str(dateStr_2)
				if datetime.strptime(dateStr_3, '%Y-%m-%d %H:%M:%S') < datetime.combine((date.today()-timedelta(days=1)), datetime.min.time()): 
				    #print 'skipped:'+line
				    continue;
			
			apiStr = strTokens[1];
					
	   		outline = dateStr_3.strip() + apiStr.strip()
			#newline_1 = dateStr_2.strip() + apiStr;
			#responsefile_new.write(line);
			print '%s' % (outline);
   except:
      	#sys.stderr.write('%s' % ("error:"+line))
      	#raise
	continue;
	
