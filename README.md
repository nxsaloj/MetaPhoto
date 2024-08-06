## Overview

MetaPhoto is an application to list photo libraries for each user, through an API that enrichs the photo, user and album data got from an internal API

## First steps

Clone this repository with

```
git clone --recurse-submodules https://github.com/nxsaloj/MetaPhoto
```

## Required Tools

> This environment was setup for UNIX based OS

- [GNU Make](https://www.gnu.org/software/make/) or [Make for MacOSX](https://formulae.brew.sh/formula/make)
- [Docker](https://docs.docker.com/get-docker/)
- [Node](https://nodejs.org/en/download/package-manager) (Optional, recommended to install local dependencies and debug)

## How to run the project?

### For local development

1. Run the command `docker compose up` at the root of the project
2. The backend is already running at: "http://localhost:3000/"
3. To rebuild any change in the code use the command `make rebuild` to reflect changes
   > You don't need to run `docker compose up` every time you change the `template.yml` file
4. The frontend is already running at: "http://localhost:8080/"

### Deployment

> Before deploy the backend and frontend stack, you need to configure the required rol for the process

1. Manually add to the user the policy `AWSCloudFormationFullAccess`, `sam` requires to have the policy directly associated to the user
2. Manually create a policy in the AWS Console and assing it to the user to be used, by user permission or by group permission
   > Check the `DeployPolicy.json`file as a guide to create the policy
3. Create a user access key for CLI in the AWS Console and copy the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
4. Once all steps are done, to deploy the entire stack run the command `make deploy`

### Backend deployment

1. Run `make role_setup` for the role configuration in AWS
2. Run `make deploy_backend` to deploy the stack and the source code in AWS

### Frontend deployment

1. First run `make setup_spa` to setup the stack in AWS
