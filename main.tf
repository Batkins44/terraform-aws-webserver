# --- Provider: tells Terraform we're working with AWS in us-east-1 ---
provider "aws" {
  region = "us-east-1"
}

# --- Security Group: like Docker port mapping, this opens port 80 (HTTP) ---
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP traffic in, allow all traffic out"

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- EC2 Instance: the actual server (like a container, but a full VM) ---
resource "aws_instance" "web" {
  ami           = "ami-0c421724a94bba6d6" # Amazon Linux 2023 (free tier, us-east-1)
  instance_type = "t3.micro"              # Free tier eligible

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # This script runs when the instance first boots — installs and starts a web server
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo "<h1>Hello from Terraform!</h1><p>Ben's Tier 2 DevOps project is live.</p>" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = "tier2-web-server"
  }
}
