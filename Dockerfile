FROM ubuntu:14.04
MAINTAINER Dimitar Damyanov <dimitar.damyanov@tumba.solutions>

#Install required packages
RUN apt-get update && apt-get install -y apt-utils && apt-get install -y nodejs && apt-get install -y npm && apt-get install -y git
RUN apt-get install -y build-essential
RUN apt-get install -y wget && apt-get install -y curl
RUN npm config set registry http://registry.npmjs.org/
RUN npm install -g n
RUN n latest
RUN n 0.8.20
RUN n 0.10.32

#Copy api-test directory onto the container
COPY . /home/api

#Set the default workibng directory
WORKDIR /home/api

#Install the app
RUN npm install

#Open port 3001 to the host OS
EXPOSE 3005 

#Start the app
CMD ["/usr/local/bin/node", "index.js"]
