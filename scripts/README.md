# BlackRainbow IaC Scripts

The following are some utilities used to help assist Terraform in managing infrastructure resources.

## Update IAM Policies

Sometimes you will need privileges escalated beyond those typically attached to the Terraform user. During the initial boot-strapping of the Terraform agent you will need to do this a lot. Permissions should be mostly normalized after that. However, there will be times when you need temporarily-escalated privileges again. There will also be times when previously-unused resources need to be managed, in which case permissions will need to be permanently escalated. Either way, you will need to do so outside of Terraform. This script helps make the process more efficient.

### Updating a Policy

This sounds like a pretty straightforward and simple process but there are a couple of pain points and this script should help you iterate much faster on troubleshooting permissions. Otherwise, you're likely to get impatient and escalate privileges higher than they need to be.

1. Make sure you have selected an AWS CLI profile with elevated privileges.
2. Create an IAM policy json named after the policy and place it in the json subfolder.
3. Run the script, passing the policy name as the first argument.