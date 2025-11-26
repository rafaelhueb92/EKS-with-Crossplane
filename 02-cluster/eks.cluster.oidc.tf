resource "aws_iam_openid_connect_provider" "kubernetes" {
  url = local.eks_oidc

  client_id_list = [
    "sts.amazonaws.com",
  ]
  
}