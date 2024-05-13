output "nginx_internal_ip" {
  value = yandex_compute_instance.nginx_vm.network_interface.0.ip_address
}

output "nginx_external_ip" {
  value = yandex_compute_instance.nginx_vm.network_interface.0.nat_ip_address
}
