#!/bin/bash

#Author:	gioxmama#5021
#Datum:		15.12.2022

aws ec2 create-key-pair --key-name wordpress-key --key-type rsa --query 'KeyMaterial' --output text > ~/.ssh/wordpress-key.pem

aws ec2 create-security-group --group-name wp-sec-group --description "EC2-WP-Ubuntu"

aws ec2 authorize-security-group-ingress --group-name wp-sec-group --protocol tcp --port 80 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress --group-name wp-sec-group --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 run-instances --image-id ami-08c40ec9ead489470 --count 1 --instance-type t2.micro --key-name wordpress-key --security-groups wp-sec-group --iam-instance-profil Name=LabInstanceProfile --user-data file://~/Cloud-Init_Wordpress-on-AWS/cloud-init/cloud-init.yml --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WordPress}]'