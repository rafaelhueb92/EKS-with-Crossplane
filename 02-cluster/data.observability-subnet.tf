data "aws_subnets" "observability" {
  filter {
    name   = "map-public-ip-on-launch"
    values = [false]
  }

  filter {
    name   = "tag:Project"
    values = ["eks-crossplane"]
  }

  filter {
    name   = "tag:Purpose"
    values = ["Observability"]
  }
}