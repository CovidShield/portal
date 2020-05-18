###
# AWS LB - Portal
###

resource "aws_lb_target_group" "covidshield_portal" {
  name                 = "covidshield-portal"
  port                 = 3000
  protocol             = "HTTP"
  target_type          = "ip"
  deregistration_delay = 30
  # May need to use a ternary here if TF doesn't like the fact aws_vpc resource may not exist
  vpc_id = data.terraform_remote_state.backend.outputs.vpc.id

  health_check {
    enabled             = true
    interval            = 10
    path                = "/services/ping"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name                  = "covidshield-portal"
    (var.billing_tag_key) = var.billing_tag_value
  }
}

resource "aws_lb" "covidshield_portal" {
  name               = "covidshield-portal"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    data.terraform_remote_state.backend.outputs.security_group_load_balancer.id
  ]
  subnets = data.terraform_remote_state.backend.outputs.aws_public_subnets.*.id

  tags = {
    Name                  = "covidshield-portal"
    (var.billing_tag_key) = var.billing_tag_value
  }
}

resource "aws_lb_listener" "covidshield_portal" {
  depends_on = [
    aws_acm_certificate.covidshield,
    aws_route53_record.covidshield_certificate_validation,
    aws_acm_certificate_validation.covidshield,
  ]

  load_balancer_arn = aws_lb.covidshield_portal.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = aws_acm_certificate.covidshield.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.covidshield_portal.arn
  }
}
