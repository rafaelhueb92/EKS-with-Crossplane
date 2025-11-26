
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.container_storage_interface.arn
}


resource "aws_iam_role" "container_storage_interface" {
  name = "AmazonEKS_EBS_CSI_DriverRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRoleWithWebIdentity"
        ]
        Effect = "Allow"
        Principal = {
          Federated =  aws_iam_openid_connect_provider.kubernetes.arn
        }
        Condition = {
          StringEquals = {
            "${local.eks_oidc_url}:aud" = "sts.amazonaws.com"
            "${local.eks_oidc_url}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "container_storage_interface" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.container_storage_interface.name
}