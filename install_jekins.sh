#!/bin/bash
# Jenkins Configuration
echo "####################################"
echo "#       INSTALLING JENKINS         #"
echo "####################################"
sudo apt-get upgrade -y
sudo apt-get update -y
sudo apt install ca-certificates -y
sudo apt install openjdk-11-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
e>     /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins