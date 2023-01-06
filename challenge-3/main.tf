# Modularize Challenge Two 
provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.aws_region
}
module "security_group" {
  source = "./modules/sg"
}


module "db" {
  source   = "./modules/db"
  sg       = module.security_group.sg_name
  ec2-name = "DB Server"
}

module "webServer" {
  source    = "./modules/web"
  sg        = module.security_group.sg_name
  ec2-name  = "WEB Server"
  user_data = file("server-script.sh")
}

module "eip" {
  source   = "./modules/eip"
  instance = module.webServer.instance
}

output "publicIP" {
  value = module.eip.publicIP
}
