terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone                     = var.zone
  service_account_key_file = var.account_key_file
  folder_id                = var.folder_id
}
