#!/bin/bash


VPC_ID=vpc-04ef5bb40d0dd6dfe
SUBNET_ID=subnet-0dc39cd1fef17bae8
KEY_NAME=mumbaikey.pem
SECURITY_GROUP_ID=sg-025970dcd9cf2105b
AMI_ID=ami-02eb7a4783e7e9317
INSTANCE_TYPE=t2.micro


BASTION_SG_ID=$(aws ec2 create-security-group --group-name bastion-sg --description "Bastion Security Group" --vpc-id $VPC_ID --output text)


aws ec2 authorize-security-group-ingress --group-id $BASTION_SG_ID --protocol tcp --port 22 --cidr $(curl -sS https://checkip.amazonaws.com)/32


BASTION_INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --subnet-id $SUBNET_ID --security-group-ids $BASTION_SG_ID --associate-public-ip-address --output text | awk '{print $8}')


aws ec2 create-tags --resources $BASTION_INSTANCE_ID --tags Key=Name,Value=bastion-host


aws ec2 wait instance-running --instance-ids $BASTION_INSTANCE_ID


BASTION_IP=$(aws ec2 describe-instances --instance-ids $BASTION_INSTANCE_ID --query "Reservations[].Instances[].PublicIpAddress" --output text)
echo "Bastion host created with IP address: $BASTION_IP"

