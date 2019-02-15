resource "oci_core_subnet" "subnets" {
    availability_domain         = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index % 3], "name")}"
    count                       = "${length(var.subnet_cidr_blocks)}"
    cidr_block                  = "${var.subnet_cidr_blocks[count.index]}"
    display_name                = "${var.compartment_name}-${var.vcn_name}-ad${count.index%3}-sn${count.index}" 
    dns_label                   = "ad${count.index%3}sn${count.index}"
    compartment_id              = "${var.compartment_ocid}"
    vcn_id                      = "${oci_core_vcn.default_vcn.id}"
    security_list_ids           = ["${ var.is_private[count.index] ? oci_core_security_list.internal_tf_security_list.id : oci_core_security_list.external_tf_security_list.id }"]
    prohibit_public_ip_on_vnic  = "${var.is_private[count.index]}"
    route_table_id              = "${ var.is_private[count.index] ? oci_core_route_table.internal_tf_route_table.id : oci_core_route_table.external_tf_route_table.id }"
    dhcp_options_id             = "${oci_core_vcn.default_vcn.default_dhcp_options_id}"
}