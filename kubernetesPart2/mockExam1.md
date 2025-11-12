```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mc-pod
  namespace: mc-namespace
spec:
  containers:
    - name: mc-pod-1
      image: nginx:1-alpine
      env:
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
    - name: mc-pod-2
      image: busybox:1
      volumeMounts:
        - name: shared-volume
          mountPath: /var/log/shared
      command:
        - "sh"
        - "-c"
        - "while true; do date >> /var/log/shared/date.log; sleep 1; done"
    - name: mc-pod-3
      image: busybox:1
      command:
        - "sh"
        - "-c"
        - "tail -f /var/log/shared/date.log"
      volumeMounts:
        - name: shared-volume
          mountPath: /var/log/shared
  volumes:
    - name: shared-volume
      emptyDir: {}
```

### Use kubectl get crd to find all CRDs and filter by VerticalPodAutoscaler.
```bash

kubectl get crd -o custom-columns=NAME:.metadata.name | grep verticalpodautoscaler > /root/vpa-crds.txt


```


### Upgrading HelmCHarys

In this task, we will use the kubectl and helm commands. Here are the steps: -



use the helm ls command to list all the releases installed using Helm in the Kubernetes cluster.
```bash
helm ls -A
```


Here -A or --all-namespaces option lists all the releases of all the namespaces.



Identify the namespace where the resources get deployed.


Use the helm repo ls command to list the helm repositories.
```bash
helm repo ls 

```

Now, update the helm repository with the following command: -
```bash
helm repo update kk-mock1 -n kk-ns
```


The above command updates the local cache of available charts from the configured chart repositories.



The helm search command searches for all the available charts in a specific Helm chart repository. In our case, it's the nginx helm chart.
```bash
helm search repo kk-mock1/nginx -n kk-ns -l | head -n30
```


The -l or --versions option is used to display information about all available chart versions.



Upgrade the helm chart to 18.1.15 and also, increase the replica count of the deployment to 2 from the command line. Use the helm upgrade command as follows: -
```bash
helm upgrade kk-mock1 kk-mock1/nginx -n kk-ns --version=18.1.15 
```


After upgrading the chart version, you can verify it with the following command: -
```bash
helm ls -n kk-ns
```


Look under the CHART column for the chart version.