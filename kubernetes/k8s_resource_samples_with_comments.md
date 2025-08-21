# Kubernetes Resource YAML Examples with Comments

This document provides minimal YAML examples for the most common Kubernetes `kind` values, with inline comments explaining each key/value.

---

## 1. Workload Resources

### Pod
```yaml
apiVersion: v1                 # API version of Kubernetes resource
kind: Pod                      # Resource type
metadata:
  name: sample-pod              # Name of the Pod
spec:
  containers:                   # List of containers in the Pod
  - name: nginx                  # Container name
    image: nginx:latest          # Container image with tag
```

### ReplicaSet
```yaml
apiVersion: apps/v1             # API version for ReplicaSet
kind: ReplicaSet                 # Resource type
metadata:
  name: sample-rs                 # Name of the ReplicaSet
spec:
  replicas: 3                     # Number of Pod replicas
  selector:                       # How to identify Pods managed by this ReplicaSet
    matchLabels:
      app: nginx                   # Label to match
  template:                       # Pod template for new replicas
    metadata:
      labels:
        app: nginx                 # Label applied to Pods
    spec:
      containers:
      - name: nginx                # Container name
        image: nginx:latest        # Container image
```

### Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-deployment         # Name of the Deployment
spec:
  replicas: 2                     # Number of desired Pods
  selector:
    matchLabels:
      app: nginx                   # Label selector for Pods
  template:                        # Pod template
    metadata:
      labels:
        app: nginx                 # Labels for Pods
    spec:
      containers:
      - name: nginx                # Container name
        image: nginx:latest        # Container image
```

### StatefulSet
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: sample-statefulset        # Name of the StatefulSet
spec:
  serviceName: "nginx"            # Headless service name for network ID
  replicas: 2                     # Number of Pods
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

### DaemonSet
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: sample-daemonset          # Name of the DaemonSet
spec:
  selector:
    matchLabels:
      app: nginx                   # Pods with this label are managed
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

### Job
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: sample-job                # Name of the Job
spec:
  template:
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["echo", "Hello from Job"]  # Command to run
      restartPolicy: Never         # Never restart the Pod after completion
```

### CronJob
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: sample-cronjob
spec:
  schedule: "*/5 * * * *"         # Cron schedule (every 5 minutes)
  jobTemplate:                    # Template for each Job run
    spec:
      template:
        spec:
          containers:
          - name: busybox
            image: busybox
            command: ["echo", "Hello from CronJob"]
          restartPolicy: Never
```

---

## 2. Networking Resources

### Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: sample-service
spec:
  selector:
    app: nginx                    # Select Pods with this label
  ports:
  - port: 80                      # Service port
    targetPort: 80                # Container port
```

### Ingress
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sample-ingress
spec:
  rules:
  - host: example.com             # Hostname
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: sample-service  # Backend Service name
            port:
              number: 80
```

### NetworkPolicy
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: sample-networkpolicy
spec:
  podSelector:
    matchLabels:
      app: nginx                  # Apply to Pods with this label
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: allowed-app        # Only allow from Pods with this label
```

---

## 3. Config & Storage

### ConfigMap
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: sample-config
data:
  key1: value1
  key2: value2
```

### Secret
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: sample-secret
type: Opaque                     # Generic secret type
data:
  username: dXNlcg==              # base64 encoded
  password: cGFzc3dvcmQ=
```

### PersistentVolume
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: sample-pv
spec:
  persistentVolumeReclaimPolicy: Retain
  capacity:
    storage: 1Gi                  # Storage capacity
  accessModes:
    - ReadWriteOnce               # Access mode
  hostPath:
    path: /mnt/data               # Local path on the node
```

### PersistentVolumeClaim
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: sample-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

---

## 4. Access & Security

### ServiceAccount
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: sample-sa
```

### Role
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: sample-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
```

### RoleBinding
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: sample-rolebinding
subjects:
- kind: ServiceAccount
  name: sample-sa
roleRef:
  kind: Role
  name: sample-role
  apiGroup: rbac.authorization.k8s.io
```

---

## 5. Cluster Management

### Namespace
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: sample-namespace
```

### ResourceQuota
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: sample-quota
spec:
  hard:
    pods: "10"                    # Max number of Pods
    requests.cpu: "4"              # Total CPU requests allowed
    requests.memory: 8Gi           # Total memory requests allowed
```

In Kubernetes YAML,
apiVersion tells Kubernetes which API group and version to use when interpreting the resource definition.

The format is:

