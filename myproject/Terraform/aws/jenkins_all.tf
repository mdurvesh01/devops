resource "aws_instance" "Jenkins" {
  ami           = "ami-09d95fab7fff3776c"
  instance_type = "t2.small"
  key_name = "test"
  security_groups = ["${aws_security_group.allow_Jenkins.name}"]
  user_data = <<-EOF
              #!/bin/bash
              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              yum update -y
              yum install -y jenkins java-1.8.0-openjdk-devel
              systemctl start jenkins
              EOF
  tags = {
    Name = "Jenkins"
  }
}


resource "aws_security_group" "allow_Jenkins" {
  name        = "allow_Jenkins"
  description = "Allow Jenkins traffic"

  ingress {

    from_port   = 8080 #  Jenkins listens on port 80
    to_port     = 8080
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
    Name = "Jenkins"
  }
}
