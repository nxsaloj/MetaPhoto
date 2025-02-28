#!/bin/bash
AWS_CLI_PROFILE="$1"
AWS_CREDENTIALS_LOCATION="$2"
AWS_ACCESS_KEY_ID="$3"
AWS_SECRET_ACCESS_KEY="$4"
AWS_ACCOUNT_ID="$5"
AWS_CREDENTIALS_FILE="$AWS_CREDENTIALS_LOCATION/credentials"

mkdir -p ~/.aws
echo -e "[$AWS_CLI_PROFILE]\naws_access_key_id = $AWS_ACCESS_KEY_ID\naws_secret_access_key = $AWS_SECRET_ACCESS_KEY" > $AWS_CREDENTIALS_FILE