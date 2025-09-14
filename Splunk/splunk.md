default port 8000

http://localhost:8000

Remote Instance: http://<instance_ip_addr>:8000


![alt text](<Screenshot 2025-09-12 at 7.59.19 PM.png>) ![alt text](<Screenshot 2025-09-12 at 7.59.36 PM.png>)



https://help.splunk.com/en/splunk-cloud-platform/get-started/search-tutorial/9.3.2411/part-4-searching-the-tutorial-data/use-the-search-language


setting up splunk:

on linux: 


-----

add events file to splunk>apps>
add event config to local
linux: /opt/splunk/apps/sa-event/local
add sample logs or files to 
/opt/splunk/apps/sa-event/samples
event generation:

index=main sourcetype="eventgen"  | eval callResult=if(responseCode==200, "Success", "Failure") | | eval failureCode=if(responseCode>=400, responseCode, null())

adding fields 

settings > fields > Calculate fieds > add name and Eval expression :(eval callResult=if(responseCode==200, "Success", "Failure")) > save

---

Use keywords and phrases to:
- Retrieve matched events from the index
- Only allows indexes searchable by the default


- Match is performed against raw events in the _raw field
- To search matching phrases, use double-woutes. e.g.,"user ubuntu"

settings > roles > admin > check the index you want to access


add "" for phrase 


---
Use wildcard (*) to match characters in string values for events in your index:

use at the end of the term only

Search word that starts with failed*


---

Use boolean expr
must be upper case
AND 

--And is implied between terms
failed password same as failed AND password are thesame

User not administrator
add parenthesis
(www1 OR www2) AND user

user NOT administrator 
- outputs user only 

USe Search Assistant 

enabled by default
-full
-compact

poer roles cannot change permission


--- Identify contents of the search

click the term and add to search

you can also add it into new search

--Custom time Range 

Time Range Picke - to specify the time range of your search:
- presets specify the exact time ranges to use 
- default tim epicker selection is last 24 hours

Custom time ranges 
Relative:

Real-time:

Date Range:

Date & Time Range 

Advance:
Earliest:
-4h@h        latest: now

Search string overwrites the time range picker value

Relative Time Ex:
earliest=-24h lates=now
earliest=-24 latest=now

Absolute Time:
Earliest =09/03/2023:00:00:00 lates=09/04/2023:00:00
s=second m=minutes h=hours d=days w=weeks mon=months y=years 


Use the @ symbol to snap to a specified unit
Snapping always rounds down to the nearest time unit specified 

IF the current time is 10:42:07-4h@h looks to 06:00:00
If current tim eis 15:38:12,-30m@h looks back to 15:00:00

--Event timeline
the green bar graph in the UI

