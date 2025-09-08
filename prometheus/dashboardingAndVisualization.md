## 1.
Create a new console template called node-stats.html and add the standard header and footer templates.

Find more details below:



   (a) Console templates are located under /etc/prometheus/consoles/ directory.


   (b) Between the prom_content_head and prom_content_tail templates add an H1 tag with the text Node Stats to give this page a title.


   Create a file called /etc/prometheus/consoles/node-stats.html:


vi /etc/prometheus/consoles/node-stats.html



Add the standard header and footer templates as below:


{{template "head" .}}
{{template "prom_content_head" .}}
<h1>Node Stats</h1>
{{template "prom_content_tail" .}}
{{template "tail"}}

## 2. 

Update /etc/prometheus/consoles/node-stats.html template and add a section to include memory stats for the nodes. See below for additional details.



   (a) First, add an H3 header (under Node Stats) with the text Memory. This is where we will store all memory related stats

       <h3>Memory</h3>


   (b) Add a strong tag with the text Memory utilization: under Memory

      <strong>Memory utilization:</strong>


   (c) Next to the strong tag, add a prom_query_drilldown template to report the memory utilization of the nodes.

      The query for this is: 100- (node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes*100)


      Edit /etc/prometheus/consoles/node-stats.html file:


vi /etc/prometheus/consoles/node-stats.html



Update it so that it looks like as below:


{{template "head" .}}
{{template "prom_content_head" .}}
<h1>Node Stats</h1>
<h3>Memory</h3>
<strong>Memory utilization:</strong> {{template "prom_query_drilldown" (args
"100- (node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes*100)" "%") }}
{{template "prom_content_tail" .}}
{{template "tail"}}

## 3

Update /etc/prometheus/consoles/node-stats.html template and add a section to include memory stats for the nodes. See below for additional details.



   (a) First, add an H3 header (under Node Stats) with the text Memory. This is where we will store all memory related stats

       <h3>Memory</h3>


   (b) Add a strong tag with the text Memory utilization: under Memory

      <strong>Memory utilization:</strong>


   (c) Next to the strong tag, add a prom_query_drilldown template to report the memory utilization of the nodes.

      The query for this is: 100- (node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes*100)


