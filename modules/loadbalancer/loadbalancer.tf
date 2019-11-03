resource "oci_load_balancer" "lb" {
  shape          = "${var.lb_general.lb_shape}"
  compartment_id = "${var.compartment_id}"

  subnet_ids = [
    "${oci_core_subnet.publiclb_subnet.id}",
      ]

  display_name = "${var.lb_general.label_prefix}-loadbalancer"
  is_private   = false
}

resource "oci_load_balancer_certificate" "gitlab_certificate" {
    #Required
    certificate_name = "GitLab"
    load_balancer_id = "${oci_load_balancer.lb.id}"

    #Optional
    ca_certificate = "${tls_self_signed_cert.ca.cert_pem}"
    private_key = "${tls_private_key.gitlab.private_key_pem}"
    public_certificate = "${tls_locally_signed_cert.gitlab.cert_pem}"

    lifecycle {
        create_before_destroy = true
    }
}

resource "oci_load_balancer_backend_set" "bs_gitlab" {
  name             = "backendset-gitlab"
  load_balancer_id = "${oci_load_balancer.lb.id}"
  policy           = "ROUND_ROBIN"

  health_checker {
    interval_ms         = 10000
    port                = 443
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/nginx_status"
  }

  ssl_configuration {
    #Required
    certificate_name = "${oci_load_balancer_certificate.gitlab_certificate.certificate_name}"

    verify_peer_certificate = false
  }
}


resource "oci_load_balancer_hostname" "hostname_gitlab" {
  #Required
  hostname         = "${var.dns_general.dns_zone_domain}"
  load_balancer_id = "${oci_load_balancer.lb.id}"
  name             = "lab"
}

resource "oci_load_balancer_backend" "be_gitlab" {
  load_balancer_id = "${oci_load_balancer.lb.id}"
  backendset_name  = "${oci_load_balancer_backend_set.bs_gitlab.name}"
  ip_address       = "${var.gitlab_ip}"
  port             = 443
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_listener" "https_listener" {
  load_balancer_id         = "${oci_load_balancer.lb.id}"
  name                     = "https"
  default_backend_set_name = "${oci_load_balancer_backend_set.bs_gitlab.name}"
  port                     = 443
  protocol                 = "HTTP"

  ssl_configuration {
    certificate_name        = "${oci_load_balancer_certificate.gitlab_certificate.certificate_name}"
    verify_peer_certificate = false
  }
}
