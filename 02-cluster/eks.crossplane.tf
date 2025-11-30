
resource "helm_release" "crossplane" {
  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  namespace        = "crossplane-system"
  create_namespace = true

  set {
      name  = "clusterName"
      value = aws_eks_cluster.this.id
  }

  set {
      name  = "serviceAccount.create"
      value = true
  }

  set {
      name  = "region"
      value = var.auth.region
  }
  
  set {
      name  = "vpcId"
      value = data.aws_vpc.this.id
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
