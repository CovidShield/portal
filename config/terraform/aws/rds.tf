resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_db_instance" "covidshield" {
  identifier_prefix         = "portal"
  allocated_storage         = var.rds_portal_allocated_storage
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7"
  final_snapshot_identifier = "portal-${random_string.random.result}"
  skip_final_snapshot       = false
  instance_class            = var.rds_portal_instance_class
  name                      = var.rds_portal_db_name
  username                  = var.rds_portal_db_user
  password                  = var.rds_portal_db_password
  vpc_security_group_ids = [
    aws_security_group.covidshield_portal_database.id
  ]
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = data.terraform_remote_state.backend.outputs.aws_db_subnet_group.id

  tags = {
    Name                  = var.rds_portal_db_name
    (var.billing_tag_key) = var.billing_tag_value
  }
}
