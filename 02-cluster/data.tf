data "aws_caller_identity" "current" {}

data "aws_vpc" "this" {
   filter {
    name   = "tag:Project"
    values = ["eks-express"]
  }
}