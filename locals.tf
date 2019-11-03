# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

locals {
  oci_base_identity = {
    api_fingerprint      = var.api_fingerprint
    api_private_key_path = var.api_private_key_path
    compartment_id       = var.compartment_id
    tenancy_id           = var.tenancy_id
    user_id              = var.user_id
  }
  oci_base_general = {
    label_prefix = var.label_prefix
    region       = var.region

  }
  oci_base_vcn = {
    create_nat_gateway     = var.create_nat_gateway
    create_service_gateway = var.create_service_gateway
    vcn_cidr               = var.vcn_cidr
    vcn_dns_label          = var.vcn_dns_label
    vcn_name               = var.vcn_name
  }
  oci_base_bastion = {
    newbits                   = var.newbits["bastion"]
    subnets                   = var.subnets["bastion"]
    bastion_shape             = var.bastion_shape
    create_bastion            = var.create_bastion
    bastion_access            = var.bastion_access
    enable_instance_principal = var.enable_instance_principal
    #image_id                       = var.image_id
    availability_domains = var.availability_domains["bastion"]

    bastion_image_id      = var.oci_base_bastion["bastion_image_id"]
    bastion_upgrade       = var.oci_base_bastion["bastion_upgrade"]
    enable_notification   = var.oci_base_bastion["enable_notification"]
    newbits               = var.oci_base_bastion["newbits"]
    netnum                = var.oci_base_bastion["netnum"]
    notification_endpoint = var.oci_base_bastion["notification_endpoint"]
    notification_protocol = var.oci_base_bastion["notification_protocol"]
    notification_topic    = var.oci_base_bastion["notification_topic"]
    ssh_private_key_path  = var.oci_base_bastion["ssh_private_key_path"]
    ssh_public_key_path   = var.oci_base_bastion["ssh_public_key_path"]
    timezone              = var.oci_base_bastion["timezone"]
    use_autonomous        = var.oci_base_bastion["use_autonomous"]
  }


  gitlab_identity = {
    compartment_id = var.compartment_id
    tenancy_id     = var.tenancy_id
  }

  # gitlab_bastion = {
  #   bastion_public_ip      = module.base.bastion_public_ip
  #   #create_bastion         = var.create_bastion
  #   #image_operating_system = var.gitlab_bastion["image_operating_system"]
  # }

  bastion_public_ip = module.base.bastion_public_ip

  gitlab_network = {
    ig_route_id                = module.base.ig_route_id
    is_service_gateway_enabled = var.create_service_gateway
    nat_route_id               = module.base.nat_gateway_id
    newbits                    = var.newbits
    subnets                    = var.subnets
    vcn_cidr                   = var.vcn_cidr
    vcn_id                     = module.base.vcn_id
  }

  gitlab_config = {
    gitlab_shape = var.gitlab_shape
    gitlab_url   = var.gitlab_url
  }
  gitlab_ssh_keys = {
    ssh_private_key_path = var.ssh_private_key_path
    ssh_public_key_path  = var.ssh_public_key_path
  }

  gitlab_oci_general = {
    #ad_names     = module.base.ad_names
    label_prefix = var.label_prefix
    region       = var.region
  }

  lb_general = {
    label_prefix = var.label_prefix
    ad_names = module.base.ad_names
    vcn_id   = module.base.vcn_id
    subnets  = var.subnets
    vcn_cidr = var.vcn_cidr
    newbits  = var.newbits
    lb_shape = var.lb_shape
  }

  # lb_identity = {
  #   compartment_id = var.compartment_id
  #   # tenancy_id     = var.tenancy_id
  #   ssh_public_key_path = var.ssh_public_key_path
  # }

  #dns

  dns_general = {
    create_dns_record = var.dns_general["create_dns_record"]
    dns_zone_name     = var.dns_general["dns_zone_name"]
    dns_zone_domain   = var.dns_general["dns_zone_domain"]
  }

}


