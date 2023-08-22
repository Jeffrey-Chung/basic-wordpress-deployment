# Security Group to allow traffic to and from the Internet (i.e. install and download packages)
resource "aws_security_group" "wordpress-security-group" {
    name = "wordpress-security-group"
    # Inbound Rules
    ingress{
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "allow ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        }
    ingress {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "allow http"
        from_port = 0
        to_port = 80
        protocol = "tcp"
        }
    # Outbound Rule
    egress{
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "permit all"
        from_port = 0
        to_port = 0
        protocol = "-1"
        }
}

# Assign public IP via Elastic IP to access the site
resource "aws_eip" "wp-public-ip" {
    instance = aws_instance.wordpress-instance.id
    vpc = true
}

# Start an EC2 Instance to host the site
resource "aws_instance" "wordpress-instance" {
    ami = "ami-080785a633a551d87"
    instance_type = "t2.micro"
    key_name = "wp-key"
    security_groups = [ "wordpress-security-group" ]
}

# Outputs the IP to access the site
output "WebServerIP" {
    value = aws_instance.wordpress-instance.public_ip
    description = "Web Server IP Address"
}