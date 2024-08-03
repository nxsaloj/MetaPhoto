include .env
AWS_CLI_PROFILE ?= "default"

setup:
	./scripts/build_script.sh ${AWS_CLI_PROFILE} ${AWS_ACCOUNT_ID}
	
down:
	./scripts/down_script.sh ${AWS_CLI_PROFILE} ${AWS_ACCOUNT_ID}