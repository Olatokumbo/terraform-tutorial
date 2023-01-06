provider "aws" {
  access_key  = var.aws_access_key_id
  secret_key =  var.aws_secret_access_key
  region = var.aws_region
}


resource "aws_vpc" "terraformVPC" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "terraformVPC"
  }
}

resource "aws_instance" "myEC2" {
    ami = "ami-01b8d743224353ffe"
    instance_type = "t2.micro"
}