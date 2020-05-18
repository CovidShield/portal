###
# Global
###
variable "region" {
  type = string
}

variable "billing_tag_key" {
  type = string
}

variable "billing_tag_value" {
  type = string
}

###
# AWS ECS - ecs.tf
###
# Task Portal
variable "ecs_portal_name" {
  type = string
}

variable "ecs_task_portal_env_rails_env" {
  type = string
}

variable "ecs_task_portal_env_rails_serve_static_files" {
  type = string
}

variable "ecs_task_portal_env_rails_bootstrap" {
  type    = string
  default = "0"
}

variable "ecs_task_portal_env_rails_master_key" {
  type = string
}


###
# AWS RDS - rds.tf
###
# RDS DB - Portal
variable "rds_portal_db_name" {
  type = string
}

variable "rds_portal_db_user" {
  type = string
}

variable "rds_portal_db_password" {
  type = string
}

variable "rds_portal_allocated_storage" {
  type = string
}

variable "rds_portal_instance_class" {
  type = string
}
