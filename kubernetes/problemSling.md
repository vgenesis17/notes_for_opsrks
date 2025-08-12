Create a ReplicaSet using the replicaset-definition-1.yaml file located at /root/.


There is an issue with the file, so try to fix it.
-----------------------------------------------------------------------------------

controlplane ~ ✖ kubectl delete rs new-replica-set
replicaset.apps "new-replica-set" deleted

controlplane ~ ➜  kubectl apply -f /root/new-replica-set.yaml
replicaset.apps/new-replica-set created

controlplane ~ ➜  kubectl set image rs/new-replica-set busybox-container=busybox:latest
replicaset.apps/new-replica-set image updated

controlplane ~ ➜  kubectl delete pods -l name=busybox-pod
pod "new-replica-set-6hj26" deleted
pod "new-replica-set-gj2cb" deleted
pod "new-replica-set-pnt8d" deleted
pod "new-replica-set-vjskc" deleted

### Remove the taint on controlplane, which currently has the taint effect of NoSchedule.


Run the command: kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-








### How many objects are in the prod environment including PODs, ReplicaSets and any other objects?


kubectll get pod all --selector env=prod



## Which node is the POD mosquito on now?

Run the command kubectl get pods -o wide and look at the Node column.









---
Set Node Affinity to the blue deployment to place the pods on node01 only.

Ensure that node01 has the label color=blue.

Requirements:

Use requiredDuringSchedulingIgnoredDuringExecution node affinity
Key: color
Value: blue

If the label is not already set, apply it to node01 before updating the deployment.

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      run: nginx
  template:
    metadata:
      labels:
        run: nginx
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
      affinity:            # affinity rules added from here
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: color
                operator: In
                values:
                - blue

```
