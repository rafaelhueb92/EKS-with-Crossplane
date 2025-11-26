resource "aws_iam_role" "external_dns" {
  name = "external-dns"
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
                 "${local.eks_oidc_url}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
                 "${local.eks_oidc_url}:aud" = "sts.amazonaws.com"
               
          }
        }
      },
    ]
  })
}

resource "aws_iam_policy" "external_dns" {
  name        = "ExternalDNSIAMPolicy"
  description = "Policy for the ExternalDNS operator"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
            "route53:ChangeResourceRecordSets",
            "route53:ListResourceRecordSets",
            "route53:ListTagsForResources"
        ]
        Resource =  ["arn:aws:route53:::hostedzone/*"]
      },
      {
        "Effect": "Allow",
        "Action": [
          "route53:ListHostedZones"
        ],
        "Resource": ["*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  policy_arn = aws_iam_policy.external_dns.arn
  role       = aws_iam_role.external_dns.name
}