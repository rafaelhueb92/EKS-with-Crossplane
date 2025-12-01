resource "helm_release" "crossplane" {
  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  namespace        = "crossplane-system"
  create_namespace = true

  set {
      name  = "serviceAccount.create"
      value = true
  }

  set{
      name  = "serviceAccount.name"
      value = "crossplane"
  }

  depends_on = [
    aws_iam_role.crossplane,
    aws_iam_role_policy_attachment.crossplane_policy_attach,
    kubernetes_service_account_v1.crossplane
  ]

}


