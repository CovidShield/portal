###
# Global
###

region            = "ca-central-1"
billing_tag_key   = "CostCentre"
billing_tag_value = "CovidShield"

###
# AWS ECS - ecs.tf
###

# Portal
ecs_portal_name                              = "Portal"
ecs_task_portal_env_rails_env                = "production"
ecs_task_portal_env_rails_serve_static_files = "1"
# Comes from a Github secret
# ecs_task_portal_env_rails_master_key         = ""

###
# AWS RDS - rds.tf
###

# Portal
rds_portal_db_name = "portal"
rds_portal_db_user = "root"
# Comes from a Github secret
# rds_portal_db_password       = ""
rds_portal_allocated_storage = "5"
rds_portal_instance_class    = "db.t3.small"
