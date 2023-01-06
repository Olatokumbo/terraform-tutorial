variable "ec2-name" {
  type = string
}


variable "sg" {
  type = string
}

variable "user_data" {
  type = string
}

resource "aws_instance" "web" {
  ami             = "ami-084e8c05825742534"
  instance_type   = "t2.micro"
  security_groups = [var.sg]
  user_data       = var.user_data

  tags = {
    "Name" = var.ec2-name
  }
}


output "instance" {
  value = aws_instance.web.id
}
