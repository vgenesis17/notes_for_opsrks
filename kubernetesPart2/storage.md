## DOCKER STORAGE 
File system



Configure a volume to store these logs at /var/log/webapp on the host.

Use the spec provided below.

Name: webapp
Image Name: kodekloud/event-simulator
Volume HostPath: /var/log/webapp
Volume Mount: /log



```yaml
- mountPath: /log
  name: logs-volumes

volumes:
-   name: logs-volumes
    hostPath:    
      path:  /var/log/webapp
      type: Directory
```


Create a Persistent Volume with the given specification.

Volume Name: pv-log
Storage: 100Mi
Access Modes: ReadWriteMany
Host Path: /pv/log
Reclaim Policy: Retain

```yaml

apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-log
spec:
  persistentVolumeReclaimPolicy: Retain
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 100Mi
  hostPath:
    path: /pv/log

```
Update the webapp pod to use the persistent volume claim as its storage.

Replace hostPath configured earlier with the newly created PersistentVolumeClaim.
``` yml
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  containers:
  - name: event-simulator
    image: kodekloud/event-simulator
    env:
    - name: LOG_HANDLERS
      value: file
    volumeMounts:
    - mountPath: /log
      name: log-volume

  volumes:
  - name: log-volume
    persistentVolumeClaim:
      claimName: claim-log-1
```
to bind just change pv's access mode:

ReadWriteMany


what happen to the pv if pvc is deleted?

: pv is not deleted but not available



deleting PVC will be stuck in terminating ehen used by the pod

when pod is deleted, pvc is deleted

pv status release 


## STORAGE CLASSES
pv is not needed


provider's volume like gcp
uses gce 

silver
gold 
platinum

k get sc 
What is the name of the Storage Class that does not support dynamic volume provisioning?
: Look for the storage class name that uses no-provisioner


Create a new Storage Class called delayed-volume-sc that makes use of the below specs:

provisioner: kubernetes.io/no-provisioner

volumeBindingMode: WaitForFirstConsumer


---
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: delayed-volume-sc
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```

### NETWORKING

    
![alt text](image-2.png)


![alt text](image-3.png)


![alt text](image-4.png)

CONTAINER NETWORK INTERFACE 


-programs = plugins


![alt text](image-6.png)




![CNI](image-7.png)


What is the network interface configured for cluster connectivity on the controlplane node?
node-to-node communication


```bash
k get node -o wide 


ip a | grep -B2 192.23.97.3
```


What is the MAC address assigned to node01?

```bash
ssh node01
```

```bash
ip link show eth0
```
If you were to ping google from the controlplane node, which route does it take?
What is the IP address of the Default Gateway?

```bash
ip route show default 
```


What is the port the kube-scheduler is listening on in the controlplane node?
```bash
netstat -ntlup
```

what port has many client connection

netstat -anp | grep 2379 | wc -l

NETWORK MODEL:
![alt text](<Screenshot 2025-08-11 at 6.14.45 PM.png>)




![alt text](<Screenshot 2025-08-11 at 6.14.45 PM-1.png>)


connecting nodes

![alt text](<Screenshot 2025-08-11 at 6.14.45 PM-2.png>)

![alt text](<Screenshot 2025-08-11 at 6.14.45 PM-3.png>)

pod network 
![alt text](<Screenshot 2025-08-11 at 6.14.45 PM-4.png>)

CNI 
![CNI](<Screenshot 2025-08-11 at 6.14.45 PM-5.png>)

![CNI CONFIG](<Screenshot 2025-08-11 at 6.14.45 PM-6.png>)

CNI STANDARD 

![standard](<Screenshot 2025-08-11 at 6.14.45 PM-7.png>)




Important Update: –

Before going to the CNI weave lecture, we have an update for the Weave Net installation link. They have announced the end of service for Weave Cloud.

To know more about this, read the blog from the link below: –

https://www.weave.works/blog/weave-cloud-end-of-service

As an impact, the old weave net installation link won’t work anymore: –

kubectl apply -f “https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d ‘\n’)”

Instead of that, use the latest link below to install the weave net: –

kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

Reference links: –

https://www.weave.works/docs/net/latest/kubernetes/kube-addon/#-installation
https://github.com/weaveworks/weave/releases



CNI WEAVE 
