terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "backend-tf-180294221572"
    key    = "platform-crossplane/networking/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }

}

# Configure the AWS Provider
provider "aws" {
  region = var.auth.region

  default_tags {
    tags = var.tags
  }

  assume_role {
    role_arn     = var.auth.assume_role_arn
  }
}