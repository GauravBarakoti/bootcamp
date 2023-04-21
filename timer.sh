#!/bin/bash


aws cloudformation create-stack \
    --stack-name my-stack \
    --template-body file://stack.json \
    --capabilities CAPABILITY_NAMED_IAM \
    --tags Key=Name,Value=my-stack


aws cloudformation wait stack-create-complete \
    --stack-name my-stack


web_server_private_id=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=Web Server Private" \
    --query "Reservations[0].Instances[0].InstanceId" \
    --output text)

web_server_public_id=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=Web Server Public" \
    --query "Reservations[0].Instances[0].InstanceId" \
    --output text)


aws ec2 create-tags \
    --resources $web_server_private_id $web_server_public_id \
    --tags Key=Name,Value=my-instance


aws events put-rule \
    --name start-instances-rule \
    --schedule-expression 'cron(0 10 * * ? *)'


cat <<EOF > start-instances.py
import boto3

def lambda_handler(event, context):
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(Filters=[
        {'Name': 'tag:Name', 'Values': ['Web Server Private', 'Web Server Public']},
        {'Name': 'instance-state-name', 'Values': ['stopped']}
    ])
    for instance in instances:
        instance.start()
    return 'Instances started: ' + str([i.id for i in instances])
EOF

zip start-instances.zip start-instances.py
aws lambda create-function \
    --function-name start-instances \
    --runtime python3.8 \
    --handler start-instances.lambda_handler \
    --role arn:aws:iam::123456789012:role/lambda-role \
    --code S3Bucket=my-bucket,S3Key=start-instances.zip


aws events put-rule \
    --name stop-instances-rule \
    --schedule-expression 'cron(0 21 * * ? *)'


cat <<EOF > stop-instances.py
import boto3

def lambda_handler(event, context):
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(Filters=[
        {'Name': 'tag:Name', 'Values': ['Web Server Private', 'Web Server Public']},
        {'Name': 'instance-state-name', 'Values': ['running']}
    ])
    for instance in instances:
        instance.stop()
    return 'Instances stopped: ' + str([i.id for i in instances])
EOF

zip stop-instances.zip stop-instances.py
aws lambda create-function \
   --function-name stop-instances \
    --runtime python3.8 \
    --handler stop-instances.lambda_handler \
    --role arn:aws:iam::123456789012:role/lambda-role \
    --code S3Bucket=my-bucket,S3Key=stop-instances.zip


aws lambda add-permission \
    --function-name start-instances \
    --statement-id start-instances-st

