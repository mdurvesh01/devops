resource "aws_instance" "Apache" {
  ami           = "ami-09d95fab7fff3776c"
  instance_type = "t2.small"
  key_name = "test"
  security_groups = ["${aws_security_group.allow_Apache.name}"]
  user_data = <<-EOF
              #!/bin/bash
              yum install httpd -y
              echo "Welcome 2020" > /var/www/html/index.html
              yum update -y
              systemctl start httpd.service
              EOF
  tags = {
    Name = "Apache"
  }
}


resource "aws_security_group" "allow_Apache" {
  name        = "allow_Apache"
  description = "Allow Apache traffic"

  ingress {

    from_port   = 80 #  httpd listens on port 80
    to_port     = 80
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {

    from_port   = 22 #  By default, the Linux server listens on TCP port 22 for SSH
    to_port     = 22
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Apache"
  }
}
