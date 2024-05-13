locals {
  ansible_cfg_path      = "${var.ansible_location}/ansible.cfg"
  ansible_playbook_path = "${var.ansible_location}/playbooks/configure.yml"
}

resource "terraform_data" "ansible" {
  #   re-provision every time
  triggers_replace = timestamp()


  provisioner "remote-exec" {
    inline = ["sudo echo 'Connecting ... '"]

    connection {
      type = "ssh"
      user = var.ssh_user
      host = var.server_ip
    }
  }

  provisioner "local-exec" {
    command = <<-EOF
      export ANSIBLE_CONFIG=${local.ansible_cfg_path} && \
      ansible-playbook -u ${var.ssh_user} --ssh-common-args='-o StrictHostKeyChecking=accept-new' \
      -i '${var.server_ip},' ${local.ansible_playbook_path} \
      --extra-vars 'web_build_path=${var.web_app}'
    EOF
  }
}