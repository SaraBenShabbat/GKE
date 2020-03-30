module "kubernetes" {
  source = "./kubernetes"
  region = "us-central1"

  project_id_map = {
    default = "solid-justice-272605"
  }
}

output "connection-command" {
  value = "${module.kubernetes.connect-string}"
}
