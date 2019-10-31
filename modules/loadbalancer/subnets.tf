#  Copyright 2017, 2019 Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_subnet" "publiclb_subnet" {
  
  cidr_block                 = cidrsubnet(var.lb_general.vcn_cidr, var.lb_general.newbits["lb"], var.lb_general.subnets["lb"])
  display_name               = "${var.lb_general.label_prefix}-lb"
  compartment_id             = var.lb_identity.compartment_id
  vcn_id                     = var.lb_general.vcn_id
  route_table_id             = var.ig_route_id
  security_list_ids          = [oci_core_security_list.load_balancer.id]
  dns_label                  = "lb"
  prohibit_public_ip_on_vnic = false
  #count                      = var.lb_general.create_lb == true ? 1 : 0
}