php-template
Copy
Edit
<API group>/<version>
or, if it’s the core API group, it’s just:

nginx
Copy
Edit
v1
1. apps/v1
API group: apps

Version: v1

Purpose: Holds most of the modern workload controllers.

Examples of kind that use apps/v1:

Deployment

ReplicaSet

StatefulSet

DaemonSet

ControllerRevision

📌 Why not just v1?
Because these resources aren’t part of the “core” API group — they belong to the apps group, which was introduced for better organization and scalability.

2. batch/v1
API group: batch

Version: v1

Purpose: Handles batch processing jobs — tasks that run to completion instead of running forever.

Examples of kind that use batch/v1:

Job

CronJob

3. Core API group (v1 only, no prefix)
API group: (none — “core”)

Version: v1

Purpose: Foundational resources that almost every cluster needs.

Examples:

Pod

Service

ConfigMap

Secret

PersistentVolume / PersistentVolumeClaim

Namespace

💡 How to check supported API groups & versions on your cluster:

bash

```bash
kubectl api-versions
Or list all kinds with their API group:
```
```bash

kubectl api-resources
```





Kubernetes has API groups, and each one is like a category that groups together related resource types.
The apiVersion you put in YAML is basically telling Kubernetes:

“Hey, use this category and this version of the rules for this resource.”

Core (Legacy) API Group – v1
Purpose: The foundational building blocks of Kubernetes.
These are so core that they don’t even have a prefix before /v1.

Common resources:

### **Pod** → The smallest runnable unit in Kubernetes.

### **Service** → Stable networking endpoint for a set of Pods.

### **ConfigMap** → Stores non-sensitive configuration.

### **Secret** → Stores sensitive data (passwords, tokens, keys).

### **PersistentVolume / PersistentVolumeClaim** → Storage.

### **Namespace** → Logical partition in the cluster.

### **Node** → Worker machine in the cluster.

### **ServiceAccount** → Identity for processes running in Pods.

---

## **apps/v1**
**Purpose** → Manages workload controllers — higher-level abstractions for running Pods.

**Common resources**:
- **Deployment** → Manages stateless applications with rolling updates.
- **ReplicaSet** → Ensures a set number of identical Pods.
- **StatefulSet** → Manages Pods with persistent identity & storage.
- **DaemonSet** → Ensures one Pod runs on every node.
- **ControllerRevision** → Stores historical states for rolling back.

---

## **batch/v1**
**Purpose** → For batch jobs — workloads that run to completion instead of forever.

**Common resources**:
- **Job** → Runs Pods until a task completes.
- **CronJob** → Runs Jobs on a schedule (like cron in Linux).

---

## **networking.k8s.io/v1**
**Purpose** → Networking rules for communication between workloads.

**Common resources**:
- **Ingress** → Routes external traffic to Services/Pods.
- **NetworkPolicy** → Controls which Pods can talk to which Pods.
- **IngressClass** → Configures default behavior for Ingress controllers.

---

## **rbac.authorization.k8s.io/v1**
**Purpose** → Role-Based Access Control (RBAC) — controls who can do what.

**Common resources**:
- **Role** → Permissions within a namespace.
- **ClusterRole** → Permissions across the whole cluster.
- **RoleBinding** → Assigns a Role to a user/service account.
- **ClusterRoleBinding** → Assigns a ClusterRole to a user/service account.

---

## **storage.k8s.io/v1**
**Purpose** → Defines storage management & behavior.

**Common resources**:
- **StorageClass** → Describes types of storage (e.g., SSD, HDD).
- **CSIDriver / CSINode** → Configure CSI storage plugins.

---

## **policy/v1**
**Purpose** → Pod-level security & disruption policies.

**Common resources**:
- **PodDisruptionBudget** → Ensures a minimum number of Pods stay up during voluntary disruptions.

---

## **autoscaling/v2**
**Purpose** → Automatic scaling of workloads.

**Common resources**:
- **HorizontalPodAutoscaler** → Scales the number of Pods based on metrics like CPU/memory usage.

---

💡 **Think of it like this**:
- **v1 (Core)** → Everyday essentials.  
- **apps/v1** → How you run and manage your apps.  
- **batch/v1** → Jobs that finish.  
- **networking.k8s.io/v1** → How traffic flows.  
- **rbac.authorization.k8s.io/v1** → Who’s allowed to do what.  
- **storage.k8s.io/v1** → Where your data lives.  
- **autoscaling/v2** → Growing/shrinking workloads automatically.  
