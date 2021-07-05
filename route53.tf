data "aws_route53_zone" "selected" {
  zone_id = var.zone_id
}


resource "aws_route53_record" "domain" {
  zone_id = var.zone_id
  name    = format("%s.%s", var.subdomain_name, data.aws_route53_zone.selected.name)
  type    = "A"

  alias {
    name                   = aws_lb.application_load_balancer.dns_name
    zone_id                = aws_lb.application_load_balancer.zone_id
    evaluate_target_health = true
  }
}