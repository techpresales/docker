#!/bin/bash
# Script for Installing Docker Engine
# Scripted by Soumik Dan
####################################
#Setting Proxy Setting

echo "Setting Proxy" 
echo "------------------------------------"

export https_proxy=http://www-proxy.us.oracle.com:80
export http_proxy=http://www-proxy.us.oracle.com:80

echo "Download Latest OEL7 Repo"
echo "------------------------------------"
wget http://yum.oracle.com/public-yum-ol7.repo

echo "Install yum util"
echo "------------------------------------"

yum install -y yum-utils

echo "Setup stable repo for docker"
echo "------------------------------------"

yum-config-manager --add-repo https://docs.docker.com/v1.13/engine/installation/linux/repo_files/oracle/docker-ol7.repo

yum makecache fast

echo "Show List of Docker Engine version"
echo "------------------------------------"

yum list docker-engine.x86_64 --showduplicates

echo "Enter which version of docker engine you want to install, followed by [ENTER]:"

read docker_version

yum -y install docker-engine-$docker_version

echo " Docker daemon start and status"
echo "------------------------------------"
systemctl start docker
sleep 5
echo "Start Done!!"
systemctl status docker
