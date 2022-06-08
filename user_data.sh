#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# pull nginx image
docker pull nginx:latest

# run container with port mapping - host:container
docker run -d -p 80:80 --name nginx nginx