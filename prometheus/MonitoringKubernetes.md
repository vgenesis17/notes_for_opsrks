## 1
Install helm on controlplane node.

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
## 2

We would like to use Prometheus to monitor our Kubernetes cluster as well as the applications that are deployed in this cluster, we want to deploy the Prometheus server on this cluster using the prometheus-community/kube-prometheus-stack helm chart. Remember to name it as prometheus.


Click on PrometheusHelmChart button to get some more details about this chart.
Note: Due to a known bug you might need to patch the Prometheus node exporter DaemonSet using below command.

kubectl patch ds prometheus-prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]'





```bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack
kubectl get ds
kubectl patch ds prometheus-prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]'
```



### 3
k get statefulsets


k get svc

## 10

The prometheus instance is using a ClusterIP service called prometheus-kube-prometheus-prometheus, which means it is only accessible within the cluster, and we can’t access the UI by default.


Update prometheus-kube-prometheus-prometheus service to change it to NodePort service, also make sure to use node port 30111. Once done, you should be able to access the Prometheus UI using Prometheus button on the top bar.
```bash
kubectl edit svc prometheus-kube-prometheus-prometheus
```
Make some changes in this service. Change type: ClusterIP to type: NodePort and add nodePort: 30111 under - name: http-web. Finally save the changes.


### 11

Now, configure an ingress to forward traffic to the prometheus service. We already have a template file /root/ingress.yaml with the ingress configuration.
Using this configuration, an ingress called prom-ingress will be created, and there is one routing rule where the host field will match any traffic destined to prometheus.kk-demo.com URL and will forward it to prometheus-kube-prometheus-prometheus service in the backend.


Once done, you should be able to test it using below command:
```bash
curl prometheus.kk-demo.com
```
The output should be something like:
```bash
<a href="/query">Found</a>.


```

To deploy /root/ingress.yaml template, run the below command:
```bash
kubectl apply -f /root/ingress.yaml
```

### check targets

### 12

Let’s now deploy an application to the Kubernetes cluster. There is an API built with NodeJS that listens on port 3000. It already has an instrumentation setup and the metrics can be accessed at /swagger-stats/metrics. It has two endpoints /recipes, and /ingredients.


Use /root/api-deploy.yaml file to deploy this API in our Kubernetes cluster.
Note: Wait for the PODs to be in a running state before submitting the question.
To deploy the /root/api-deploy.yaml template, run below command:
```bash
kubectl apply -f /root/api-deploy.yaml
```


### 14

Since API is already deployed, let’s deploy a service to provide reachability to the API. There is a file called /root/api-service.yaml that has a service configuration. Deploy the API service using this definition file.

To deploy /root/api-service.yaml template, run below command:
```bash
kubectl apply -f /root/api-service.yaml
```

### 15
Let’s update prom-ingress ingress to setup a rule to route any traffic to the host api.kk-demo.com to the API service.

Edit prom-ingress ingress:
```bash
kubectl edit ingress prom-ingress
```
Under rules: add the below rule in it and save:
```yaml
  - host: api.kk-demo.com
    http:
      paths:
      - backend:
          service:
            name: api-service
            port:
              number: 3000
        path: /
        pathType: Prefix
```


### 16

Next

16 / 23
Now that the API is installed, we need to configure Prometheus to scrape the API pods. Instead of manually going into the prometheus configs and adding another scrape config, with the prometheus operator, we can declaratively define all the endpoints prometheus should scrape by creating a ServiceMonitor. Prometheus will automatically pickup all targets to scrape from the defined ServiceMonitors.
ServiceMonitors are a Custom Resource Definition provided by the Prometheus Operator.

Run a kubectl get crd to see all of the CRDs provided by the Prometheus Operator.
If you would like to take a look at all of the ServiceMonitors that have been deployed, run kubectl get serviceMonitor. You can see a separate ServiceMonitor for each of the targets prometheus has already been configured to scrape.


There’s an api-servicemonitor.yaml file with the base configuration for a ServiceMonitor, it has some PLACEHOLDER which needs to be updated before you apply this template. Let’s look at what's configured there and what you should update.
a. kind is set to ServiceMonitor.
b. selector.matchLabels - This is a selector label to tell prometheus which service to scrape. We will need to match the label of our api-service.
c. spec.endpoints - has scrape configurations for prometheus.
        1. interval - This is equivalent to scrape_interval.
        2. port - This is going to reference the name of the specific port in our service.
        3. path - This is the specific path that will expose metrics in the container, equivalent to metrics_path config.
Once the template is updated, let's deploy the same.


