#!/bin/bash

sudo exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo yum -y update
sudo yum -y install docker
sudo pip install docker-compose
sudo pip install backports.ssl_match_hostname --upgrade

sudo service docker start
sudo usermod -a -G docker ec2-user

# install data dog install_agent
DD_API_KEY=5227161a7f5d85725705c0348174953f bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)"

# agent for docker
docker run -d --name dd-agent -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /cgroup/:/host/sys/fs/cgroup:ro -e API_KEY=5227161a7f5d85725705c0348174953f -e SD_BACKEND=docker datadog/docker-dd-agent:latest

touch ec2-init-done.markerfile
