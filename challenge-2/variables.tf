variable "aws_access_key_id" {
  type = string
  sensitive = true
}


variable "aws_secret_access_key" {
  type = string
  sensitive = true
}

variable "aws_region" {
  type = string
  default = "eu-west-2"
}

variable "ports" {
  type = list(number)
  default = [ 80, 443 ]
}
