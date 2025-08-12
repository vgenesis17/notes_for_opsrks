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




ontrolplane ~ ➜  kubectl get pods --help
Display one or many resources.

 Prints a table of the most important information about the specified resources.
You can filter the list using a label selector and the --selector flag. If the
desired resource type is namespaced you will only see results in the current
namespace if you don't specify any namespace.

 By specifying the output as 'template' and providing a Go template as the value
of the --template flag, you can filter the attributes of the fetched resources.

Use "kubectl api-resources" for a complete list of supported resources.

Examples:
  # List all pods in ps output format
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name)
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format
  kubectl get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps"
API group
  kubectl get deployments.v1.apps -o json
  
  # List a single pod in JSON output format
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON
output format
  kubectl get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g.
dir/kustomization.yaml
  kubectl get -k dir/
  
  # Return only the phase value of the specified pod
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List resource information in custom columns
  kubectl get pod test-pod -o
custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  
  # List all replication controllers and services together in ps output format
  kubectl get rc,services
  
  # List one or more resources by their type and names
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List the 'status' subresource for a single pod
  kubectl get pod web-pod-13je7 --subresource status
  
  # List all deployments in namespace 'backend'
  kubectl get deployments.apps --namespace backend
  
  # List all pods existing in all namespaces
  kubectl get pods --all-namespaces

Options:
    -A, --all-namespaces=false:
        If present, list the requested object(s) across all namespaces.
        Namespace in current context is ignored even if specified with
        --namespace.

    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is
        missing in the template. Only applies to golang and jsonpath output
        formats.

    --chunk-size=500:
        Return large lists in chunks rather than all at once. Pass 0 to
        disable. This flag is beta and may change in the future.

    --field-selector='':
        Selector (field query) to filter on, supports '=', '==', and
        '!='.(e.g. --field-selector key1=value1,key2=value2). The server only
        supports a limited number of field queries per type.

    -f, --filename=[]:
        Filename, directory, or URL to files identifying the resource to get
        from a server.

    --ignore-not-found=false:
        If the requested object does not exist the command will return exit
        code 0.

    -k, --kustomize='':
        Process the kustomization directory. This flag can't be used together
        with -f or -R.

    -L, --label-columns=[]:
        Accepts a comma separated list of labels that are going to be
        presented as columns. Names are case-sensitive. You can also use
        multiple flag options like -L label1 -L label2...

    --no-headers=false:
        When using the default or custom-column output format, don't print
        headers (default print headers).

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template,
        go-template-file, template, templatefile, jsonpath, jsonpath-as-json,
        jsonpath-file, custom-columns, custom-columns-file, wide). See custom
        columns
        [https://kubernetes.io/docs/reference/kubectl/#custom-columns], golang
        template [http://golang.org/pkg/text/template/#pkg-overview] and
        jsonpath template
        [https://kubernetes.io/docs/reference/kubectl/jsonpath/].

    --output-watch-events=false:
        Output watch event objects when --watch or --watch-only is used.
        Existing objects are output as initial ADDED events.

    --raw='':
        Raw URI to request from the server.  Uses the transport specified by
        the kubeconfig file.

    -R, --recursive=false:
        Process the directory used in -f, --filename recursively. Useful when
        you want to manage related manifests organized within the same
        directory.

    -l, --selector='':
        Selector (label query) to filter on, supports '=', '==', '!=', 'in',
        'notin'.(e.g. -l key1=value1,key2=value2,key3 in (value3)). Matching
        objects must satisfy all of the specified label constraints.

    --server-print=true:
        If true, have the server return the appropriate table output. Supports
        extension APIs and CRDs.

    --show-kind=false:
        If present, list the resource type for the requested object(s).

    --show-labels=false:
        When printing, show all labels as the last column (default hide labels
        column)

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML
        format.

    --sort-by='':
        If non-empty, sort list types using this field specification.  The
        field specification is expressed as a JSONPath expression (e.g.
        '{.metadata.name}'). The field in the API resource specified by this
        JSONPath expression must be an integer or a string.

    --subresource='':
        If specified, gets the subresource of the requested object.

    --template='':
        Template string or path to template file to use when -o=go-template,
        -o=go-template-file. The template format is golang templates
        [http://golang.org/pkg/text/template/#pkg-overview].

    -w, --watch=false:
        After listing/getting the requested object, watch for changes.

    --watch-only=false:
        Watch for changes to the requested object(s), without listing/getting
        first.