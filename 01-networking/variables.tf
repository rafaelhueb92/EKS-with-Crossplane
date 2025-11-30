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
        Project = "eks-crossplane"
        Environment = "Production"
    }
}

variable "vpc" { 
    type = object({
        cidr = string
        name = string
        internet_gateway_name = string
        nat_gateway_name = string
        public_route_table_name = string
        private_route_table_name = string
        eip_name = string
        eks_cluster_name_tag = string
        public_subnets = list(object({
            name = string
            cidr_block = string
            availability_zone = string
            map_public_ip_on_launch = bool
        }))
        private_subnets = list(object({
            name = string
            cidr_block = string
            availability_zone = string
            map_public_ip_on_launch = bool
        }))
        observability_subnets = list(object({
            name = string
            cidr_block = string
            availability_zone = string
            map_public_ip_on_launch = bool
        }))
    })
    default = {
        cidr                     = "10.0.0.0/24"
        name                     = "crossplane-vpc"
        internet_gateway_name    = "crossplane-igw"
        nat_gateway_name         = "nat-gateway"
        public_route_table_name  = "public-route-table"
        private_route_table_name = "private-route-table"
        eip_name                 = "nat-gateway-eip"
        eks_cluster_name_tag     = "eks-crossplane-cluster"
        public_subnets = [{
            name = "crossplane-public-subnet-us-east-1a"
            cidr_block = "10.0.0.0/27"
            availability_zone = "us-east-1a"
            map_public_ip_on_launch = true
        },{
            name = "crossplane-public-subnet-us-east-1b"
            cidr_block = "10.0.0.64/27"
            availability_zone = "us-east-1b"
            map_public_ip_on_launch = true
        }]
        private_subnets = [{
            name = "crossplane-private-subnet-us-east-1a"
            cidr_block = "10.0.0.32/27"
            availability_zone = "us-east-1a"
            map_public_ip_on_launch = false
        },{
            name = "crossplane-private-subnet-us-east-1b"
            cidr_block = "10.0.0.96/27"
            availability_zone = "us-east-1b"
            map_public_ip_on_launch = false
        }]
        observability_subnets = [{
            name = "crossplane-observability-subnet-us-east-1a"
            cidr_block = "10.0.0.128/27"
            availability_zone = "us-east-1a"
            map_public_ip_on_launch = false
        },{
            name = "crossplane-observability-subnet-us-east-1b"
            cidr_block = "10.0.0.160/27"
            availability_zone = "us-east-1b"
            map_public_ip_on_launch = false
        }] 
    }
}