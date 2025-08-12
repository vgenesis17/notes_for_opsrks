Cluster Architecture 

![alt text](image-104.png)
![alt text](image-105.png)

ETCD clusters- a database that stores infos in a key-value format

Kube-scheduler – choses the right node based on container’s requirements, the worker nodes capacity or any other policies. 

 ![alt text](image-1.png)

![alt text](image-2.png)

 
Containerd 

 ![alt text](image-3.png)
Alterative:
 

 ![alt text](image-4.png)

 


![alt text](image-5.png)


![alt text](image-6.png)
![alt text](image-7.png)
use cric cli to trouble shoot Kubernetes. Better than docker because its aware of pods
 
 
![alt text](image-8.png)

![alt text](image-9.png)



Added Container runtime interface(CRI) to make it compatible with other tools:
 
 
 ![alt text](image-10.png)
 ![alt text](image-11.png)

Containerd - runtime compatible with Kubernetes on Docker


ETCD














Document Store
 
 ![alt text](image-12.png)
 
![alt text](image-13.png)
  
 
 
![alt text](image-14.png)

![alt text](image-15.png)
![alt text](image-16.png)
![alt text](image-17.png)
![alt text](image-18.png)
Set up kubernetes
 ![alt text](image-19.png)
 
 ![alt text](image-20.png)
 ![alt text](image-21.png)
 
![alt text](image-22.png)




ETCDCTL is the CLI tool used to interact with ETCD.ETCDCTL can interact with ETCD Server using 2 API versions – Version 2 and Version 3. By default it’s set to use Version 2. Each version has different sets of commands.
For example, ETCDCTL version 2 supports the following commands:
etcdctl backup
etcdctl cluster-health
etcdctl mk
etcdctl mkdir
etcdctl set
Whereas the commands are different in version 3
etcdctl snapshot save
etcdctl endpoint health
etcdctl get
etcdctl put
To set the right version of API set the environment variable ETCDCTL_API command
export ETCDCTL_API=3
When the API version is not set, it is assumed to be set to version 2. And version 3 commands listed above don’t work. When API version is set to version 3, version 2 commands listed above don’t work.
Apart from that, you must also specify the path to certificate files so that ETCDCTL can authenticate to the ETCD API Server. The certificate files are available in the etcd-master at the following path. We discuss more about certificates in the security section of this course. So don’t worry if this looks complex:
--cacert /etc/kubernetes/pki/etcd/ca.crt
--cert /etc/kubernetes/pki/etcd/server.crt
--key /etc/kubernetes/pki/etcd/server.key
So for the commands, I showed in the previous video to work you must specify the ETCDCTL API version and path to certificate files. Below is the final form:
kubectl exec etcd-controlplane -n kube-system -- sh -c "ETCDCTL_API=3 etcdctl get / \
  --prefix --keys-only --limit=10 / \
  --cacert /etc/kubernetes/pki/etcd/ca.crt \
  --cert /etc/kubernetes/pki/etcd/server.crt \
  --key /etc/kubernetes/pki/etcd/server.key"


KUBE-API SERVR – primary control 
![alt text](image-23.png)
 
 
 ![alt text](image-24.png)
 
 ![alt text](image-25.png)
 
 ![alt text](image-26.png)
 
 
![alt text](image-27.png)
![alt text](image-28.png)
![alt text](image-29.png)
![alt text](image-30.png)

![alt text](image-31.png)
![alt text](image-32.png)
![alt text](image-33.png)
![alt text](image-34.png)
![alt text](image-35.png)
![alt text](image-36.png)
![alt text](image-37.png)
![alt text](image-38.png)
![alt text](image-39.png)
![alt text](image-41.png)
Controller use to monitor nodes 
![alt text](image-42.png)
![alt text](image-43.png)
 
 
 ![alt text](image-44.png)
 
 
 ![alt text](image-45.png)
 
 
 ![alt text](image-46.png)
 ![alt text](image-47.png)
 ![alt text](image-48.png)
 ![alt text](image-49.png)
 ![alt text](image-50.png)
 ![alt text](image-51.png)

Kube -scheduler decide which node to place the pod
 
 ![alt text](image-52.png)
 ![alt text](image-53.png)

To view the kube-scheduler options:
 ![alt text](image-54.png)
 ![alt text](image-55.png)
 
Kublet - place the pod on the node
![alt text](image-56.png)
 ![alt text](image-57.png)
 
![alt text](image-58.png)

 
KUBE-PROXY
Is a process that runs on each nodes and looks for new services and creates appropriate rules to forward traffic to the services 
 
![alt text](image-59.png)
 
![alt text](image-60.png)
PODS
![alt text](image-61.png)
 ![alt text](image-62.png)
 Pod is the smallest deployable in Kubernetes
-	Deploy more pods for scaling
-	1:1 relationship with the container running your application
 ![alt text](image-63.png)


-	A single pod can cater two container
 ![alt text](image-64.png)
Deploying pods
 
![alt text](image-65.png)






PODS WITH YAML

 ![alt text](image-66.png)
 ![alt text](image-67.png)




DEMO PODS WITH YAML
 ![alt text](image-68.png)
 
 ![alt text](image-69.png)
 
![alt text](image-70.png)

![alt text](image-71.png)
RelplicaSets
We use this for :
![alt text](image-72.png)
 

 ![alt text](image-73.png)



Rc-definition.yml
-	Move metadata up to image line 
 
 ![alt text](image-74.png)
 ![alt text](image-75.png)

![alt text](image-76.png)
Labels and Selectors 
-	To make a filter for the replica set
-	 


![alt text](image-77.png)


 ![alt text](image-78.png)

 ![alt text](image-79.png)
![alt text](image-80.png)
 

