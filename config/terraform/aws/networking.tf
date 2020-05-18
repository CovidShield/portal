###
# AWS Security Groups
###

resource "aws_security_group" "covidshield_portal" {
  name        = "covidshield-portal"
  description = "Ingress - CovidShield Portal App"
  vpc_id      = data.terraform_remote_state.backend.outputs.vpc.id

  ingress {
    protocol  = "tcp"
    from_port = 3000
    to_port   = 3000
    security_groups = [
      data.terraform_remote_state.backend.outputs.security_group_load_balancer.id
    ]
  }

  tags = {
    (var.billing_tag_key) = var.billing_tag_value
  }
}

resource "aws_security_group" "covidshield_portal_database" {
  name        = "covidshield-portal-database"
  description = "Ingress - CovidShield Portal Database"
  vpc_id      = data.terraform_remote_state.backend.outputs.vpc.id

  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
    security_groups = [
      aws_security_group.covidshield_portal.id,
    ]
  }

  tags = {
    (var.billing_tag_key) = var.billing_tag_value
  }
}
