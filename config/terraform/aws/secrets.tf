###
# AWS Secret Manager - Portal
###

resource "aws_secretsmanager_secret" "portal_database_url" {
  name = "portal-database-url"
}

resource "aws_secretsmanager_secret_version" "portal_database_url" {
  secret_id     = aws_secretsmanager_secret.portal_database_url.id
  secret_string = "mysql2://${var.rds_portal_db_user}:${var.rds_portal_db_password}@${aws_db_instance.covidshield.endpoint}/${var.rds_portal_db_name}"
}

resource "aws_secretsmanager_secret" "portal_env_rails_master_key" {
  name = "portal-env-rails-master-key"
}

resource "aws_secretsmanager_secret_version" "portal_env_rails_master_key" {
  secret_id     = aws_secretsmanager_secret.portal_env_rails_master_key.id
  secret_string = var.ecs_task_portal_env_rails_master_key
}
