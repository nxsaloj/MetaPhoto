include .env
#AWS_CLI_PROFILE ?= "default"
AWS_CLI_PROFILE := $(or $(AWS_CLI_PROFILE),"meta-photo-profile")
# Default credentials file location for UNIX based systems
AWS_CREDENTIALS_LOCATION := $(or $(AWS_CREDENTIALS_LOCATION),"~/.aws")
# Default credentials file location for UNIX based systems
BUCKET_BUILD := $(or $(BUCKET_BUILD),"metaphotobucketbuild")


profile:
	docker exec -it bash-container bash -c "./scripts/profile_script.sh ${AWS_CLI_PROFILE} ${AWS_CREDENTIALS_LOCATION} ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${AWS_ACCOUNT_ID}"
	docker exec -it sam-container bash -c "./scripts/profile_script.sh ${AWS_CLI_PROFILE} ${AWS_CREDENTIALS_LOCATION} ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${AWS_ACCOUNT_ID}"

profile_config:
	docker exec -it bash-container bash -c "./scripts/profile_config_script.sh ${AWS_CLI_PROFILE} ${AWS_CREDENTIALS_LOCATION} ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${AWS_ACCOUNT_ID}"
	docker exec -it sam-container bash -c "./scripts/profile_config_script.sh ${AWS_CLI_PROFILE} ${AWS_CREDENTIALS_LOCATION} ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${AWS_ACCOUNT_ID}"

role_setup: profile
	docker exec -it bash-container bash -c "./scripts/role_script.sh ${AWS_CLI_PROFILE} ${BUCKET_BUILD} ${AWS_ACCOUNT_ID} ${AWS_USER_NAME}"

setup_spa: profile_config
	docker exec -it bash-container bash -c "./scripts/build_script.sh ${AWS_CLI_PROFILE} ${AWS_ACCOUNT_ID} ${BUCKET_BUILD}"

deploy_backend: profile_config
	docker exec -it sam-container bash -c "sam build --parameter-overrides Stage=prod BucketBuild=metaphotobucketbuild && sam deploy --profile ${AWS_CLI_PROFILE} --role-arn arn:aws:iam::${AWS_ACCOUNT_ID}:role/cloudformation-service-role --s3-bucket ${BUCKET_BUILD} --s3-prefix backend-app --parameter-overrides Stage=prod"

dev_backend:
	docker exec -it sam-container bash -c "./scripts/start_api.sh"

deploy: role_setup deploy_backend setup_spa	
	@echo "Deploy process finished"

rebuild:
	docker exec -it sam-container bash -c "sam build --parameter-overrides BucketBuild=/home/app"

sync:
	docker exec -it sam-container bash -c "sam sync --parameter-overrides Stage=prod BucketBuild=metaphotobucketbuild --profile ${AWS_CLI_PROFILE} --role-arn arn:aws:iam::${AWS_ACCOUNT_ID}:role/cloudformation-service-role --stack-name BackendStack --watch --region us-east-1"