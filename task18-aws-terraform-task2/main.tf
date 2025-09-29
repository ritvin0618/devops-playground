resource "aws_instance" "nginx_east" {
  provider          = aws.us_east_1
  ami               = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI in us-east-1
  instance_type     = "t2.micro"
  key_name          = "your-key-name"
  vpc_security_group_ids = [aws_security_group.nginx_sg_east.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "nginx-east"
  }
}

resource "aws_instance" "nginx_west" {
  provider          = aws.us_west_2
  ami               = "ami-0742b4e673072066f" # Amazon Linux 2 AMI in us-west-2
  instance_type     = "t2.micro"
  key_name          = "your-key-name"
  vpc_security_group_ids = [aws_security_group.nginx_sg_west.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "nginx-west"
  }
}

