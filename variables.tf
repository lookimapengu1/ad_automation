variable "ssh_public_key" {}

variable "ssh_private_key" {}

data "local_file" "ubuntu-init" {
    filename = "./cloud-init/ubuntu_init.sh"
}

data "local_file" "windows-init-pub" {
    filename = "./cloud-init/windows_public_init.ps1"
}

data "local_file" "windows-init-pvt" {
    filename = "./cloud-init/windows_private_init.ps1"
}