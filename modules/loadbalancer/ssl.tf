resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm = "${tls_private_key.ca.algorithm}"
  private_key_pem = "${tls_private_key.ca.private_key_pem}"

  subject {
    common_name = "Indophile Gitlab"
    organization = "Indophile Gitlab"
  }

  validity_period_hours = 43800
  is_ca_certificate = true

  allowed_uses = [
    "key_encipherment",
    "server_auth",
    "client_auth",
    "cert_signing"
  ]
  dns_names = ["${var.dns_general.dns_zone_name}"]
}

resource "tls_private_key" "gitlab" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "tls_cert_request" "gitlab" {
  key_algorithm = "${tls_private_key.gitlab.algorithm}"
  private_key_pem = "${tls_private_key.gitlab.private_key_pem}"

  subject {
    common_name = "${var.dns_general.dns_zone_domain}"
    organization = "Indophile Gitlab"
  }

  dns_names = ["${var.dns_general.dns_zone_domain}"]
}

resource "tls_locally_signed_cert" "gitlab" {
  cert_request_pem = "${tls_cert_request.gitlab.cert_request_pem}"

  ca_key_algorithm = "${tls_private_key.ca.algorithm}"
  ca_private_key_pem = "${tls_private_key.ca.private_key_pem}"
  ca_cert_pem = "${tls_self_signed_cert.ca.cert_pem}"

  validity_period_hours = 43800

  allowed_uses = [
    "key_encipherment",
    "server_auth",
    "client_auth",
    "digital_signature",
  ]
}

resource "local_file" "cacert" {
  depends_on = ["tls_self_signed_cert.ca"]
  content    = "${tls_self_signed_cert.ca.cert_pem}"
  filename   = "${path.root}/generated/cacert.pem"
}

resource "local_file" "gitlab" {
  depends_on = ["tls_locally_signed_cert.gitlab"]
  content    = "${tls_locally_signed_cert.gitlab.cert_pem}"
  filename   = "${path.root}/generated/gitlab.pem"
}

resource "local_file" "ca_private_key" {
  depends_on = ["tls_private_key.ca"]
  content    = "${tls_private_key.ca.private_key_pem}"
  filename   = "${path.root}/generated/ca_private_key.pem"
}

resource "local_file" "gitlab_private_key" {
  depends_on = ["tls_locally_signed_cert.gitlab"]
  content    = "${tls_private_key.gitlab.private_key_pem}"
  filename   = "${path.root}/generated/gitlab_private_key.pem"
}

resource "local_file" "ca_public_key" {
  depends_on = ["tls_private_key.ca"]
  content    = "${tls_private_key.ca.public_key_pem}"
  filename   = "${path.root}/generated/ca_public_key.pem"
}

resource "local_file" "gitlab_public_key" {
  depends_on = ["tls_locally_signed_cert.gitlab"]
  content    = "${tls_private_key.gitlab.public_key_pem}"
  filename   = "${path.root}/generated/gitlab_public_key.pem"
}
