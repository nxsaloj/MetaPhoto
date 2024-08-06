#!/bin/bash
PROFILE="$1"
ACCOUNT_ID="$2"
BUCKET_BUILD="${3:-metaphotobucketbuild}"
REGION="${4:-us-east-1}"
ROLE="arn:aws:iam::$ACCOUNT_ID:role/cloudformation-service-role"

BASE_PARAMS="--profile $PROFILE --region $REGION"
STAGE="${5:-prod}"

aws cloudformation deploy --role-arn $ROLE \
    --debug \
    $BASE_PARAMS \
    --stack-name meta-photo-stack \
    --template-file MetaPhoto.spa/template.yml \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
    --parameter-overrides Stage=$STAGE BucketBuild=$BUCKET_BUILD
aws s3 cp --profile $PROFILE --region $REGION index.html s3://meta-photo-bucket-test/ --acl public-read