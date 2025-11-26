variable "auth" {
    type = object({
        region = string
        assume_role_arn = string
    })

    default = {
        assume_role_arn = "arn:aws:iam::180294221572:role/WorkshopNaNuvemRole"
        region = "us-east-1"
    }
}

variable "tags" { 
    type = map(string)
    default = {
        Project = "eks-express"
        Environment = "Production"
    }
}


variable "eks_cluster" {
        type = object({
        name = string
        role_name = string
        version = string
        enabled_cluster_log_types = list(string)
        access_config = object({
            authentication_mode = string
        })
        node_group = object({
            name = string
            role_name = string
            instance_types = list(string)
            capacity_type = string
            ami_type = string
            scaling_config = object({
                max_size = number
                min_size = number
            desired_size = number
        })})
    })

        default = {
        name = "eks-express-cluster"
        role_name = "eks-express-role"
        version = "1.32"
        enabled_cluster_log_types = [
                "api",
                "audit",
                "authenticator",
                "controllerManager",
                "scheduler"
            ]
        access_config = {
            authentication_mode = "API_AND_CONFIG_MAP"
        }
        node_group = {
            name = "eks-express-node-group"
            role_name = "eks-express-node-grouprole"
            instance_types = [
                "t3.medium"
            ]
            capacity_type = "ON_DEMAND"
            ami_type = "AL2023_x86_64_STANDARD"
            scaling_config = {
                max_size     = 3
                min_size     = 3
                desired_size = 3
            }
        }
    }
}

variable "custom_domain" { 
    type = string
    default = "eks.express.com"
}