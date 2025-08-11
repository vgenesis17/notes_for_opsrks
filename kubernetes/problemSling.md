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
