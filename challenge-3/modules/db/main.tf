variable "ec2-name" {
  type = string
}


variable "sg" {
  type = string
}

resource "aws_instance" "db" {
  ami             = "ami-084e8c05825742534"
  instance_type   = "t2.micro"
  security_groups = [var.sg]

  tags = {
    "Name" = var.ec2-name
  }
}
