resource "helm_release" "crossplane" {
  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  namespace        = kubernetes_namespace_v1.crossplane_system.metadata[0].name
  create_namespace = false

  set {
    name  = "serviceAccount.create"
    value = "false"  # We're creating it separately above
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account_v1.crossplane.metadata[0].name
  }

  depends_on = [
    kubernetes_service_account_v1.crossplane,
    kubernetes_namespace_v1.crossplane_system # Ensure namespace is ready
  ]

}


