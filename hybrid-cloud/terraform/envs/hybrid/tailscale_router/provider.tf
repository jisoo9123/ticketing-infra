provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      project     = "ticketrail"
      environment = "hybrid"
      owner       = "jisu"
      managed_by  = "terraform"
      expires     = "2026-10-31"
    }
  }
}
