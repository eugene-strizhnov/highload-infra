variable "ansible_location" {
  type        = string
  description = "location of ansible sources"
}

variable "server_ip" {
  type        = string
  description = "IP address to install nginx on"
}

variable "ssh_user" {
  type        = string
  description = "usernames used to connect server"
}

variable "web_app" {
  type        = string
  description = "location of built web-app"
}