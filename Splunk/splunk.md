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


Manage Job:

splunk can retain a job only in 10 mins.

stop can generate partial results

___

index=web sourcetype="access_combined" 
|  table _time _raw

----USing Fields in Searches 
Use qoutation  marks for fields with spaces

index=web fullName="Jean Claude"


wild cards :
index=web action acation=addtocart JSESSIONID = SD2*


CIDR match :
index=main sourcetype="eventgen" partner=telCO04 userIPAddress="192.168.143.0/24"


field names are case sensitive 



Boolean Operators

index sourcetype=access_combined (host=Webserv1 OR host=Webserver2) NOT action=remove

---
comparison Operators:
- to link key/value pair

=
!=
>
<
>=
<=

index=web sourcetype=access_combined (host=Webserv1 OR host=Webserver2) (status > 200 AND status < 500>)



-All events wher action field exists and value is diff from remove 

Will also include events where action does not exist

```json
index=web sourcetype=access_combined NOT action = remove
```


All events where action field exists and value is different from remove
Exclludes where action field does not exist.




Run the query “index=web sourcetype=access_combined” for last All time.
• Retrieve only events from Webserv1 and Webserv2.

index=web sourcetype=access_combined (host=Webserv1 OR host=Webserver2) 

• Events having number of bytes greater than or equal to 3000.

index=web sourcetype=access_combined (host=Webserv1 OR host=Webserver2)  bytes >= 3000

• Exclude events with action field value of remove.


index=web sourcetype=access_combined (host=Webserv1 OR host=Webserver2)  bytes >= 3000 action !=remove

• Events with status greater then 200 and less than 500.

index=web sourcetype=access_combined (host=Webserv1 OR host=Webserver2)  bytes >= 3000 action !=remove (status>200 AND status<500)


• Get the count of events where action field value is different from remove, using NOT Boolean operator.

index=web sourcetype=access_combined (host=Webserv1 OR host=Webserver2)  bytes >= 3000 NOT action=remove

• Get count of events where action field value is different from remove using != relational operator. (does not include events with no action field)

index=web sourcetype=access_combined (host=Webserv1 OR host=Webserver2)  bytes >= 3000 action !=remove


---
Search Modes
Fast MODE:
fields discovery disabled

Smart mode: 
fields discovery enabled

Verbose Mode:
Completeness

• Run the query “index=main sourcetype=eventgen” for last 24 hrs.

index=main sourcetype=eventgen

• Check fields sidebar for each mode to confirm field discovery is disabled in fast mode but 
enabled in smart and verbose mode.


• Inspect the search to confirm fast mode is the most performant and verbose least 
performant.

• Add the transforming command | stats count.
✓Check that there’s no event list for fast and smart modes

index=main sourcetype=eventgen | stats count


BEST PRACTICE :


Specify indexes at the beginning of the search string 

Can search without indexes but ut's more efficient when you specify them 

index=main
index=web OR index=security


Avoid using wildcards the beginning or in the middle of the search string 

always at the last
use inclusion than exclusion Inclusion: action=addtocart


Specify time to narrow down the results 
Search term as specific as possible
USe filters as early as possibe in your search

-----

## Search language funadmentals

Apply Search Terms to retrieve data from the index

Keywords, phrases, wildcards, Booleans, Etc.
search with field/value pairs

Apply command to events retrieve by th search terms:
Commands 
Spcefies what to do with the results retrieved 

fucntion jhow to perform 

Argumaents provide the variables needed for the function to work

Clouses Grouo or rename fields in your results

Apply Searc Terms 
index=main sorucetype=eventgen | eval callResults= if (responceCode==200, "Success", "Failure") | stats count BY callResult | rename callResult As finalResult

Clause BY callresult
AS results 


---

## Search Pipeline Readability - Preferences
preference > Genral Lin numbers and search auto format 

syntax coloring
ORange : command modifier 

green argumens 
commands in blue




• Run the query “index=main sourcetype=eventgen (nodeName=host01 OR 
nodeName=host02) NOT partner=Telco07” for last 60 mins.
• Change the search bar theme from default to light, Dark, Black on White and check the 
behavior.
• Activate search auto-format and then add | eval to the search. Notice that the pipe (|) 
moves to the next line.
• Activate line numbers and remove and add | eval again. Notice pipe(|) moves to next 
line but a line number is also added.
• Complete the search as below and verify the syntax coloring:
index=main sourcetype=eventgen (nodeName=host01 OR nodeName=host02) NOT 
partner=Telco07| eval CallResult=if(responseCode==200, "Success", "Failure")| top 
limit=0 CallResult| rename CallResult AS finalResul


