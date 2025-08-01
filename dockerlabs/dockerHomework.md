Setup and Installation 
1. Install docker on your machine. 

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh --dry-run

![alt text](image-1.png)

a. Verify the installation and ensure docker is enabled to run at restart. 
Basic Docker Commands 

docker --version 
![alt text](image-2.png)

2. Run a hello-world container and notice how the container is run. 

docker run --name hellow-world hello-world

![alt text](image-4.png)

a. Show the containers running on Docker. Is the hello-world container 
still running?  

-No


b. How can you show the status of previously run containers? 

docker ps | grep "hello-world"

c. Was the hello-world image pulled automatically? Show that the image 
is now available on your local Docker environment. 

docker images | grep "hello-world"

![alt text](image-5.png)

![
    
](image-6.png)


3. Pull a nginx image with the latest tag, run a container and name it my_nginx 
letting it sleep for 3600 seconds.  

docker run --name my_nginx nginx:latest sleep 3600
![alt text](image-7.png)

a. Is the container running on foreground or background? 

-running in forground by default

![alt text](image-8.png)

b. What option can we add to let it run in the background? 

add -d

Status: Downloaded newer image for nginx:latest
fb70b98bad3596f52a705ac4dd8ae56914e1027ac3739aa231e7d00b81b19842

admin@docker-host ➜  bg

4. Remove the my_nginx container.  

a. Are you able to do so?  
-No, because its still running

b. How can you remove the container? 
![alt text](image-9.png)
docker stop 
![alt text](image-10.png)
docker rm 

![alt text](image-11.png)

Port Mapping and Volume Mapping 

5. Using the nginx image, run another container named nginx_1 exposing the 
container port to 8888 on localhost. Open the webapp on your browser.  

docker run -p 8888:80 --name nginx_1 nginx:latest
![alt text](image-12.png)



a. Stop the container after running 

![alt text](image-13.png)

6. Create a directory named data and echo “Hello World” to a file index.html 
inside the directory. 
![alt text](image-14.png)

a. Run another nginx container named nginx_2 exposing it to 8888 on the 
localhost. 

![alt text](image-15.png)

b. Open the nginx webapp on your browser. Reload the page so it reflects 
the correct text. 
![alt text](image-16.png)

c. Notice that you may edit the html page inside the container and persist 
it in the attached directory but not the other way around. 
![alt text](image-17.png)


7. Create a volume called my_volume and run another nginx container named 
nginx3 attaching the volume to the nginx html directory and expose to the 
same port 

cannot run on the same port due to its already allocated to nginx 2

answer 1 rm the nginx2 or


answer 2 allocate it to different port 

![alt text](image-18.png)


Creating Docker Images 
8. Login to your Docker Hub account. 
![alt text](image-19.png)

copy th code 
![alt text](image-20.png)

![alt text](image-21.png)

9. Create an image named my-custom-image with the following details: 
a. nginx as the base image using latest tag 
![alt text](image-23.png)

![alt text](image-22.png)


b. Create an index.html and copy it to the nginx directory 

![alt text](image-24.png)
10. Upload your image to your Docker Hub. Verify that you have the image on 
your Docker Hub account 

```bash
admin@docker-host ✖ docker run -d -p 5000:5000 --name my-registry registry:2
Unable to find image 'registry:2' locally
2: Pulling from library/registry
44cf07d57ee4: Pull complete 
bbbdd6c6894b: Pull complete 
8e82f80af0de: Pull complete 
3493bf46cdec: Pull complete 
6d464ea18732: Pull complete 
Digest: sha256:a3d8aaa63ed8681a604f1dea0aa03f100d5895b6a58ace528858a7b332415373
Status: Downloaded newer image for registry:2
85f39266c06dddae363634267070ab1bf6d91ad32d7d04f4e880edf1fedc4560

admin@docker-host ➜  docker ps
CONTAINER ID   IMAGE        COMMAND                  CREATED          STATUS          PORTS                                       NAMES
85f39266c06d   registry:2   "/entrypoint.sh /etc…"   17 seconds ago   Up 17 seconds   0.0.0.0:5000->5000/tcp, :::5000->5000/tcp   my-registry

admin@docker-host ➜  docker tag my-custom-image:latest localhost:5000/my-custom-image

admin@docker-host ➜  docker push localhost:5000/my-custom-image
Using default tag: latest
The push refers to repository [localhost:5000/my-custom-image]
456a521541c6: Pushed 
f17478b6e8f3: Pushed 
0662742b23b2: Pushed 
5c91a024d899: Pushed 
6b1b97dc9285: Pushed 
a6b19c3d00b1: Pushed 
30837a0774b9: Pushed 
7cc7fe68eff6: Pushed 
latest: digest: sha256:9b48e2f46dbdb4dcb8892f5e82cc3c60257a64879643be622581c595e426e8c8 size: 1985

admin@docker-host ➜  curl http://localhost:5000/v2/_catalog
{"repositories":["my-custom-image"]}

```


Docker Networking 

11. Create a network named docker_net. 

![alt text](image-25.png)


12. Run a nginx container named nginx_on_net. Use latest image 

![alt text](image-26.png)

![alt text](image-27.png)


13. Attach the nginx container named nginx3 from Exercise no.7 to the network. 
a. 
View the nginx_3 page from nginx_on_net by using wget 
command: wget or curl 
Make sure to install wget for the command to run
![alt text](image-28.png)




![alt text](image-29.png)



docker inspect nginx3 | grep -i "network"


![alt text](image-30.png)