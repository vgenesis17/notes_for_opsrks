info
We are building an API for an ecommerce application in Python using the Flask library. Take a look at the /root/main.py file to see the base configuration. There are a total of 4 endpoints.


    GET /products
    POST /products

    GET /cart
    POST /cart




You might see some PLACEHOLDERS in this file which you can ignore for now.


2. 
To instrument this application, we will make use of the prometheus-client python library. Install the same by running the following command on prometheus-server:


pip install prometheus-client

3. 


Update the /root/main.py file to replace the Question 3: PLACEHOLDER section with a Counter metric called http_requests_total. Find more details below:


   (a) First, import the Counter object from the prometheus-client library


from prometheus_client import Counter

   (b) Create a Counter object and name it REQUESTS


         (i) Metric name should be: http_requests_total


         (ii) Description should be: Total number of requests


REQUESTS = Counter('http_requests_total',
                   'Total number of requests')


Edit /root/main.py file:


vi /root/main.py




Update from prometheus_client line to import Counter:

```py
from prometheus_client import Counter
```



Replace Question 3: PLACEHOLDER section with below lines:

```py
REQUESTS = Counter('http_requests_total',
                   'Total number of requests')
```
-------------------------------------------------------------
Update the /root/main.py file to replace the Question 5: PLACEHOLDER section with the required code block to expose the metrics on an endpoint using the start_http_server object from the prometheus_client library. Find more details below:


    (a) Import the start_http_server object from the prometheus_client library.


from prometheus_client import Counter, start_http_server




    (b) Start the http server and make sure it listens on port 8000.


start_http_server(8000)



Edit /root/main.py file:


vi /root/main.py




Update from prometheus_client import Counter line to import start_http_server:


from prometheus_client import Counter, start_http_server




Now, replace Question 5: PLACEHOLDER section with below line:


start_http_server(8000)
!['1'](<Screenshot 2025-09-05 at 5.57.26 PM.png>)

![alt text](<Screenshot 2025-09-05 at 5.57.40 PM.png>)

![alt text](<Screenshot 2025-09-05 at 5.57.48 PM.png>)

```py
"""
Question 10: Create error counter (ERRORS) with 'code' label
"""

"""
Question 13: Create IN_PROGRESS gauge to track active requests
"""
start_http_server(8000)
def before_request():
    """
    Question 13: Increment the IN_PROGRESS gauge here.
    """
def get_products():
    """
    Question 4: Increment the REQUESTS metric here
    """
    REQUESTS.labels('products', 'get').inc()
    return "product"


@app.post("/products")
def create_product():
    REQUESTS.labels('products', 'post').inc()
    return "created product", 201


@app.get("/cart")
def get_cart():
    REQUESTS.labels('cart', 'get').inc()
    return "cart"


@app.post("/cart")
def create_cart():
    REQUESTS.labels('cart', 'post').inc()
    return "created cart", 201

@app.errorhandler(404)
def page_not_found(e):
    """
    Question 10: Increment the ERRORS counter here.
    """
    return "page not found", 404


if __name__ == '__main__':
    app.run(debug=False, host="0.0.0.0", port='6000')

                        
```


Configure a new job named api to scrape our Flask application and restart the Prometheus .


Edit the /etc/prometheus/prometheus.yml file:

```bash
vi  /etc/prometheus/prometheus.yml
```



Add below lines under scrape_configs:

```yaml
  - job_name: "api"
    static_configs:
      - targets: ["localhost:8000"]
```




Update the /root/main.py file to replace the Question 10: PLACEHOLDER[1-2] sections with the code blocks to create a metric to track the number of 404 errors. Use the steps below to complete this task.


   (a) Create a new metric called http_errors_total with the description Total number of errors.

   (b) Add a label called code to this metric.

   (c) Variable name should be ERRORS.


ERRORS = Counter('http_errors_total',
                 'Total number of errors', labelnames=['code'])




   (d) In the function called page_not_found increment, the ERRORS metric and pass in the code label value as 404.


@app.errorhandler(404)
def page_not_found(e):
    ERRORS.labels('404').inc()
    return "page not found", 404




     (e) Run the flask.sh command to restart the app.



Note:

The flask.sh script is located at: /usr/local/bin/flask.sh.
Run the command flask.sh in the terminal to restart the app.





### Adding error counter

ERRORS = Counter('http_errors_total',
                 'Total number of errors', labelnames=['code'])


@app.errorhandler(404)
def page_not_found(e):
    """
    Question 10: Increment the ERRORS counter here.
    """
    ERRORS.labels('404').inc()
    return "page not found", 404






Update the /root/main.py file to replace the Question 13: PLACEHOLDER[1-3] sections with the code blocks to create a new Gauge metric to track the number of active requests being processed. Find below more details:


(a) Import the Gauge object from prometheus_client library.


from prometheus_client import Counter, start_http_server, Gauge




(b) Create a new metric called inprogress_requests with a description Total number of requests in progress and store it in a variable called IN_PROGRESS


(c) To calculate the in_progress request count in the app, before every request we’ll increment the metric, then send a response for a request, and finally, we’ll decrement the metric.


(d) Both actions can be done in the before_request and after_request functions.


(e) Call the .inc() method in the before_request function and call the .dec() method in the after_request function.


IN_PROGRESS = Gauge('inprogress_requests',
                    'Total number of requests in progress')

def before_request():
    IN_PROGRESS.inc()

def after_request(response):
    IN_PROGRESS.dec()
    return response




     (f) Run the flask.sh command to restart the app.



Note:

The flask.sh script is located at: /usr/local/bin/flask.sh.
Run the command flask.sh in the terminal to restart the app.
Update the /root/main.py file to replace the Question 13: PLACEHOLDER[1-3] sections with the code blocks to create a new Gauge metric to track the number of active requests being processed. Find below more details:


(a) Import the Gauge object from prometheus_client library.


from prometheus_client import Counter, start_http_server, Gauge




(b) Create a new metric called inprogress_requests with a description Total number of requests in progress and store it in a variable called IN_PROGRESS


(c) To calculate the in_progress request count in the app, before every request we’ll increment the metric, then send a response for a request, and finally, we’ll decrement the metric.


(d) Both actions can be done in the before_request and after_request functions.


(e) Call the .inc() method in the before_request function and call the .dec() method in the after_request function.


IN_PROGRESS = Gauge('inprogress_requests',
                    'Total number of requests in progress')

def before_request():
    IN_PROGRESS.inc()

def after_request(response):
    IN_PROGRESS.dec()
    return response




     (f) Run the flask.sh command to restart the app.



Note:

The flask.sh script is located at: /usr/local/bin/flask.sh.
Run the command flask.sh in the terminal to restart the app.