---
### field commands 
internal fields _raw and -time are returened by default.
To inclde fileds:
USe fields (or fields +) - default behavior
Only the specified fields are extracted
Performance improvement on field extraction


Remove 4 fields from the results: action, clientip, actegoryId, JSESSIONID

USe fields-
Happens after fields extractions
No performace improvement

index=web soourcetype="access_combined" | fields action, clientip, categoryId, JSESSIONID

``` ``` comment out 

From web index and sourcetype access_combined:
✓Return only fields action, clientip, categoryId, JSESSIONID for all time.

index=web soourcetype="access_combined" | fields action, clientip, categoryId, JSESSIONID

✓Use the job inspector to check duration of the search query.

✓Run same search without the fields command. Check the duration and compare with 
the previous search.
index=web soourcetype="access_combined" ``` | fields action, clientip, categoryId, JSESSIONID ```
✓Remove fields action, clientip, categoryId, JSESSIONID for all time
index=web soourcetype="access_combined"  | fields - action, clientip, categoryId, JSESSIONID 

### table and rename commands 
Creates a statistics table of the specified fields 
```bash
index=web soourcetype="access_combined" | table JSESSIONID, clientip, useragent, referer, bytes | rename  JSESSIONID as sessioID, clientip as "User IP Address"
```
From web index and sourcetype access_combined:
• Return a stats table of JSESSIONID, clientip, useragent, referer, bytes fields.
index=web soourcetype="access_combined" | table JSESSIONID, clientip, useragent, referer, bytes 

• Examine the table and order of field names.
• Rename the fields in the table:
✓ JSESSIONID to sessionID, clientip to “User IP Address”
```bash
index=web soourcetype="access_combined" | table JSESSIONID, clientip, useragent, referer, bytes | rename  JSESSIONID as sessioID, clientip as "User IP Address"
```
### Sort command 
From the previous example:
• Sort the table in ascending order of User IP Address. Limit to 10 results.
```bash
index=web soourcetype="access_combined" | table JSESSIONID, clientip, useragent, referer, bytes | rename  JSESSIONID as sessioID, clientip as "User IP Address" | sort limit=10 "User IP Address"
```

• Sort the table in descending order of bytes. Limit to 20 results.
```bash
index=web soourcetype="access_combined" | table JSESSIONID, clientip, useragent, referer, bytes | rename  JSESSIONID as sessioID, clientip as "User IP Address" | sort -bytes limit=20 
```
• Sort the table in descending order by User IP Address, then by bytes
```bash
index=web soourcetype="access_combined" | table JSESSIONID, clientip, useragent, referer, bytes | rename  JSESSIONID as sessioID, clientip as "User IP Address" | sort - "User IP Address", bytes 
```

• Count the total number of events in eventgen sourcetype in last 24hrs.
• Rename the count as “Total Events”:
✓ Group by nodeName field.
✓ Group by nodeName and partner fields.

deduplication remove duplicates


From the previous example:
• Use dedup command to remove duplicate User IP Addresses.
```bash
index=web soourcetype="access_combined" | table JSESSIONID, clientip, useragent, referer, bytes | rename  JSESSIONID as sessioID, clientip as "User IP Address" | sort - "User IP Address" | dedup "User IP Address"
```

• Check results to confirm User IP Addresses are now unique.
• Use the dedup command to remove duplicate combinations of User IP Address and status.
• Check results to confirm unique combinations of User IP Address and status


### Transforming commands 
used to order search results into statistical table
```bash
index=web soourcetype="access_combined" | stats count by clientip

```
```bash
index=web sourcetype="access_combined" | stats count(eval(responseCode==480)) as "Events with 480 Error"
```
visusalization tab

count 
Counts the number of events
USe count() to count the number of events matching the argument

distict_count,dc-count the number fir a specifieds

stats function 

sum, avg , values (list all unique field)

list all values of the given field

grou by  npdeName 


• Count the total number of events in eventgen sourcetype in last 24hrs.
• Rename the count as “Total Events”:
```bash
index=web soourcetype="access_combined" | stats count | rename count  as "Total events"
```

✓ Group by nodeName field.
```bash
index=web soourcetype="access_combined" | stats count as "Total evens" by nodeName
```

✓ Group by nodeName and partner fields.
```bash
index=web soourcetype="access_combined" | stats count as "Total events" by nodeName, partner
```

• Count the number of events containing the zipCode field and name as “Events with ZipCode”

index=web soourcetype="access_combined" | stats count(ZipCode) as “Events with ZipCode” 


###  stats Command - distinct_Count(dc) Fucntion

to get the count of the unque values for a given field