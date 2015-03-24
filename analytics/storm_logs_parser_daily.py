#!/usr/bin/env python
#this script parses storm log files and creates pipe delilited storm log files
import sys
from datetime import date, timedelta, datetime
#from dateutil import parser

# input comes from STDIN (standard input)
for line in sys.stdin:
  try:
    head = ""
    headDate = ""
    lid = ""
    tailDate = ""
    modelId = ""
    oldScore = ""
    newScore = ""
    minExpiry= ""
    maxExpiry = ""
    source = ""

    if line is not None:
        fields = line.split(",")

        for field in fields:
            if "LoggingBolt" in field or "PERSIST:" in field:
                # head part
                strTokens = field.split("LoggingBolt")
                if len(strTokens) < 2:
                   # sys.stderr.write("Error in:" + line)
                    headDate = ""
                    boltStr = strTokens[0]
                else:
                    runDateStr = strTokens[0]

                    if runDateStr is not None:
                        headDate = runDateStr.rstrip(" a.b")
            		#current_headDateFormat = "%a %b %d %H:%M:%S %Z %Y"
                        #headDate_1 = datetime.datetime.strptime(headDate, current_headDateFormat);	
			#if datetime.strptime(headDate_1, '%Y-%m-%d %H:%M:%S') < datetime.combine((date.today()-timedelta(days=3)), datetime.min.time()):
			#  continue;
                    else:
                        headDate = ""

                    boltStr = strTokens[1]

                if boltStr is not None:
                    boltStrTokens = boltStr.split("lid:")

                    if len(boltStrTokens) < 2:
                       # sys.stderr.write("Error in:" + boltStr)
                        lid = ""
                    else:
                        lid = boltStrTokens[1].strip()

                    #[INFO] PERSIST: Mon Feb 16 23:37:28 EST 2015: Topology: Changes Scores :
                    boltDateStr = boltStrTokens[0]
                    tailDate_1 = boltDateStr.lstrip("[INFO] PERSIST").rstrip(": Topology: Changes Scores :")
                    ind1 = tailDate_1.find(":")
                    if ind1 >= 0 and len(boltDateStr) >= 1:
                        tailDate = tailDate_1[ind1+1:].strip()
                       # tailDate = parser.parse(tailDate);
                        #if ": source:" in field:
                        #    sourceTokens = field.split("source")
                        #    source_1 = sourceTokens[1]

            elif "modelId" in field:
                subFields = field.split(":")
                modelId = subFields[1].strip()
            elif "oldScore" in field:
                subFields = field.split(":")
                oldScore = subFields[1].strip()
            elif "newScore" in field:
                subFields = field.split(":")
                newScore = subFields[1].strip()
            elif "minExpiry" in field:
                subFields = field.split(":")
		if len(subFields) >= 2:
                	minExpiry = subFields[1].strip()
                	current_minExpiry_format = "%m/%d/%Y"
                	minExpiry = datetime.strptime(minExpiry, current_minExpiry_format)
		if len(subFields) >= 4 and subFields[2].strip().lower() == "source" :
			source = subFields[3].strip();
		if len(subFields) >= 6 and subFields[2].strip().lower() == "maxExpiry":
			maxExpiry=ubFields[3].strip()
                        current_maxExpiry_format = "%m/%d/%Y"
                        maxExpiry = datetime.strptime(maxExpiry, current_maxExpiry_format)
		if len(subFields) >= 6 and subFields[4].strip().lower() == "source":
			source = subFields[5].strip();
            elif "maxExpiry" in field:
		if len(subFields) >= 2:
                	subFields = field.split(":")
                	maxExpiry = subFields[1].strip()
                	current_maxExpiry_format = "%m/%d/%Y"
               		maxExpiry = datetime.strptime(maxExpiry, current_maxExpiry_format)
		if len(subFields) >= 4 and subFields[2].strip().lower() == "source" :
                        source = subFields[3].strip();
            elif "source" in field:
                subFields = field.split(":")
                source = subFields[1].strip()

    outputline = headDate + "|" + tailDate + "|" + lid + "|" + modelId + "|" + oldScore + "|" + newScore + "|" + str(minExpiry) + "|" + str(maxExpiry) + "|" + source
   # print('%s' % (line))
    print('%s' % (outputline))
  except:
    #do noting   
    continue;
	#raise;
    #print('%s' % ("error:"+line))  