Modify the template /root/api-servicemonitor.yaml as below:
```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: api-service-monitor
  labels:
    app: prometheus
    release: prometheus
spec:
  jobLabel: job
  endpoints:
    - interval: 30s
      port: web
      path: /swagger-stats/metrics
  selector:
    matchLabels:
      app: api
Save and apply the template:
```
```bash
kubectl apply -f api-servicemonitor.yaml 
```

###18

18 / 23
To add recording-rules and alerts, once again we will not have to touch the prometheus configuration. The prometheus operator comes with another Custom Resource Definition to add rules.
Run kubectl get crd and you should see prometheusrules.monitoring.coreos.com. To create rules, we will define a new prometheus rules object. You can take a look at all of the pre-existing rules by running kubectl get prometheusrules.monitoring.coreos.com command.
There is a /root/rules.yaml with a base configuration to get a simple rule configured. Let’s walkthrough it.
a. kind - Set to PrometheusRule.
b. name - Name of this specific PrometheusRule object.
c. spec - It will contain regular prometheus rule/alert configuration.
Inspect the /root/rules.yaml file and under the spec, we can see a group named node-example being defined and there’s one rule named node_filesystem_free_percent.
The rule configurations are identical to how they are configured in a prometheus.yml file, just place all your groups/rules under the spec portion of the configuration.


Update the PLACEHOLDER under rules: in this template to add a new alert for the node group with the following configs:
a. Alert name should be HostOutOfMemory.
b. Expression should be node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100 < 10
c. Labels should be as below:
      1. team: infra
      2. severity: warning
Note: You do not need to apply this template yet.

Modify the rules in /root/rules.yaml template as below and save:
```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  labels:
    #PLACEHOLDER: Add label here
  name: example-rules
spec:
  groups:
    - name: node-example
      rules:
        - record: node_filesystem_free_percent
          expr: 100* node_filesystem_free_bytes / node_filesystem_size_bytes
        - alert: HostOutOfMemory
          expr: node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100 < 10
          labels:
            team: infra
            severity: warning
```
prometheus looks for: 
release: prometheus


### 20


So, as you found in the previous question that Prometheus will look for a label release: prometheus to discover new rules. Update the PLACEHOLDER under labels: in /root/rules.yaml template file and apply the same.


Modify the /root/rules.yaml template as below:
```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  labels:
    release: prometheus
  name: example-rules
spec:
  groups:
    - name: node-example
      rules:
        - record: node_filesystem_free_percent
          expr: 100* node_filesystem_free_bytes / node_filesystem_size_bytes
        - alert: HostOutOfMemory
          expr: node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100 < 10
          labels:
            team: infra
            severity: warning
```
Save and apply the template.
```bash
kubectl apply -f /root/rules.yaml `\
```


### 22

Next

22 / 23
Let’s now create a new alertmanager rule. The prometheus Operator has an AlertmanagerConfig CRD that is used for adding rules to alertmanager.


The file /root/alertmanager-rule.yaml has a base configuration for applying a new rule. Let’s walkthrough it:
1. kind - AlertmanagerConfig
2. metadata.name - Name of the object.
3. metadata.labels - Labels associated with this object.
4. spec - This is where the standard alertmanager configs are going to be defined.
Currently there is a default route configuration and a single receiver called webhook. Add a route and a receiver in this template:
Route:

    routes:
      - matchers:
          - name: team
            value: infra
        receiver: "infra"
        groupBy: ["severity"]

Receiver:

    - name: "infra"
      webhookConfigs:
        - url: "http://infra.com/"

Finally apply the same.

Modify the template /root/alertmanager-rule.yaml as below:
```yaml
apiVersion: monitoring.coreos.com/v1alpha1
kind: AlertmanagerConfig
metadata:
  name: alert-config
  labels:
    release: prometheus
spec:
  route:
    groupBy: ["alertname"]
    groupWait: 30s
    groupInterval: 5m
    repeatInterval: 12h
    receiver: "webhook"
    routes:
      - matchers:
          - name: team
            value: infra
        receiver: "infra"
        groupBy: ["severity"]
  receivers:
    - name: "webhook"
      webhookConfigs:
        - url: "http://example.com/"

    - name: "infra"
      webhookConfigs:
        - url: "http://infra.com/"
```
Save and apply the template:
```bash
kubectl apply -f /root/alertmanager-rule.yaml
```


### 23
Let’s set up and access the alert manager UI now.
Let’s update prom-ingress ingress to setup a rule to route traffic destined to alertmanager.kk-demo.com to the alert manager service. The service name is prometheus-kube-prometheus-alertmanager and the port number is 9093.
Edit prom-ingress ingress:

kubectl edit ingress prom-ingress
Under rules: add the below rule in it and save:
```yaml
  - host: alertmanager.kk-demo.com
    http:
      paths:
      - backend:
          service:
            name: prometheus-kube-prometheus-alertmanager
            port:
              number: 9093
        path: /
        pathType: Prefix
```