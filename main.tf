module "network" {
    source = "./modules/network"
    tenancy_ocid = "${var.tenancy_ocid}"
    compartment_ocid = "${var.compartment_ocid}"
}

module "windows" {
    source              = "./modules/windows"
    tenancy_ocid        = "${var.tenancy_ocid}"
    compartment_ocid    = "${var.compartment_ocid}"

    region              = "${var.region}"

    ssh_public_key      = "${var.ssh_public_key}"
    cloud_init          = ["${base64encode(data.local_file.windows-init-pub.content)}","${base64encode(data.local_file.windows-init-pvt.content)}"]

    subnet_id           = ["${module.network.subnets_id[0]}","${module.network.subnets_id[1]}"]
    subnet_ad           = ["${module.network.subnets_ad[0]}","${module.network.subnets_ad[1]}"]
}


module "ubuntu" {
    source              = "./modules/ubuntu"
    tenancy_ocid        = "${var.tenancy_ocid}"
    compartment_ocid    = "${var.compartment_ocid}"

    region              = "${var.region}"

    ssh_public_key      = "${var.ssh_public_key}"
    ssh_private_key     = "${var.ssh_private_key}"
    
    cloud_init          = ["${base64encode(data.local_file.ubuntu-init.content)}"]

    subnet_id           = ["${module.network.subnets_id[0]}"]  
    subnet_ad           = ["${module.network.subnets_ad[0]}"]

    winvm1              = "${module.windows.ip_addrs[1]}"
    winvm2              = "${module.windows.ip_addrs[2]}"
}
