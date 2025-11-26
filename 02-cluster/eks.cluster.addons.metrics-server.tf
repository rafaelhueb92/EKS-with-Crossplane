resource "aws_eks_addon" "metric_server" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "metrics-server"
}