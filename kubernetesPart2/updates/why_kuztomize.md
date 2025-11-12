
kustomize
-- for customizing environments 

    Overlays: |
--------------|--------------------------------------
- base 
    -[overlays/dev]
                        [overlays/prod]
    -[overlays/stg]


Folder structure 
k8s
![alt text](  image.png)


--installation/setup


![alt text](image-1.png)
```bash
kustomize version --short

kustomize build k8s/ | kubectl apple -f - 

# delete
kustomize build k8s/ | kubectl delete -f - 
```

![alt text](image-2.png)


![alt text](image-3.png)

