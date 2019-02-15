resource "oci_core_vcn" "default_vcn" {
    cidr_block      = "${var.vcn_cidr_block}"

    compartment_id  = "${var.compartment_ocid}"
    dns_label       = "${var.compartment_name}${var.vcn_name}"
    display_name    = "${var.compartment_name}-${var.vcn_name}"

    defined_tags    = "${var.defined_tags}"
}

resource "oci_core_internet_gateway" "ig" {
    compartment_id  = "${var.compartment_ocid}"
    display_name    = "${var.compartment_name}-${var.vcn_name}-ig"
    vcn_id          = "${oci_core_vcn.default_vcn.id}"
}

resource "oci_core_nat_gateway" "ng" {
    compartment_id  = "${var.compartment_ocid}"
    vcn_id          = "${oci_core_vcn.default_vcn.id}"

    block_traffic   = "false"
    display_name    = "${var.compartment_name}-${var.vcn_name}-natg"

}