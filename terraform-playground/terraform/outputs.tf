output "webapp_url" {
  value = "http://${yandex_compute_instance.nginx_vm.network_interface.0.nat_ip_address}"
}
