variable "tenancy_ocid" {}

variable "compartment_ocid" {}

variable "region" {}

variable "ssh_public_key" {}

variable "subnet_id" {
    type="list"
}

variable "subnet_ad" {
    type="list"
}

variable "cloud_init" {
    type="list"
}

variable "is_public_windows" {
    type = "list"
    default = [
        true,
        false,
        false
    ]
}

variable "count" {
    type = "map"
    default = {
        windows = "3"
    }
}

variable "compartment_name" {
    default = "c3e"
}

variable "instance_shape_windows" {
    type = "list"
    default = [
        "VM.Standard2.1",
        "VM.Standard2.2",
        "VM.Standard2.2"
    ]
}

variable "instance_name_windows" {
    type = "list"
    default = [
        "bastion",
        "addc",
        "vm"
    ]
}

variable private_ips {
    type = "list"
    default = [
        "10.200.0.2",
        "10.200.1.5",
        "10.200.1.10"
    ]
}

variable "windows_image_ocid" {
    default = "ocid1.image.oc1.iad.aaaaaaaawkckyvqfnv6hedvr3awxxsgczkwb2mtjyzzthcltr2pijeyy7ydq"
}
