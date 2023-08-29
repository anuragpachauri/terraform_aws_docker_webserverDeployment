
# terraform_aws_docker_webserverDeployment

This project aims to demonstrate how to use Terraform to provision an EC2 instance on AWS, install Docker, and deploy an Nginx web server using a Docker container. The infrastructure is managed as code, providing an automated and repeatable deployment process.



## Prerequisites

1. An AWS account with appropriate access permissions.
2. AWS CLI installed and configured with your credentials.
3. Terraform installed on your local machine.
4. Basic familiarity with Terraform and Docker.

## Get-Started

1. Clone the repository:
git clone https://github.com/anuragpachauri/terraform_aws_docker_webserverDeployment.git
cd terraform_aws_docker_webserverDeployment

2. Edit the main.tf file to customize the configuration if needed, such as region, instance type, and security group settings.

3. Run Terraform commands to initialize and apply the configuration: 
terraform init

terraform apply

4. Once the deployment is complete, the EC2 instance will be running Nginx on port 80. Access the instance's public IP in a web browser to see the Nginx welcome page.



## Usage

1. To modify the Terraform configuration, edit the main.tf file according to your requirements.

2. After making changes, use terraform plan to preview the changes and terraform apply to apply them.

3. Remember to destroy the resources after you're done:
terraform destroy


## Contributing

Contributions are welcome! If you find any issues or want to improve the project, feel free to create pull requests or open issues.