Rolling update: 
-	updating one after another 
 ![alt text](image-81.png)

Rolling back update
 
 ![alt text](image-82.png)
 ![alt text](image-83.png)
-	pods are encapsulated by Replica sets
Encapsulated by deployment 

HOW TO CREATE DEPLOYEMENT
![alt text](image-84.png)
 ![alt text](image-85.png)
 ![alt text](image-86.png)
Here’s a tip!
As you might have seen already, creating and editing YAML files is a bit difficult, especially in the CLI. During the exam, you might find it difficult to copy and paste YAML files from the browser to the terminal. Using the kubectl run command can help in generating a YAML template. And sometimes, you can even get away with just the kubectl run command without having to create a YAML file at all. For example, if you were asked to create a pod or deployment with a specific name and image, you can simply run the kubectl run command.
Use the below set of commands and try the previous practice tests again, but this time, try to use the below commands instead of YAML files. Try to use these as much as you can going forward in all exercises.
Reference (Bookmark this page for the exam. It will be very handy):
https://kubernetes.io/docs/reference/kubectl/conventions/
C# Kubernetes kubectl Commands

## Create an NGINX Pod
```bash
kubectl run nginx --image=nginx
```

## Generate POD Manifest YAML file (-o yaml). Don’t create it (–dry-run)
```bash
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

## Create a deployment
```bash
kubectl create deployment --image=nginx nginx
```

## Generate Deployment YAML file (-o yaml). Don’t create it (–dry-run)
```bash
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
```

## Generate Deployment YAML file (-o yaml). Don’t create it (–dry-run) and save it to a file
```bash
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml
```

## Make necessary changes to the file (for example, adding more replicas) and then create the deployment
```bash
kubectl create -f nginx-deployment.yaml
```

## OR (in k8s version 1.19+), specify the –replicas option to create a deployment with 4 replicas
```bash
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml
```









SERVICES
-	enables communications outside of the application, help us connection application together. 
-	Connecting micro services
 ![alt text](image-87.png)
 

![alt text](image-88.png)



INSIDE THE NODE AND DEFINING SERVICES 
 ![alt text](image-89.png)
 ![alt text](image-90.png)
 What do we do when you have pods :
Algorithm : Random
Session Affinity: Yes 
 
![alt text](image-91.png)

 
![alt text](image-92.png)

SERVICES CLUSTER IP
 ![alt text](image-93.png)
-	Enables wach layer can be scale without interruption . 

![alt text](image-94.png)
 


Services – Loadbalancer
-	Distributing traffic
  ![alt text](image-95.png)

Namespaces

Default namespace – created automatically
Kube-system – isolated namespaces created by kubernetes
Kube-public – this is where resources who were made available to users 

DEV 
PROD

Namespace – Isolation 
 ![alt text](image-96.png)
 ![alt text](image-97.png)
Switching from either dev or prod
 ![alt text](image-98.png)
 ![alt text](image-99.png)
Imperative vs Declarative approach
 ![alt text](image-100.png)
![alt text](image-101.png)

![alt text](image-102.png)


Imperative approach
- use this to save some time like creating pods or deployments

![alt text](image-106.png)



Declarative approach 
 ![alt text](image-107.png)

 ![alt text](image-108.png)
 

 

![alt text](image-109.png)


json is stored un the annotations:
![alt text](image-110.png)




kubectl run --help

Options:
    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
        golang and jsonpath output formats.

    --annotations=[]:
        Annotations to apply to the pod.

    --attach=false:
        If true, wait for the Pod to start running, and then attach to the Pod as if 'kubectl attach ...' were called.
        Default false, unless '-i/--stdin' is set, in which case the default is true. With '--restart=Never' the exit
        code of the container process is returned.

    --command=false:
        If true and extra arguments are present, use them as the 'command' field in the container, rather than the
        'args' field which is the default.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
        sending it. If server strategy, submit server-side request without persisting the resource.

    --env=[]:
        Environment variables to set in the container.

    --expose=false:
        If true, create a ClusterIP service associated with the pod.  Requires `--port`.

    --field-manager='kubectl-run':
        Name of the manager used to track field ownership.

    --image='':
        The image for the container to run.

    --image-pull-policy='':
        The image pull policy for the container.  If left empty, this value will not be specified by the client and
        defaulted by the server.

    -l, --labels='':
        Comma separated labels to apply to the pod. Will override previous values.

    --leave-stdin-open=false:
        If the pod is started in interactive mode or with stdin, leave stdin open after the first attach completes. By
        default, stdin will be closed after the first attach completes.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

    --override-type='merge':
        The method used to override the generated object: json, merge, or strategic.

    --overrides='':
        An inline JSON override for the generated object. If this is non-empty, it is used to override the generated
        object. Requires that the object supply a valid apiVersion field.

    --pod-running-timeout=1m0s:
        The length of time (like 5s, 2m, or 3h, higher than zero) to wait until at least one pod is running

    --port='':
        The port that this container exposes.

    --privileged=false:
        If true, run the container in privileged mode.

    -q, --quiet=false:
        If true, suppress prompt messages.

    --restart='Always':
        The restart policy for this Pod.  Legal values [Always, OnFailure, Never].

    --rm=false:
        If true, delete the pod after it exits.  Only valid when attaching to the container, e.g. with '--attach' or
        with '-i/--stdin'.

    --save-config=false:
        If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will
        be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML format.

    -i, --stdin=false:
        Keep stdin open on the container in the pod, even if nothing is attached.

    --template='':
        Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
        is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    -t, --tty=false:
        Allocate a TTY for the container in the pod.

DAEMONSET - ensure their is running instance of an app in all nodes
Static pods - created directly on kubelet with  no use of api server 










