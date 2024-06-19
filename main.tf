terraform {
  cloud {
    organization = "tomiwa-terraform-bootcamp-2023"

    workspaces {
      name = "cloud-resume-challenge"
    }
  }
}

module "cloud-resume" {
  source = "./modules-cloud-resume"
  bucket_name = var.bucket_name
  content_version = var.content_version
  table_name = var.table_name
  hash_key = var.hash_key
  function_name = var.function_name
}