data "aws_route53_zone" "selected" {
  name = "fabricio.stdev.xyz"
}

resource "aws_route53_record" "domain" {
  zone_id = data.aws_route53_zone.zone_id
  name = format("%s.%s", var.subdomain_name, data.aws_route53_zone.selected.name)
}