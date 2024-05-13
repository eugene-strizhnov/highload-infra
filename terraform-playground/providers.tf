terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
  service_account_key_file = "key.json"
  folder_id = "b1gmhsfvn1db8j9dngg6"
}
