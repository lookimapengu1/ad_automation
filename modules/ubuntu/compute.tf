resource "oci_core_instance" "ubuntu" {
    availability_domain = "${var.subnet_ad[0]}"
    count               = "${var.count["ubuntu"]}"
    compartment_id      = "${var.compartment_ocid}"
    display_name        = "${var.compartment_name}-${var.instance_name_ubuntu}${count.index}"
    shape               = "${var.instance_shape_ubuntu[count.index]}"

    create_vnic_details {
        subnet_id       = "${var.subnet_id[0]}"
        display_name    = "${var.instance_name_ubuntu}01"
        assign_public_ip = "${var.is_public_ubuntu[count.index]}"
        hostname_label  = "${var.compartment_name}${var.instance_name_ubuntu}01"
    }

    source_details {
        source_type  = "image"
        source_id       = "${var.ubuntu_image_ocid}"
    }

    metadata {
        ssh_authorized_keys = "${var.ssh_public_key}"
        #user_data           = "${var.cloud_init[0]}"
    }

    timeouts {
        create = "60m"
    }

    provisioner "local-exec" {
        command = "echo ${var.winvm1},${var.winvm2}"
    }
}

resource "null_resource" "config_script" {
    depends_on  = ["oci_core_instance.ubuntu"]

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update",
            "sudo apt-get install -y software-properties-common",
            "sudo apt-add-repository --y --update ppa:ansible/ansible",
            "sudo apt-get install -y ansible",
            "sudo apt-get install -y python-pip",
            "pip install \"pywinrm>=0.3.0\""    
        ]

        connection = {
            host = "${oci_core_instance.ubuntu.public_ip}"
            type = "ssh"
            user = "ubuntu"
            private_key = "${var.ssh_private_key}"
        }
    }

    provisioner "file" {
        source = "ansible/"
        destination = "/home/ubuntu/"

        connection = {
            host = "${oci_core_instance.ubuntu.public_ip}"
            type = "ssh"
            user = "ubuntu"
            private_key = "${var.ssh_private_key}"
        }
    }

    provisioner "remote-exec" {
        inline = [
            "ansible-playbook -i inventory.ini ad-setup.yaml"
        ]

        connection = {
            host = "${oci_core_instance.ubuntu.public_ip}"
            type = "ssh"
            user = "ubuntu"
            private_key = "${var.ssh_private_key}"
        }
    }
}
