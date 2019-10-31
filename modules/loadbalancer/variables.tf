#  Copyright 2017, 2019 Oracle Corporation and/or affiliates.  All rights reserved.

variable "lb_general" {
  type = object({
    
    label_prefix = string
    ad_names = list(string)
    vcn_id   = string
    vcn_cidr = string
    newbits  = map(number)
    subnets  = map(number)
    lb_shape = string
  })
}
variable "lb_identity" {
  type = object({
    compartment_id = string
    # tenancy_id     = string
    ssh_public_key_path = string
  })
}
# variable "compartment_ocid" {}

# variable "tenancy_ocid" {}

# variable "label_prefix" {}

# variable "vcn_id" {}

# variable "subnets" {
#   type = "map"
# }

# variable "vcn_cidr" {}

# variable "newbits" {
#   type = "map"
# }

# variable "ad_names" {
#   type = "list"
# }

# variable "availability_domains" {
#   type = "map"
# }

variable ig_route_id {}

# load balancer

#variable lb_shape {}

variable gitlab_ip {}

# dns


variable "dns_general" {
  type = object({
    create_dns_record = string
    dns_zone_name     = string
    dns_zone_domain   = string
  })
}


