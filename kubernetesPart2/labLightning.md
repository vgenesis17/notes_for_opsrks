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