resource "oci_core_route_table" "external_tf_route_table" {
    compartment_id          = "${var.compartment_ocid}"
    vcn_id                  = "${oci_core_vcn.default_vcn.id}"
    display_name            = "${var.compartment_name}-${var.vcn_name}-rt01-external"

    route_rules {
        destination         = "0.0.0.0/0"
        network_entity_id   = "${oci_core_internet_gateway.ig.id}"
    }
}

resource "oci_core_route_table" "internal_tf_route_table" {
    compartment_id          = "${var.compartment_ocid}"
    vcn_id                  = "${oci_core_vcn.default_vcn.id}"
    display_name            = "${var.compartment_name}-${var.vcn_name}-rt02-internal"

    route_rules {
        destination         = "0.0.0.0/0"
        network_entity_id   = "${oci_core_nat_gateway.ng.id}"
    }
}
