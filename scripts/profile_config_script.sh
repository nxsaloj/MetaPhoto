#!/bin/bash
AWS_CLI_PROFILE="$1"
AWS_CREDENTIALS_LOCATION="$2"
AWS_ACCESS_KEY_ID="$3"
AWS_SECRET_ACCESS_KEY="$4"
AWS_ACCOUNT_ID="$5"
AWS_CONFIG_FILE="$AWS_CREDENTIALS_LOCATION/config"

echo -e "[profile $AWS_CLI_PROFILE]\nrole_arn=arn:aws:iam::$AWS_ACCOUNT_ID:role/cloudformation-service-role\nsource_profile=meta-photo-profile\noutput=json\nregion=us-east-1" > $AWS_CONFIG_FILE