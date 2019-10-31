output "gitlab_public_ip" {
  description = "public IP address of bastion host"
  value       = join(",", data.oci_core_vnic.gitlab_vnic.*.public_ip_address)
}

output "gitlab_private_ip" {
  value = data.oci_core_vnic.gitlab_vnic.*.private_ip_address
}


