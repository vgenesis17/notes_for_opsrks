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

