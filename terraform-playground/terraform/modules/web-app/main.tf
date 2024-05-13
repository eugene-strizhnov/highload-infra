locals {
  web_path_dist = "${var.web_app_src}/build/"
}

resource "terraform_data" "build_web_app" {
  #   re-provision every time
  triggers_replace = timestamp()

  provisioner "local-exec" {
    command = <<-EOF
     npm install --prefix ${var.web_app_src} && \
     npm run dist --prefix ${var.web_app_src}
    EOF
  }
}