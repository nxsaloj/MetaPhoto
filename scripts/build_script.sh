#!/bin/bash
PROFILE="$1"
ACCOUNT_ID="$2"
REGION="${3:-us-east-1}"
ROLE="arn:aws:iam::$ACCOUNT_ID:role/cloudformation-service-role"

aws cloudformation validate-template --profile $PROFILE --region $REGION --template-body file://templates/role-template.yml
aws cloudformation deploy --debug --profile $PROFILE --stack-name meta-photo-role-stack --region $REGION --template-file templates/role-template.yml --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
aws cloudformation validate-template --profile $PROFILE --region $REGION --template-body file://templates/main.yml
aws cloudformation deploy --debug --profile $PROFILE  --region $REGION --role-arn $ROLE --stack-name meta-photo-stack --template-file templates/main.yml --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
aws s3 cp --profile $PROFILE --region $REGION index.html s3://meta-photo-bucket-test/ --acl public-read