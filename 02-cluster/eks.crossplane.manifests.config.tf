resource "kubernetes_namespace_v1" "crossplane_system" {
  metadata {
    name = "crossplane-system"
  }
}

resource "kubernetes_service_account_v1" "crossplane" {
  metadata {
    name      = "crossplane"
    namespace = "crossplane-system"

    annotations = {
      "meta.helm.sh/release-name"      = "crossplane"
      "meta.helm.sh/release-namespace" = "crossplane-system"
      "eks.amazonaws.com/role-arn"     = aws_iam_role.crossplane.arn
    }

    labels = {
      "app"                           = "crossplane"
      "app.kubernetes.io/component"   = "cloud-infrastructure-controller"
      "app.kubernetes.io/instance"    = "crossplane"
      "app.kubernetes.io/managed-by"  = "Helm"
      "app.kubernetes.io/name"        = "crossplane"
      "app.kubernetes.io/part-of"     = "crossplane"
    }
  }

  depends_on = [
    aws_eks_cluster.this,
    aws_eks_node_group.this,
    kubernetes_namespace_v1.crossplane_system
  ]

}

resource "null_resource" "crossplane_aws_runtime_config" {
  triggers = {
    role_arn = aws_iam_role.crossplane.arn
    manifest_hash = md5(jsonencode({
      apiVersion = "pkg.crossplane.io/v1beta1"
      kind       = "DeploymentRuntimeConfig"
      metadata = {
        name = "aws-irsa-config"
      }
      spec = {
        serviceAccountTemplate = {
          metadata = {
            annotations = {
              "eks.amazonaws.com/role-arn" = aws_iam_role.crossplane.arn
            }
          }
        }
      }
    }))
  }

  provisioner "local-exec" {
    command = <<-EOT
      cat <<EOF | kubectl apply -f -
      apiVersion: pkg.crossplane.io/v1beta1
      kind: DeploymentRuntimeConfig
      metadata:
        name: aws-irsa-config
      spec:
        serviceAccountTemplate:
          metadata:
            annotations:
              eks.amazonaws.com/role-arn: ${aws_iam_role.crossplane.arn}
      EOF
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete deploymentruntimeconfig aws-irsa-config --ignore-not-found=true"
  }

  depends_on = [
    helm_release.crossplane
  ]
}