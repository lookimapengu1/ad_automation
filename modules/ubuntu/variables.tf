variable "tenancy_ocid" {}

variable "compartment_ocid" {}

variable "region" {}

variable "ssh_public_key" {}

variable "ssh_private_key" {}

variable "winvm1" {}

variable "winvm2" {}

variable "subnet_id" {
    type="list"
}

variable "subnet_ad" {
    type="list"
}

variable "cloud_init" {
    type="list"
}

variable "is_public_ubuntu" {
    type = "list"
    default = [
        true
    ]
}

variable "count" {
    type = "map"
    default = {
        ubuntu = "1"
    }
}

variable "compartment_name" {
    default = "c3e"
}

variable "instance_shape_ubuntu" {
    type = "list"
    default = [
        "VM.Standard2.1"
    ]
}

variable "instance_name_ubuntu" {
    default = "ansible"
}

variable "instance_name_windows" {
    type = "list"
    default = [
        "bastion",
        "addc",
        "vm"
    ]
}

variable "ubuntu_image_ocid" {
    default = "ocid1.image.oc1.iad.aaaaaaaacn5bhbdhtoe2znltxohjdmiif5tq2j3dtr7lczxrjizy5cq75s2q"
}

