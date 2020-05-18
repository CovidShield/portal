###
# Route53 Record - Portal
###

resource "aws_route53_record" "covidshield_portal" {
  zone_id = data.terraform_remote_state.backend.outputs.route53_zone.zone_id
  name    = "portal.${data.terraform_remote_state.backend.outputs.route53_zone.name}"
  type    = "A"

  alias {
    name                   = aws_lb.covidshield_portal.dns_name
    zone_id                = aws_lb.covidshield_portal.zone_id
    evaluate_target_health = false
  }
}
