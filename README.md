# Minecraft on AWS
Deploy a minecraft server on AWS via terraform

## Resources
This will deploy the following:
* **EC2 instance** - t2.small with 16 GB GP3 block storage
  * Configured to download the latest minecraft server jar and configure it to run via docker at startup
  * Can probably handle 2 - 3 users
* **Security Group** - with only the minecraft port open

## Deploying
1. [Install terraform cli locally](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
1. Setup your AWS credentials, I like to use [aws-vault](https://github.com/99designs/aws-vault)
1. Run `aws-vault exec <profile> -- terraform init`
1. *Optional*: Run `aws-vault exec <profile> -- terraform plan` to see a dry run of what will be created
1. Run `aws-vault exec <profile> -- terraform apply` to deploy the stack to your aws account
   It will prompt for the ec2 image type. Probably need at least a `t2.small` to run 2 - 3 players
1. It will output the new ip address of your minecraft server
