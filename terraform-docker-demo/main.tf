variable "doc_name" {
  type    = string
  default = "deep124"
}

terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
  # backend "local" { }

  backend "s3" { }
}



provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = var.doc_name
  ports {
    internal = 80
    external = 8000
  }
}
