resource "oci_core_instance" "windows" {
    availability_domain = "${ var.is_public_windows[count.index] ? var.subnet_ad[0] : var.subnet_ad[1] }"
    count               = "${var.count["windows"]}"
    compartment_id      = "${var.compartment_ocid}"
    display_name        = "${var.compartment_name}-${var.instance_name_windows[count.index]}"
    shape               = "${var.instance_shape_windows[count.index]}"

    create_vnic_details {
        subnet_id           = "${var.is_public_windows[count.index] ? var.subnet_id[0] : var.subnet_id[1]}"
        display_name        = "${var.instance_name_windows[count.index]}01"
        assign_public_ip    = "${var.is_public_windows[count.index]}"
        hostname_label      = "${var.compartment_name}${var.instance_name_windows[count.index]}"
        private_ip  = "${var.private_ips[count.index]}"
    }

    source_details {
        source_type = "image"
        source_id   = "${var.windows_image_ocid}"
    }

    metadata {
        user_data   = "${var.is_public_windows[count.index] ? var.cloud_init[0] : var.cloud_init[1]}"
    }

    timeouts {
        create = "60m"
    }
}
