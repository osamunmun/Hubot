#!/bin/sh
set -ex

SECURITY_GROUP_NAME="circle_ci"
IP=`curl -s ifconfig.me`

trap "aws ec2 revoke-security-group-ingress --group-name ${SECURITY_GROUP_NAME} --protocol tcp --port 22 --cidr ${IP}/32" 0 1 2 3 15
aws ec2 authorize-security-group-ingress --group-name ${SECURITY_GROUP_NAME} --protocol tcp --port 22 --cidr ${IP}/32
cd ansible; ansible-playbook -i hosts hubot.yml
