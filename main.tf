resource “aws_security_group” “wordpress-security-group” {
    name = "wordpress-security-group"
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
    egress{
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "permit all"
        from_port = 0
        to_port = 0
        protocol = "-1"
        }
}

resource “aws_eip” “wp-public-ip” {
    instance = aws_instance.wordpress-instance.id
    vpc = true
}

resource “aws_instance” “wordpress-instance” {
    ami = "ami-010aff33ed5991201"
    instance_type = "t2.micro"
    key_name = "wp-key"
    security_groups = [ "wordpress-security-group" ]
}

output “WebServerIP” {
    value = aws_instance.wordpressfrontend.public_ip
    description = "Web Server IP Address"
}