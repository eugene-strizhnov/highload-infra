locals {
  nginx_vm_prefix = "nginx"
  user_name = "ubuntu"
}

resource "yandex_compute_disk" "nginx_disk" {
  name     = "${local.nginx_vm_prefix}-disk"
  type     = "network-hdd"
  size     = "20"
  zone     = var.zone
  image_id = var.compute_image_id
}

resource "yandex_compute_instance" "nginx_vm" {
  name = local.nginx_vm_prefix

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.nginx_disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "_user_doesnt_matter_:${file(var.public_ssh_key_path)}"
  }
}

resource "yandex_vpc_network" "network_1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet_1" {
  name           = "subnet1"
  zone           = var.zone
  network_id     = yandex_vpc_network.network_1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
