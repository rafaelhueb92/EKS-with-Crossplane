resource "aws_iam_role" "crossplane" {
  name = "crossplane-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.kubernetes.arn
        }
        Condition = {
          StringEquals = {
                 "${local.eks_oidc_url}:sub" = "system:serviceaccount:crossplane-system:provider-aws-*"
                 "${local.eks_oidc_url}:aud" = "sts.amazonaws.com"
               
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "crossplane_policy_attach" {
  role       = aws_iam_role.crossplane.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" 
}