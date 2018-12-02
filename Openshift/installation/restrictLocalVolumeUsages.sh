#!/bin/bash

#Install the docker-novolume-plugin package:
#$ yum install docker-novolume-plugin

#Enable and start the docker-novolume-plugin service:
#$ systemctl enable docker-novolume-plugin
#$ systemctl start docker-novolume-plugin

#Edit the /etc/sysconfig/docker file and append the following to the OPTIONS list:
#--authorization-plugin=docker-novolume-plugin

#Restart the docker service:
#$ systemctl restart docker