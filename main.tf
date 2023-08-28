# Security Group to allow traffic to and from the Internet (i.e. install and download packages)
resource "aws_security_group" "wordpress-security-group" {
  name = var.security_group_name
  # Inbound Rules
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  # Outbound Rule
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "permit all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

# Assign public IP via Elastic IP to access the site
resource "aws_eip" "wp-public-ip" {
  instance = aws_instance.wordpress-instance.id
  vpc      = true
}

# Start an EC2 Instance to host the site
resource "aws_instance" "wordpress-instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = "wp-key"
  security_groups = [var.security_group_name]

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install git",
      "sudo amazon-linux-extras install docker",
      "sudo yum install docker",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "docker-compose version",
      "git clone https://github.com/Jeffrey-Chung/basic-wordpress-deployment",
      "echo $RANDOM > db_password.txt",
      "sudo docker-compose up -d"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/wp-key.pem")
      host        = aws_instance.wordpress-instance.public_ip
    }
  }
}

# Outputs the IP to access the site
output "WebServerIP" {
  value       = aws_instance.wordpress-instance.public_ip
  description = "Web Server IP Address"
}

# Runs the Wordpress site via Docker Compose
# Installs Git, Docker and Docker Compose 
resource "null_resource" "setup-wordpress" {


}