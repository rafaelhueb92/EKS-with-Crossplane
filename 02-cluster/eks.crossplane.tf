
resource "helm_release" "crossplane" {
  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  namespace        = "crossplane-system"
  create_namespace = true

  values = [<<-EOF
    serviceAccount:
      create: true
      name: crossplane
      annotations:
        eks.amazonaws.com/role-arn: ${aws_iam_role.crossplane.arn}
  EOF
  ]

  depends_on = [
    aws_iam_role.crossplane,
    aws_iam_role_policy_attachment.crossplane_policy_attach
  ]

}


