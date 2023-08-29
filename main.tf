provider "aws" {
  profile = "default"
}
resource "aws_s3_bucket" "my_bucket" { # to create aws s3 bucket
  bucket = "mybucketnameforjusttestingthe"  # Replace with your desired bucket name
  acl    = "private"  # Adjust the ACL as needed

  tags = {
    Name = "My Terraform Bucket"
  }
}

resource "aws_security_group" "instance_sg" { # to create aws security froup for ec2 instance
  name        = "instance-security-group"
  description = "Security group for EC2 instance"
  
 // ingress rules for inbond traffic
  ingress {   #for ssh
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {      #for http protocal to access from web
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Egress rules for outgoing traffic
  egress {         #  for internet connectivity
    from_port   = 0
    to_port     = 0
    protocol    = "-1"   // Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webserver" {  # creating ec2 instance
   ami           = "ami-01dd271720c1ba44f"
  instance_type = "t2.micro"    
  key_name      = "terraform"  # define your own key

  security_groups = [aws_security_group.instance_sg.name] # group created above
  # i am writing user-data to install net-tools docker and create dockerfile from that i build it  and run the container
   user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt install net-tools -y
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ubuntu

    # Echo Dockerfile content and create Dockerfile
    echo 'FROM nginx:latest' > Dockerfile
    echo '' >> Dockerfile
    echo '# Copy custom configuration if needed (optional)' >> Dockerfile
    echo '' >> Dockerfile
    echo '# Expose port 80' >> Dockerfile
    echo 'EXPOSE 80' >> Dockerfile
    echo '' >> Dockerfile
    echo '# Command to start Nginx' >> Dockerfile
    echo 'CMD ["nginx", "-g", "daemon off;"]' >> Dockerfile

    # Build and run Docker container
    cd /
    sudo docker build -t anurag - < Dockerfile
    sudo docker run -d --name webserver -p 80:80  anurag
    EOF

  tags = {
    Name = "EC2-Docker-Instance"
  }
}

# saving terraform.tfstate file in s3

resource "aws_s3_bucket_object" "example_object" {      
  bucket = aws_s3_bucket.my_bucket.id
  key    = "terraform.tfstate"  # Replace with the desired object key
  source = "/Users/anuragpachauri/Desktop/terraform_aws_deployment/terraform.tfstate"  # Replace with the local file name

  content_type = "text/plain"
}