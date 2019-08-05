provider "ovirt" {
  username = "${var.ovirt_username}" 
  url      = "http://rhev-m.semperti.local/ovirt-engine/api"
  password = "${var.ovirt_pass}"
}

resource "ovirt_vm" "my_vm_1" {
  name       = "sre-bootcamp-ga-app"
  cluster_id = "default"

  memory = 2048 # in MiB
  sockets = 2

  initialization {
    authorized_ssh_key = "${file(pathexpand("~/.ssh/id_rsa.pub"))}"

    nic_configuration {
      label      = "eth0"
      boot_proto = "dhcp"
    }

  }

  template_id = "CentOS7-Template"
}

resource "ovirt_vnic" "nic1" {
  name            = "nic1"
  vm_id           = "${ovirt_vm.my_vm_1.id}"
  vnic_profile_id = "${ovirt_vnic_profile.vm_vnic_profile.id}"
}

resource "ovirt_vnic_profile" "vm_vnic_profile" {
  name           = "vm_vnic_profile"
  network_id     = "rhevm"
  migratable     = true
  port_mirroring = true
}
