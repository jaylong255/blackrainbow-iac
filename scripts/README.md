# BlackRainbow IaC Scripts

The following are some utilities used to help assist Terraform in managing infrastructure resources.

## Update IAM Policies

Sometimes you will need privileges escalated beyond those typically attached to the Terraform user. During the initial boot-strapping of the Terraform agent you will need to do this a lot. Permissions should be mostly normalized after that. However, there will be times when you need temporarily-escalated privileges again. There will also be times when previously-unused resources need to be managed, in which case permissions will need to be permanently escalated. Either way, you will need to do so outside of Terraform. This script helps make the process more efficient.