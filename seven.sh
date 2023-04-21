#!/bin/bash

instance_ids=$(aws ec2 describe-instances --query'Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value|[0]]' --output text | awk '{print$1}')

for instance_id in $instance_ids
do
	private_ip=$(aws ec2 describe-instances --instance-ids $instance_id --query'Reservations[*].Instances[*].PrivateIpAddress' --output text)state=$(aws ec2 describe-instances --instance-ids $instance_id --query'Reservations[*].Instances[*].State.Name' --output text)
	echo "Instance ID: $instance_id, Private IP: $private_ip, State: $state"
done
