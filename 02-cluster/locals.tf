locals {
    bash_user_arn    = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/workshop-out-user"
    console_user_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/devops-user"
    eks_oidc_url     = replace(aws_eks_cluster.this.identity[0].oidc[0].issuer,"https://","")
    eks_oidc         = aws_eks_cluster.this.identity[0].oidc[0].issuer
}