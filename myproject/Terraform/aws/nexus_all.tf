resource "aws_instance" "Nexus" {
  ami           = "ami-09d95fab7fff3776c"
  instance_type = "t2.medium"
  key_name = "test"
  security_groups = ["${aws_security_group.allow_Nexus.name}"]
  user_data = <<-EOF
              #!/bin/bash
              yum install java-1.8.0-openjdk -y
              cd /opt
              wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
              tar xvzf latest-unix.tar.gz
              mv /opt/nexus-3.24.0-02 /opt/nexus
              ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
              export RUN_AS_USER=root
              service nexus start
              EOF
  tags = {
    Name = "Nexus"
  }
}


resource "aws_security_group" "allow_Nexus" {
  name        = "allow_Nexus"
  description = "Allow Nexus traffic"

  ingress {

    from_port   = 8081 #  Nexus listens on port 8081
    to_port     = 8081
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
    Name = "Nexus"
  }
}
