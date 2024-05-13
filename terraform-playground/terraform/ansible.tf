locals {
  ansible_path = "../ansible/playbooks/configure-nginx.yml"
}

resource "terraform_data" "ansible" {
#   Changes to any instance of the cluster requires re-provisioning
#   triggers_replace = [
#     yandex_compute_instance.nginx_vm.id
#   ]

#   re-provision every time
  triggers_replace = timestamp()

  provisioner "remote-exec" {
    inline = ["sudo echo 'Hello'"]

    connection {
      type        = "ssh"
      user        = local.user_name
      host        = yandex_compute_instance.nginx_vm.network_interface.0.nat_ip_address
    }
  }

  provisioner "local-exec" {
    command = <<-EOF
      ansible-playbook -u ${local.user_name} --ssh-common-args='-o StrictHostKeyChecking=accept-new' \
      -i '${yandex_compute_instance.nginx_vm.network_interface.0.nat_ip_address},' ${local.ansible_path}
    EOF
  }
}