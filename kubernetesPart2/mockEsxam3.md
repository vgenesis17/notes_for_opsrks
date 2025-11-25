```bash
Solution
Use sysctl to adjust system parameters and make sure they persist across reboots.
To set the required sysctl parameters and make them persistent:

echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
echo 'net.bridge.bridge-nf-call-iptables = 1' >> /etc/sysctl.conf
sysctl -p

To verify:

sysctl net.ipv4.ip_forward
sysctl net.bridge.bridge-nf-call-iptables

```

```bash
Solution manifest file to create a network policy ingress-to-nptest as follows:

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-to-nptest
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: np-test-1
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - protocol: TCP
      port: 80
```


```bash
Use kubectl describe and check the PVC and PV details to identify the issue.
Inspect both resources:
kubectl describe pv app-pv
kubectl describe pvc app-pvc -n storage-ns

Note that there is accessModes mismatch between PV and PVC objects. Flush the PVC in a yaml file to be able to update it:
kubectl get pvc app-pvc -n storage-ns -o yaml > pvc.yaml

Update the access mode on pvc.yaml:
# vi pvc.yaml

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-pvc
  namespace: storage-ns
spec:
  accessModes:
    - ReadWriteOnce        # fix access mode to match PV object
  resources:
    ...

Delete and re-create the pvc object
kubectl delete pvc -n storage-ns app-pvc
kubectl apply -f pvc.yaml

Verify the status of the PVC is showing as Bound:
kubectl get pvc app-pvc -n storage-ns

```



```bash
Verify host and port for kube-apiserver are correct.

Open the super.kubeconfig in vi editor.

Change the 9999 port to 6443 and run the below command to verify:

kubectl cluster-info --kubeconfig=/root/CKA/super.kube


```


```bash
Use the command kubectl scale to increase the replica count to 3.

kubectl scale deploy nginx-deploy --replicas=3

The controller-manager is responsible for scaling up pods of a replicaset. If you inspect the control plane components in the kube-system namespace, you will see that the controller-manager is not running.

kubectl get pods -n kube-system

The command running inside the controller-manager pod is incorrect.
After fix all the values in the file and wait for controller-manager pod to restart.

Alternatively, you can run sed command to change all values at once:

sed -i 's/kube-contro1ler-manager/kube-controller-manager/g' /etc/kubernetes/manifests/kube-controller-manager.yaml

This will fix the issues in controller-manager yaml file.

At last, inspect the deployment by using below command, you should see 3/3 under READY if the fix above was properly performed. Example:

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   3/3     3            3           6m2s

```


```bash
Under /root/ folder you will find a yaml file api-hpa.yaml. Update the yaml file as per task given.

apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-hpa
  namespace: api
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api-deployment
  minReplicas: 1
  maxReplicas: 20
  metrics:
  - type: Pods
    pods:
      metric:
        name: requests_per_second
      target:
        type: AverageValue
        averageValue: "1000"

Use below command

kubectl create -f api-hpa.yaml





```


```bash
Copy the below YAML file to the terminal and create a HTTP Route.

kubectl create -n default -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: web-route
  namespace: default
spec:
  parentRefs:
    - name: web-gateway
      namespace: default
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: web-service
          port: 80
          weight: 80
        - name: web-service-v2
          port: 80
          weight: 20
EOF

```



```bash
Solution
In this task, we will use the helm commands. Here are the steps:



Use the helm ls command to list the Helm releases in the default namespace.
helm ls -n default



Validate the Helm chart using the helm lint command:
cd /root/
helm lint ./new-version



Install the new version of the application as a new release named webpage-server-02:
helm install webpage-server-02 ./new-version



Uninstall the old release webpage-server-01 using the following command:
helm uninstall webpage-server-01 -n default



```



```bash

Solution
To identify the cluster-wide Pod subnet, inspect the kubeadm-config ConfigMap, which contains the ClusterConfiguration used during kubeadm init:

kubectl -n kube-system get configmap kubeadm-config -o yaml | grep podSubnet
# podSubnet: 172.17.0.0/16

Save just the CIDR value to /root/pod-cidr.txt:

kubectl -n kube-system get configmap kubeadm-config -o yaml \
  | awk '/podSubnet:/{print $2}' > /root/pod-cidr.txt

Verify:

cat /root/pod-cidr.txt
# 172.17.0.0/16

Note:

Be careful not to confuse Cluster PodCIDR vs Node PodCIDR:

Cluster = Entire pool
Cluster PodCIDR (big range: 172.17.0.0/16)
Find it with : kubectl get cm kubeadm-config -n kube-system -o yaml

Node = Single slice
Node PodCIDR (small slice: 172.17.0.0/24)
Find it with :  kubectl get node <name> -o jsonpath='{.spec.podCIDR}'


```