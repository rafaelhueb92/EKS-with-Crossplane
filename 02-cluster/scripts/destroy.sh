terraform state rm kubernetes_namespace_v1.crossplane_system
terraform state rm kubernetes_service_account_v1.crossplane
terraform state rm helm_release.crossplane  
terraform destroy -auto-approve 