#!/usr/bin/env bash

# Configuration
CodeCommitRepoName=bookmark-service
StackName=bookmark-service-infra
BucketName=bookmark-service-infra-adamulvi

# Package and deploy
aws s3 cp ../swagger/bookmarks-new.yaml s3://${BucketName}

aws cloudformation package \
--template-file service.yaml \
--s3-bucket ${BucketName} \
--output-template-file packaged-${StackName}-template.yaml

aws cloudformation deploy \
--stack-name ${StackName} \
--template-file packaged-${StackName}-template.yaml \
--parameter-overrides \
"CodeCommitRepoName=${CodeCommitRepoName}" \
--s3-bucket ${BucketName} \
--capabilities CAPABILITY_IAM
