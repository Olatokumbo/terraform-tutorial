provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.aws_region
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_instance" "webServer" {
  ami             = "ami-084e8c05825742534"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
  user_data = file("server-script.sh")
  tags = {
    "Name" = "WEB Server"
  }
}


resource "aws_instance" "db" {
  ami             = "ami-084e8c05825742534"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
  tags = {
    "Name" = "DB Server"
  }
}


resource "aws_eip" "web_ip" {
  instance = aws_instance.webServer.id
}


output "privateIP" {
  value = aws_instance.db.private_ip
}

output "publicIP" {
  value = aws_eip.web_ip.public_ip
}
