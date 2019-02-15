output "vcn_id" {
    value = "${oci_core_vcn.default_vcn.id}"
}

output "subnets_id" {
  value = "${oci_core_subnet.subnets.*.id}"
}

output "subnets_ad" {
  value = "${oci_core_subnet.subnets.*.availability_domain}"
}