variable "account_key_file" {
  type        = string
  default     = "../tf-key.json"
  description = "key file, used for the access to YC"
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "YC zone to deploy resources"
}

variable "folder_id" {
  type        = string
  default     = "b1gmhsfvn1db8j9dngg6"
  description = "YC folder id"
}

variable "compute_image_id" {
  type        = string
  default     = "fd80bm0rh4rkepi5ksdi"
  description = "image id for the compute instance"
}

variable "public_ssh_key" {
  type        = string
  default = null
  description = "Public SSH key for user"
}

variable "users" {
  type = set(object({
    name                = string
    ssh-authorized-keys = list(string)
  }))
  default     = null
  description = "set of users which will have ssh access to the vm"
}
