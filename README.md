# Nimbux Interview

A Terraform configuration to launch an Application Load Balancer with two EC2 instances. First one runs a single nginx Docker container and the second one runs a single apache installer. 

# Files

    provider.tf - AWS Provider.
    instances.tf - Launches EC2 instances.
    alb.tf - Launches application load balancer for EC2 instances.
    variables.tf - Sets some variables such as region, vpc_cidr, public_cidr, etc.
    vpc.tf - Launches VPC, internet gateway and all network related things.
    outputs.tf - Set the outputs that are required by the interview.
    securitygroup.tf - Configuration of the security groups.
    terraform.tfvars - Set the different values of the variables being used.
    user_data.sh - Script that will install docker and the nginx image.
    user_data2.sh - Script that installs apache.
    nimbux-diagram.pdf - Diagram of the exercise

# Access credentials

AWS access credentials must be supplied on the terraform.tfvars file (such as access_key and secret_key). This Terraform script was tested in my own AWS account with a personal user.

# Command Line Examples

To setup provisioner

$ terraform init

To launch the EC2 project:

$ terraform plan 
$ terraform apply 

To destroy the EC2:

$ terraform destroy 

# URL

Once you apply this Terraform configuration returns the application load balancer's public URL on the last line of output. This URL can be used to view the default nginx homepage or apache homepage.
