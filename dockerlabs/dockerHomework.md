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

sudo docker volume create /data2

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

Sign in with your Docker account
Create an image repository on Docker Hub
Build the container image

build using Dockerfile

Push the image to Docker Hub

sudo docker build . -t villagracia213/samp-images:my-app

sudo docker push villagracia213/samp-images:my-app

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


## ADDITIONAL REFERRENCE

CONVERTING CONTAINER INTO IMAGE

sudo docker commit [container ID] [set image tag]


