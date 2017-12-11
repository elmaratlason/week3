#!/usr/bin/env bash
# setup jenkins on ec2 instance
# elmar.atlason@gmail.com / elmar14@ru.is
# Háskólinn í Reykjavík

# get the commit id and instance id as command line arguments
INSTANCE_ID=$(cat ec2_instance-jenkins/instance-id.txt)

# check if the instance id is our
if [ $INSTANCE_ID == $(cat ec2_instance-jenkins/instance-id.txt) ]
then
  INSTANCENAME=$(cat ec2_instance-jenkins/instance-public-name.txt)
else
  echo "invalid instance id"
  echo "quitting..."
  echo "my id is: $(cat ec2_instance-jenkins/instance-id.txt)"
  exit 1
fi

# awscomputer
REMOTE_COMPUTER=ec2-user@$INSTANCENAME
PEM_FILE=$(ls ec2_instance-jenkins/*.pem)

# scripts to run on ec2 instance
EC2_JENKINS_SCRIPTS_FOLDER=./jenkins_scripts
EC2_JENKINS_INIT_SCRIPT=ec2-bootstrap-jenkins.sh

# make rsync copy all files (also .hidden)
shopt -s dotglob

# copy script files, not all neccessary to run on ec2 instance to start docker, etc 
echo "copy .sh files"
rsync -rave "ssh -oStrictHostKeyChecking=no -i $PEM_FILE" ./ec2*.sh $REMOTE_COMPUTER:$EC2_JENKINS_SCRIPTS_FOLDER/

# install jenkins and needed stuff (docker)
echo "connect with ssh to $REMOTE_COMPUTER"
ssh -oStrictHostKeyChecking=no -i $PEM_FILE $REMOTE_COMPUTER "$EC2_JENKINS_SCRIPTS_FOLDER/$EC2_JENKINS_INIT_SCRIPT"
