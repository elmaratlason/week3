#!/usr/bin/env bash
# used to install needed tools on jenkins server
# Háskólinn í Reykjavík - 2017
# elmar.atlason@gmail.com / elmar14@ru.is

sudo exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

sudo yum update
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum -y remove java-1.7.0-openjdk
sudo yum -y install java-1.8.0

# install docker and docker-compose
sudo yum -y install docker
sudo yum -y install docker-compose

# start docker and add ec2-user to docker group
sudo service docker start
sudo usermod -a -G docker ec2-user

# install jenkins and add jenkins user to docker group, then start service
sudo yum install jenkins -y
sudo usermod -a -G docker jenkins
sudo service jenkins start

# install git client
sudo yum install git

# install nodejs and jpm
sudo yum install nodejs npm --enablerepo=epel

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

# install correct version of nodejs
nvm install 6.9.1

# install yarn
sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
curl --silent --location https://rpm.nodesource.com/setup_6.x | sudo bash -
sudo yum install yarn

touch ec2-init-done.markerfile
