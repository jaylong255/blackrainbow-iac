# BlackRainbow IaC
Terraform modules that are frequently-used, organized into composable, pluggable components.

Ultimately, this repo will host modules for multiple cloud providers. For a quick start, I'm using AWS. Soon will come contributions for GCP and CloudFlare. Eventually you should start to see examples in Azure and others. 

---

## Setting Up CI/CD with GitHub Actions and Terraform Cloud

![CI/CD](https://content.hashicorp.com/api/assets?product=tutorials&version=main&asset=public%2Fimg%2Fterraform%2Fautomation%2Ftfc-gh-actions-workflow.png)

The official docs can be found [here](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)

<u>**Prerequisites:**</u>
- A Terraform Coud Account
- A GitHub Repository
- An AWS Account

1. <u>**Workspace:**</u> Create a Workspace in a Project in [Terraform Cloud](https://app.terraform.io/app).
    - Select your organization.
    - Go to "Projects & workspaces".
    - Click "Create New", select "Workspace".
    - Choose API-driven workflow.
    - Give your workspace a name.
    - Select your project from the list (or "Default project").
    - Click "Create Workspace".
2. <u>**TF Cloud Authentication:**</u> Add the AWS credentials for your IAM user to environment variables.
    - Generate new keys and copy them or copy existing keys from wherever you have them stored.
    - From your new Terraform Cloud Workspace, go to Variables.
    - Click "Add Variable". Add first the `AWS_ACCESS_KEY_ID` and then the `AWS_SECRET_ACCESS_KEY` values for your Terraform IAM user.

2. <u>**GitHub Workflow Authentication:**</u> Create an Actions Workflow in your [Github repository](https://github.com).
    - Generate a token from the [tokens page](https://app.terraform.io/app/settings/tokens) in TF Cloud.
    - Click "Create an API token"
    - Name your token and click "Generate".
    - Copy your token.
    - From your repository click the Settings tab at the top.
    - Expand "Secrets and variables" on the left sidebar and click "Actions".
    - Click "new Repository Secret".
    - Name your new secret `TF_API_TOKEN`.
    - Use the token you copied from TF Cloud and click "Add Secret"

