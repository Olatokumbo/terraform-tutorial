provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.aws_region
}


resource "aws_security_group" "rds" {
  name        = "terraform_rds_security_group"
  description = "Terraform example RDS MySQL server"
  # Keep the instance private by only allowing traffic from the web server.
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
  }
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-example-rds-security-group"
  }
}

resource "random_password" "db_password" {
  length = 16
  special = true
}

resource "aws_db_instance" "myRDS" {
  db_name = "myDB"
  username = var.db_username
  password = random_password.db_password.result
  identifier = "my-first-rds"
  instance_class = "db.t2.micro"
  engine               = "mysql"
  engine_version       = "5.7"
  allocated_storage = 10
  skip_final_snapshot = true
  vpc_security_group_ids = [ aws_security_group.rds.id ]
}

output "DB_PASSWORD" {
  value = random_password.db_password.result
}