#!/bin/bash
# Main Dependencies
sudo /tmp/install_nginx.sh
sudo /tmp/install_docker.sh
sudo /tmp/install_jenkins.sh

# Git Configuration
echo "####################################"
echo "#        GIT CONFIGURATIONS        #"
echo "####################################"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install neofetch git
git config --global user.email "lautaro.vallejosk4m@gmail.com"
git config --global user.name "Lautaro Vallejos"
ssh-keygen -t rsa -f /tmp/git-key -b 4096 -C "lautaro.vallejosk4m@gmail.com" -N ""
eval $(ssh-agent -s)
ssh-add /tmp/git-key
touch /tmp/copyThisInGH.txt
cat /tmp/git-key.pub >> /tmp/copyThisInGH.txt

echo "####################################"
echo "#     ADD THIS KEY IN GITHUB       #"
echo "####################################"
cat /tmp/copyThisInGH.txt

## GO TO ADD SSH KEY TO GH ACCOUNT