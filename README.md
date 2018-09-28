# enforce-tag-from-data-source
This is an example of using a [Terraform Data Source](https://www.terraform.io/docs/configuration/data-sources.html) as part of Sentinel policy evaluation. The Sentinel policy uses `tfplan.tfstate.data` to looks up an existing resource: [enforce-tag-from-data-source](enforce-tag-from-data-source.sentinel). 

### Validation Secnario:
1. An AWS VPC with a public Subnet has been provisioned
2. An EC2 instance will be provisioned to the Subnet created in #1 

The Sentinel policy will ensure the `Env` tag of AWS EC2 instance matches the `Env` tag of the **existing** AWS VPC.
Example:
- EC2 instance Env tag = "Prod" and Existing Subnet Env tag = "Dev": Sentinel policy will FAIL 
- EC2 instance Env tag = "Dev" and Existing Subnet Env tag = "Dev": Sentinel policy will PASS 

### Test:
- Clone this repo and cd into local path: `cd terraform-aws-governance-tests`
```
cd vpc
export AWS_ACCESS_KEY_ID=<your-access-key-id>
export AWS_SECRET_ACCESS_KEY=<your-secret-access-key>
export TF_VAR_owner=$(whoami)
terraform init
terraform plan
terraform apply -auto-approve=true
```
- Now export the subnet_id as we will provision the AWS EC2 instance in this subnet:
```
export subnet_id=$(terraform output -json | jq -r .subnet_id.value)
```
### Import Sentinel policy: 
- Import [enforce-tag-from-data-source](enforce-tag-from-data-source.sentinel) to the above Organization in TFE.

### Provision EC2 instance in Terraform Enterprise:
- Use the Terraform Enterprise UI to setup a Workspace, or [tfe-cli](https://github.com/hashicorp/tfe-cli) commands as below:
```
cd ../ec2
export TFE_ORG="<your-organization>"
export TFE_WORKSPACE="enforce-tag-from-data-source"
export TFE_TOKEN=<your-tfe-token>

tfe workspace new
tfe pushvars -senv-var "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
tfe pushvars -senv-var "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
tfe pushvars -var "owner=${TF_VAR_owner}"
tfe pushvars -var "subnet_id=${subnet_id}"
tfe pushconfig -vcs true
```

### Sentinel:
- Queue a plan in TFE
- By default Sentinel policy will fail as the `Env` tag of `aws_instance` is set to `Production` 
- Lets set the `environment` Terraform variable to `Dev` to match that of aws_subnet:
```
tfe pushvars -var "environment=Dev"
```
- Queue a plan in TFE again and it will pass.

### Cleanup:
- Queue a destroy plan in TFE
- Clean up local state:
```
cd ../vpc
terraform destroy
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
```
