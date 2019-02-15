output ip_addrs {
    value = "${oci_core_instance.windows.*.private_ip}"
}