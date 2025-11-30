
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

  set {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.crossplane.arn
  }
  
}
