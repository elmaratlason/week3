#!/bin/bash
# connect to ec2 instance
# elmar.atlason@gmail.com / elmar14@ru.is
# Háskólinn í Reykjavík - 2017

INSTANCENAME=$(cat ec2_instance-jenkins/instance-public-name.txt)
PEM_FILE=$(ls ec2_instance-jenkins/*.pem)
REMOTE_COMPUTER=ec2-user@$INSTANCENAME

# start the docker container (docker-compose package) on the ec2 instance
echo "connect with ssh to $REMOTE_COMPUTER"
ssh -oStrictHostKeyChecking=no -i $PEM_FILE $REMOTE_COMPUTER 
