locals {
  ansible_path = "../ansible/playbooks/configure-nginx.yml"
}

resource "terraform_data" "ansible" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers_replace = [
    yandex_compute_instance.nginx_vm.id
  ]

  provisioner "remote-exec" {
    inline = ["sudo echo 'Hello'"]

    connection {
      type        = "ssh"
      user        = local.user_name
#      private_key = file(var.private_ssh_key_path)
      host        = yandex_compute_instance.nginx_vm.network_interface.0.nat_ip_address
    }
  }

  provisioner "local-exec" {
    command = <<-EOF
      ansible-playbook -u ${local.user_name} \
      -i ${yandex_compute_instance.nginx_vm.network_interface.0.nat_ip_address} ${local.ansible_path}
    EOF
  }
}