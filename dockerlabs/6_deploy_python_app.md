
A python app needed to be Dockerized, and then it needs to be deployed on App Server 3. We have already copied a requirements.txt file (having the app dependencies) under /python_app/src/ directory on App Server 3. Further complete this task as per details mentioned below:



Create a Dockerfile under /python_app directory:

Use any python image as the base image.
Install the dependencies using requirements.txt file.
Expose the port 6000.
Run the server.py script using CMD.

Build an image named nautilus/python-app using this Dockerfile.


Once image is built, create a container named pythonapp_nautilus:

Map port 6000 of the container to the host port 8095.

Once deployed, you can test the app using curl command on App Server 3.


curl http://localhost:8095/


``` FROM python:3.6-alpine

# makes the folder for the installations
WORKDIR /app

# COPY requirements for so  we can do pip install
COPY src/requirements.txt /app/

# RUN pip install
RUN pip install -r requirements.txt

# copy src folder to app folder remaining files (server.py)

COPY src/ /app/

EXPOSE 6000


CMD ["python","server.py"]
```