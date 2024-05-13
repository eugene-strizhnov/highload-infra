locals {
  ansible_cfg_path      = "../ansible/ansible.cfg"
  ansible_playbook_path = "../ansible/playbooks/configure.yml"
  web_path              = abspath("../web/")
  web_path_dist         = "${local.web_path}/build/"
}

resource "terraform_data" "ansible" {
  #   Changes to any instance of the cluster requires re-provisioning
  #   triggers_replace = [
  #     yandex_compute_instance.nginx_vm.id
  #   ]

  #   re-provision every time
  triggers_replace = timestamp()

  provisioner "local-exec" {
    command = <<-EOF
     npm install --prefix ${local.web_path} && \
     npm run build --prefix ${local.web_path}
    EOF
  }

  provisioner "remote-exec" {
    inline = ["sudo echo 'Hello'"]

    connection {
      type = "ssh"
      user = local.user_name
      host = yandex_compute_instance.nginx_vm.network_interface.0.nat_ip_address
    }
  }

  provisioner "local-exec" {
    command = <<-EOF
      export ANSIBLE_CONFIG=${local.ansible_cfg_path} && \
      ansible-playbook -u ${local.user_name} --ssh-common-args='-o StrictHostKeyChecking=accept-new' \
      -i '${yandex_compute_instance.nginx_vm.network_interface.0.nat_ip_address},' ${local.ansible_playbook_path} \
      --extra-vars 'web_build_path=${abspath(local.web_path_dist)}'
    EOF
  }
}