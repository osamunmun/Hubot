#!/bin/sh
set -ex

IP=`curl -s ifconfig.me`

trap "aws ec2 revoke-security-group-ingress --group-id ${AWS_SECURITY_GROUP_ID} --protocol tcp --port 22 --cidr ${IP}/32" 0 1 2 3 15
aws ec2 authorize-security-group-ingress --group-id ${AWS_SECURITY_GROUP_ID} --protocol tcp --port 22 --cidr ${IP}/32
cd ansible; ansible-playbook -i hosts hubot.yml --vault-password-file ~/vault.txt
