resource "oci_core_security_list" "external_tf_security_list" {
    compartment_id  = "${var.compartment_ocid}"
    vcn_id          = "${oci_core_vcn.default_vcn.id}"
    display_name    = "${var.compartment_name}-${var.vcn_name}-sl01-external"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol    = "all"
    }

    ingress_security_rules {
        protocol    = "6"   //tcp
        source      = "0.0.0.0/0"
        stateless   = true

        tcp_options {
            "min" = 22
            "max" = 22
        }
    }

    ingress_security_rules {
        protocol    = "6"   //tcp
        source      = "0.0.0.0/0"
        stateless   = true

        tcp_options {
            "min" = 3389
            "max" = 3389
        }
    }

    ingress_security_rules {
        protocol    = "1"
        source      = "0.0.0.0/0"
        stateless   = true
    }
}

resource "oci_core_security_list" "internal_tf_security_list" {
    compartment_id  = "${var.compartment_ocid}"
    vcn_id          = "${oci_core_vcn.default_vcn.id}"
    display_name    = "${var.compartment_name}-${var.vcn_name}-sl02-internal"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol    = "all"
    }

    ingress_security_rules {
        source      = "10.200.1.0/25"
        protocol    = "all"
        stateless   = true
    }

    ingress_security_rules {
        source      = "10.200.0.0/25"
        protocol    = 6     //tcp
        stateless   = true

        tcp_options {
            "min" = 5985
            "max" = 5986
        }
    }

    ingress_security_rules {
        source      = "10.200.0.0/25"
        protocol    = 6     //tcp
        stateless   = true

        tcp_options {
            "min" = 3389
            "max" = 3389
        }
    }

    ingress_security_rules {
        source      = "10.200.0.0/25"
        protocol    = 6     //tcp
        stateless   = true

        tcp_options {
            "min" = 22
            "max" = 22
        }
    }

    ingress_security_rules {
        source      = "10.200.0.0/25"
        protocol    = "1"
        stateless   = true
    }
}