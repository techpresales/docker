#!/bin/bash
# Script for Deleting existing Docker Engine
# Scripted by Soumik Dan
####################################
#Check docker installed

echo "Checking existing docker engine" 
echo "-----------------------------------"
yum list installed docker-*


echo "Checking /var/lib/docker folder"

if [ -d '/var/lib/docker' ]

then 

# Removing Docker Engine
echo "Removing Docker Engine"
echo "-------------------------------------"
yum -y remove docker-engine*
sleep 10
yum -y remove docker-ce
sleep 10

# Deleting Yum repo 

echo "Deleting Yum OEL7 repo"
echo "-------------------------------------"

rm -rf /etc/yum.repos.d/public-yum-ol7*.repo

#Unmounting and deleting /var/lib/docker
echo "Umount and delete /var/lib/docker"
echo "-------------------------------------"
umount -f /var/lib/docker

rm -rf /var/lib/docker

fi

echo "Docker deletion is completed"
