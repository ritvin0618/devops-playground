# main.tf

# Specify Terraform version
terraform {
  required_version = ">= 1.0"
}

# AWS Provider block (we will use aliases for multiple regions)
provider "aws" {
  region = "us-east-1"  # default region
  alias  = "us_east_1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "us_west_2"
}

# Security Group to allow SSH
resource "aws_security_group" "allow_ssh_us_east" {
  name        = "allow_ssh_us_east"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.default_us_east.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_ssh_us_west" {
  provider    = aws.us_west_2
  name        = "allow_ssh_us_west"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.default_us_west.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# VPCs for each region
resource "aws_vpc" "default_us_east" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "us-east-vpc"
  }
}

resource "aws_vpc" "default_us_west" {
  provider   = aws.us_west_2
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "us-west-vpc"
  }
}

# Subnets for each region
resource "aws_subnet" "subnet_us_east" {
  vpc_id            = aws_vpc.default_us_east.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_us_west" {
  provider           = aws.us_west_2
  vpc_id             = aws_vpc.default_us_west.id
  cidr_block         = "10.1.1.0/24"
  availability_zone  = "us-west-2a"
}

# EC2 Instances
resource "aws_instance" "ec2_us_east" {
  ami = "ami-0254b2d5c4c472488" # Amazon Linux 2 AMI (update per region)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_us_east.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_us_east.id] 

  tags = {
    Name = "EC2-Us-East"
  }
}

resource "aws_instance" "ec2_us_west" {
  provider      = aws.us_west_2
  ami = "ami-024e4b8b6ef78434a" # Replace with correct AMI for us-west-2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_us_west.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_us_west.id] 

  tags = {
    Name = "EC2-Us-West"
  }
}
vpc_security_group_ids = [aws_security_group.allow_ssh_us_east.id]  
