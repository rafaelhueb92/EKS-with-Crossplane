resource "kubernetes_service_account_v1" "crossplane" {
  metadata {
    name      = "crossplane"
    namespace = "crossplane-system"

    annotations = {
      "meta.helm.sh/release-name"      = "crossplane"
      "meta.helm.sh/release-namespace" = "crossplane-system"
      # Add your IRSA annotation here:
      "eks.amazonaws.com/role-arn"     = aws_iam_role.crossplane.arn
    }

    labels = {
      "app"                           = "crossplane"
      "app.kubernetes.io/component"   = "cloud-infrastructure-controller"
      "app.kubernetes.io/instance"    = "crossplane"
      "app.kubernetes.io/managed-by"  = "Helm"
      "app.kubernetes.io/name"        = "crossplane"
      "app.kubernetes.io/part-of"     = "crossplane"
      "app.kubernetes.io/version"     = "2.1.1"
      "helm.sh/chart"                 = "crossplane-2.1.1"
    }
  }
}