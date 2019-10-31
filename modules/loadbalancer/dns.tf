resource "oci_dns_record" "record-a" {
  zone_name_or_id = "${var.dns_general.dns_zone_name}"
  domain          = "${var.dns_general.dns_zone_domain}"
  rtype           = "A"
  rdata           = "${oci_load_balancer.lb.ip_address_details.0.ip_address}"
  ttl             = 3600
  count = "${(var.dns_general.create_dns_record == "true") ? "1" : "0"}"
}

resource "oci_dns_record" "record-txt" {
  zone_name_or_id = "${var.dns_general.dns_zone_name}"
  rtype           = "TXT"
  rdata           = "gitlab"
  domain          = "${var.dns_general.dns_zone_domain}"
  ttl             = 86400
  count = "${(var.dns_general.create_dns_record == "true") ? "1" : "0"}"
}
