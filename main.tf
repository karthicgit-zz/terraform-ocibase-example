module "base" {
  source = "./modules/base"

  # identity
  oci_base_identity = local.oci_base_identity

  # ssh keys
  #oci_base_ssh_keys = local.oci_base_ssh_keys

  # general oci parameters
  oci_base_general = local.oci_base_general

  # vcn parameters
  oci_base_vcn = local.oci_base_vcn

  # bastion parameters
  oci_base_bastion = local.oci_base_bastion

}
module "gitlab" {
  source = "./modules/gitlab"

  gitlab_identity = local.gitlab_identity

  # since they have the same signature, we can reuse that
  #gitlab_ssh_keys = local.oci_base_ssh_keys
  gitlab_ssh_keys = local.gitlab_ssh_keys
  #gitlab_oci_general = local.oci_base_general
  gitlab_oci_general = local.gitlab_oci_general

  #gitlab_bastion = local.gitlab_bastion

  gitlab_network = local.gitlab_network

  gitlab_config = local.gitlab_config

  bastion_ips = module.base.bastion_public_ip
}


module "loadbalancer" {
  source      = "./modules/loadbalancer"
  lb_identity = local.lb_identity
  lb_general  = local.lb_general
  dns_general = local.dns_general

  ig_route_id = module.base.ig_route_id
  
  gitlab_ip = module.gitlab.gitlab_private_ip

}
