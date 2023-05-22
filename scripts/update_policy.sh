#!/bin/bash

# Usage: ./scripts/update_policy.sh <policy_name>

# Set the policy name = to the first argument passed to the script
policy_name=$1

# Get the AWS account ID
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Set the policy ARN
policy_arn="arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${policy_name}"

echo "Policy ARN: $policy_arn"

# Get the count of policy versions
echo "Getting policy version count"
policy_version_count=$(aws iam list-policy-versions --policy-arn arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${policy_name} --query 'Versions | length(@)')
oldest_version_index=$(($policy_version_count - 1))

echo "Working with policy: $policy_arn"
# Using the policy version count, retrieve the version ID of the oldest version
echo "Getting the oldest version ID"
oldest_version=$(aws iam list-policy-versions --policy-arn $policy_arn --query "Versions[$oldest_version_index].VersionId" --output text)

echo "Deleting oldest version: $oldest_version"
aws iam delete-policy-version --policy-arn $policy_arn --version-id $oldest_version

echo "Creating new version"
aws iam create-policy-version --policy-arn $policy_arn --policy-document file://json/$policy_name.json --set-as-default