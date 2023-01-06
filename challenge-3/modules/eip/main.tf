variable "instance" {
  type = string
}

resource "aws_eip" "eip" {
  instance = var.instance
}


output "publicIP" {
  value = aws_eip.eip.public_ip
}