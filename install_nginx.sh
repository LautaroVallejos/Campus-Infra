#!/bin/bash


# Installing NGINX
echo "####################################"
echo "#         INSTALLING NGINX         #"
echo "####################################"
sudo apt -y update
sudo apt -y install nginx
sudo systemctl start nginx