#!/bin/bash

regions=("us-east-1" "us-west-2" "eu-west-1")

for region in "${regions[@]}"
do

	echo "Running instances in $region:"aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --region $region --query "Reservations[*].Instances[*].[InstanceId, InstanceType, State.Name, LaunchTime]" --outputtable
done

while true
do

	read -p "Do you want to stop any of the instances? (yes/no): " answer

	case $answer in[yY]es )

		read -p "Enter the Instance ID: " instance_idaws ec2 stop-instances --instance-ids $instance_id

		echo "Instance $instance_id is stopping..."
		;;

	[nN]o )

		echo "No instances will be stopped."
		exit
		;;
	* )
		echo "Please enter yes or no."

		;;
	esac
done
