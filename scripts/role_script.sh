#!/bin/bash
PROFILE="$1"
BUCKET_BUILD="${2:-metaphotobucketbuild}"
AWS_ACCOUNT_ID="${3}"
AWS_USER_NAME="${4}"
REGION="${5:-us-east-1}"
BASE_PARAMS="--profile $PROFILE --region $REGION"

aws s3api create-bucket --bucket $BUCKET_BUILD --region $REGION --profile $PROFILE 
aws cloudformation deploy --debug $BASE_PARAMS \
    --stack-name meta-photo-role-stack \
    --template-file templates/role-template.yml \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --parameter-overrides UserName=$AWS_USER_NAME UserId=$AWS_ACCOUNT_ID