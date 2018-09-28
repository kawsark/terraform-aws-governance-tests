# terraform-aws-governance-tests
Example repo to test Terraform Sentinel.

### Provision VPC:
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

### Provision EC2 instance in Terraform Enterprise:
- Use the UI to setup a workspace or tfe-cli commands as below:
```
cd ../ec2
export TFE_ORG="kawsar-org"
export TFE_WORKSPACE="terraform-aws-governance-tests"
export TFE_TOKEN=<your-tfe-token>

tfe workspace new
tfe pushvars -senv-var "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
tfe pushvars -senv-var "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
tfe pushvars -var "owner=${TF_VAR_owner}"
tfe pushvars -var "subnet_id=${subnet_id}"
tfe pushconfig 
```
