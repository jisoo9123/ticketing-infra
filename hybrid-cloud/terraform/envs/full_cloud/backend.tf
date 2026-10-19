terraform {
  backend "s3" {
    bucket       = "ticketrail-tfstate-20261026"
    key          = "full_cloud/terraform.tfstate"
    region       = "ap-northeast-2"
    encrypt      = true
    use_lockfile = true
  }
}
