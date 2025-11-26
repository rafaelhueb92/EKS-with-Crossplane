data "terraform_remote_state" "cluster_stack" {
    backend = "s3"

    config = {
        bucket = "not-so-simple-ecommerce-terraform-state-files-180294221572"
        key    = "cluster/terraform.tfstate"
        region = "us-east-1"
        use_lockfile = true
    }
}