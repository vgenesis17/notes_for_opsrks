There is a requirement to Dockerize a Node app and to deploy the same on App Server 2. Under /node_app directory on App Server 2, we have already placed a package.json file that describes the app dependencies and server.js file that defines a web app framework.



Create a Dockerfile (name is case sensitive) under /node_app directory:

Use any node image as the base image.
Install the dependencies using package.json file.
Use server.js in the CMD.
Expose port 6100.

The build image should be named as nautilus/node-web-app.


Now run a container named nodeapp_nautilus using this image.

Map the container port 6100 with the host port 8091.

. Once deployed, you can test the app using a curl command on App Server 2:


```
# /node_app/Dockerfile
FROM node:latest

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json /app/
RUN npm install

# Copy application files
COPY . /app/

# Expose port 6100
EXPOSE 6100

# Command to run the server
CMD ["node", "server.js"]


```