variable "public_ssh_key_path" {
  type        = string
  description = "Public SSH key for user"
}

variable "account_key_file_path" {
  type        = string
  description = "key file, used for the access to YC"
}

variable "folder_id" {
  type        = string
  description = "YC folder id"
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "YC zone to deploy resources"
}

variable "compute_image_id" {
  type        = string
  default     = "fd80bm0rh4rkepi5ksdi"
  description = "image id for the compute instance"
}
