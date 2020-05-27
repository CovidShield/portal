###
# Global
###

region = "ca-central-1"
# Enable the new ARN format to propagate tags to containers
billing_tag_key   = "CostCentre"
billing_tag_value = "CovidShield"

###
# AWS ECS - ecs.tf
###

# Portal
ecs_portal_name                              = "Portal"
ecs_task_portal_env_rails_env                = "production"
ecs_task_portal_env_rails_serve_static_files = "1"
# Value should come from an TF_VAR environment variable (e.g. set in a Github Secret)
# ecs_task_portal_env_rails_master_key         = ""

###
# AWS RDS - rds.tf
###

# Portal
rds_portal_db_name = "portal"
rds_portal_db_user = "root"
# Value should come from an TF_VAR environment variable (e.g. set in a Github Secret)
# rds_portal_db_password       = ""
rds_portal_allocated_storage = "5"
rds_portal_instance_class    = "db.t3.small"
