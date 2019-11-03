# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

# Identity and access parameters
variable "api_fingerprint" {
  description = "fingerprint of oci api private key"
}

variable "api_private_key_path" {
  description = "path to oci api private key"
}

variable "compartment_id" {
  type        = "string"
  description = "compartment id"
}

variable "tenancy_id" {
  type        = "string"
  description = "tenancy id"
}

variable "user_id" {
  type        = "string"
  description = "user id"
}

# ssh keys
variable "ssh_private_key_path" {
  description = "path to ssh private key"
}

variable "ssh_public_key_path" {
  description = "path to ssh public key"
}

# general oci parameters
variable "label_prefix" {
  type    = "string"
  default = "gitlab"
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "region"
  default     = "us-phoenix-1"
}

# networking parameters
variable "newbits" {
  type        = "map"
  description = "new mask for the subnet within the virtual network. use as newbits parameter for cidrsubnet function"

  default = {
    bastion = 13
    lb      = 11
    gitlab  = 2
  }
}

variable "vcn_cidr" {
  type        = "string"
  description = "cidr block of VCN"
  default     = "10.0.0.0/16"
}

variable "vcn_dns_label" {
  type    = "string"
  default = "gitlab"
}

variable "vcn_name" {
  type        = "string"
  description = "name of vcn"
  default     = "gitlab vcn"
}

# nat
variable "create_nat_gateway" {
  description = "whether to create a nat gateway"
  default     = true
}

# service gateway
variable "create_service_gateway" {
  description = "whether to create a service gateway"
  default     = true
}

variable "subnets" {
  description = "zero-based index of the subnet when the network is masked with the newbit."
  type        = "map"

  default = {
    bastion = 32
    lb      = 16
    gitlab  = 1
  }
}

# bastion
variable "bastion_shape" {
  description = "shape of bastion instance"
  default     = "VM.Standard.E2.1"
}

variable "create_bastion" {
  default = true
}

variable "bastion_access" {
  description = "cidr from where the bastion can be sshed into. Default is ANYWHERE and equivalent to 0.0.0.0/0"
  default     = "ANYWHERE"
}

variable "enable_instance_principal" {
  description = "enable the bastion hosts to call OCI API services without requiring api key"
  default     = false
}

variable "image_id" {
  default = "NONE"
}

# availability domains
variable "availability_domains" {
  description = "ADs where to provision compute resources"
  type        = "map"

  default = {
    bastion = 1
    gitlab  = 1
  }
}

# gitlab

variable "gitlab_shape" {
  description = "compute shape of gitlab instance"
  default     = "VM.Standard2.4"
}

variable "gitlab_url" {
  description = "url of gitlab"
  default     = "gitlab.oraclevcn.com"
}

# variable "gitlab_bastion" {
#   type = object({
#     bastion_public_ip      = string
#     #create_bastion         = bool
#     #image_operating_system = string
#   })
# }
variable "gitlab_ssh_keys" {
  type = object({
    ssh_private_key_path = string
    ssh_public_key_path  = string
  })
}

# variable "gitlab_oci_general" {
#   type = object({
#     #ad_names     = list(string)
#     label_prefix = string
#     region       = string
#   })
# }
# loadbalancer

#  variable "ad_names" {
  
#  }


# variable "lb_general" {
#   type = object({

#     label_prefix = string
#     ad_names = list(string)
#     vcn_id   = string
#     subnets  = map(number)
#     vcn_cidr = string
#     newbits  = map(number)
#     lb_shape = string
#   })
# }

# variable "lb_identity" {
#   type = object ({
#     compartment_id = string
#     # tenancy_id     = string
#     ssh_public_key_path = string
#   })
# }


variable "lb_shape" {
  description = "shape of load balancer"
  default     = "100Mbps"
}


#variables for base bastion
variable "oci_base_bastion" {
  type = object({
    availability_domains      = number
    bastion_access            = string
    bastion_image_id          = string
    bastion_upgrade           = bool
    bastion_shape             = string
    create_bastion            = bool
    enable_instance_principal = bool
    enable_notification       = bool
    newbits                   = number
    netnum                    = number
    notification_endpoint     = string
    notification_protocol     = string
    notification_topic        = string
    ssh_private_key_path      = string
    ssh_public_key_path       = string
    timezone                  = string
    use_autonomous            = bool
  })
  description = "bastion host parameters"
  default = {
    availability_domains      = 1
    bastion_access            = "ANYWHERE"
    bastion_image_id          = "NONE"
    bastion_shape             = "VM.Standard.E2.1"
    bastion_upgrade           = true
    create_bastion            = false
    enable_instance_principal = false
    enable_notification       = false
    newbits                   = 13
    netnum                    = 32
    notification_endpoint     = ""
    notification_protocol     = "EMAIL"
    notification_topic        = "bastion"
    ssh_private_key_path      = ""
    ssh_public_key_path       = ""
    timezone                  = ""
    use_autonomous            = false
  }
}
#dns

variable "dns_general" {
  type = object({
    create_dns_record = string
    dns_zone_name     = string
    dns_zone_domain   = string
  })
}

# variable "oci_base_general" {
#   type = object({
#     label_prefix = string
#     region       = string
#   })
# }
