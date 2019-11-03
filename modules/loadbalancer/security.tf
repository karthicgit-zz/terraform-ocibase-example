#  Copyright 2017, 2019 Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  tcp_protocol  = "6"
  all_protocols = "all"

  anywhere = "0.0.0.0/0"

  http_port = "80"

  https_port = "443"

  health_check_port = "8060"
  ssh_port          = "22"
}
resource "oci_core_security_list" "load_balancer" {
  compartment_id = "${var.compartment_id}"
  display_name   = "${var.lb_general.label_prefix}-loadbalancer"
  vcn_id         = "${var.lb_general.vcn_id}"

#   egress_security_rules = [{
#     protocol    = "${local.all_protocols}"
#     destination = "${local.anywhere}"
# #   }]

egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }
ingress_security_rules {
    # http port
    protocol = local.tcp_protocol
    source   = local.anywhere

    tcp_options {
      min = local.http_port
      max = local.http_port
    }
  }

  ingress_security_rules {
    # http port
    protocol = local.tcp_protocol
    source   = local.anywhere

    tcp_options {
      min = local.https_port
      max = local.https_port
    }
  }
  ingress_security_rules {
    # http port
    protocol = local.tcp_protocol
    source   = local.anywhere

    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }

#   ingress_security_rules = [
#     {
#       # git over http. eliminate later when https is enabled.
#       protocol = "${local.tcp_protocol}"
#       source   = "${local.anywhere}"

#       tcp_options {
#         min = "${local.http_port}"
#         max = "${local.http_port}"
#       }
#     },
#     {
#       # git over https. to use later.
#       protocol = "${local.tcp_protocol}"
#       source   = "${local.anywhere}"

#       tcp_options {
#         "min" = "${local.https_port}"
#         "max" = "${local.https_port}"
#       }
#     },
#     {
#       # git over ssh
#       protocol = "${local.tcp_protocol}"
#       source   = "${local.anywhere}"

#       tcp_options {
#         "min" = "${local.ssh_port}"
#         "max" = "${local.ssh_port}"
#       }
#     },
#   ]
}
