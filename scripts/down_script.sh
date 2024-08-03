#!/bin/bash
PROFILE="$1"
ACCOUNT_ID="$2"
REGION="${3:-us-east-1}"
ROLE="arn:aws:iam::$ACCOUNT_ID:role/cloudformation-service-role"

aws cloudformation delete-stack --profile $PROFILE  --region $REGION --role-arn $ROLE --stack-name meta-photo-stack
aws cloudformation delete-stack --profile $PROFILE  --region $REGION --role-arn $ROLE --stack-name meta-photo-role-stack