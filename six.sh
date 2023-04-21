#!/bin/bash

region="us-east-1"


read -p "Enter the EC2 Instance ID: " instance_id


termination_protection=$(aws ec2 describe-instances --instance-ids $instance_id --query"Reservations[*].Instances[*].InstanceLifecycle" --region $region --output text)

if [ "$termination_protection" == "spot" ]
then

	echo "The EC2 instance is a Spot Instance and cannot have termination protection enabled."
else

	termination_protection_enabled=$(aws ec2 describe-instance-attribute --instance-id $instance_id --attribute disableApiTermination --query "DisableApiTermination.Value" --region $region --output
text)
if [ "$termination_protection_enabled" == "true" ]
then

	echo "Termination protection is enabled for EC2 Instance $instance_id."
else

	echo "Termination protection is not enabled for EC2 Instance $instance_id."
fi
fi
