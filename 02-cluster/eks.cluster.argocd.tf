resource "null_resource" "argocd_install" {
  triggers = {
    cluster_endpoint = aws_eks_cluster.this.endpoint
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Update kubeconfig to connect to EKS cluster
      aws eks update-kubeconfig --name ${aws_eks_cluster.this.name} --region ${var.auth.region}
      
      # Create argocd namespace
      kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
      
      # Install ArgoCD
      kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
      
      # Wait for ArgoCD to be ready
      kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

      kubectl apply -f ${path.module}/manifests/application.yml

    EOT
  }

  depends_on = [
    aws_eks_cluster.this,
    aws_eks_node_group.this 
  ]
}