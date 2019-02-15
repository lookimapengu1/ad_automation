variable "tenancy_ocid" {}

variable "compartment_ocid" {}

variable "compartment_name" {
    default="c3e"
}

variable "defined_tags" {
    type="map"
    default={
        default.hub="austin"
        default.owner="allison.butler@oracle.com"
        default.project="ad-automation"
    }
}

variable "vcn_cidr_block" {
    default="10.200.0.0/16"
}

variable "vcn_name" {
    default="vcn01"
}

variable "subnet_cidr_blocks" {
    type = "list"
    default = [
        "10.200.0.0/25",
        "10.200.1.0/25",
    ]
}

variable "is_private" {
    type = "list"
    default = [
        false,
        true
    ]
}