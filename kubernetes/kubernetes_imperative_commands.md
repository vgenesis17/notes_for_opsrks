# Kubernetes Imperative Commands with `--dry-run` and `-o yaml`

While you would be working mostly the **declarative way** – using definition files – **imperative commands** can help in getting one-time tasks done quickly, as well as generate a definition template easily. This can save a considerable amount of time during your exams.

---

## Useful Options
- **`--dry-run=client`**  
  By default, as soon as the command is run, the resource will be created.  
  If you simply want to test your command, use:  
  ```bash
  --dry-run=client
  ```
  This will not create the resource; instead, it tells you whether the resource can be created and if your command is correct.

- **`-o yaml`**  
  This will output the resource definition in YAML format on the screen.

> ✅ Use the above two options **together** to generate a resource definition file quickly. You can then modify it before creating resources, instead of starting from scratch.

---

## **POD**

### Create an NGINX Pod
```bash
kubectl run nginx --image=nginx
```

### Generate POD Manifest YAML (don’t create it)
```bash
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

---

## **Deployment**

### Create a Deployment
```bash
kubectl create deployment --image=nginx nginx
```

### Generate Deployment YAML (don’t create it)
```bash
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
```

### Create Deployment with 4 Replicas
```bash
kubectl create deployment nginx --image=nginx --replicas=4
```

### Scale an Existing Deployment
```bash
kubectl scale deployment nginx --replicas=4
```

### Save YAML to a File and Modify
```bash
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > nginx-deployment.yaml
```
> You can then edit the file to add replicas or other fields before creating the deployment.

---

## **Service**

### Create a ClusterIP Service for Redis
Expose pod `redis` on port `6379`:
```bash
kubectl expose pod redis --port=6379 --name=redis-service --dry-run=client -o yaml
```
(Uses pod labels as selectors automatically.)

**OR**
```bash
kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml
```
(Does not use pod labels; assumes `app=redis` as selector.)

---

### Create a NodePort Service for NGINX
Expose pod `nginx` on port `80` at NodePort `30080`:
```bash
kubectl expose pod nginx --type=NodePort --port=80 --name=nginx-service --dry-run=client -o yaml
```
(Uses pod labels as selectors, but you cannot specify node port directly.)

**OR**
```bash
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml
```
(Does not use pod labels as selectors.)

---

## Recommendation
- Use **`kubectl expose`** for simplicity.
- If you need to specify a NodePort or selectors, generate the YAML with `--dry-run=client -o yaml`, then **edit the file** before creating the resource.

---

## **References**
- [Kubectl Command Reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
- [Kubectl Conventions](https://kubernetes.io/docs/reference/kubectl/conventions/)
