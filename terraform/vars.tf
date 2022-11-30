variable "availability_zones" {
  description = "AZs in this region to use"
  default = ["us-east-2a", "us-east-2b"]
  type = list(string)
}

variable "vpc_cidr" {
  default = "10.0.10.0/24"
}

variable "subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = ["10.0.10.0/24"]
  type = list(string)
}

variable "subnet-tag" {
  description = "Tags for subnets to use"
  default = ["my-subnet-1"]
  type = list(string)
}

variable "instance-tag" {
  description = "Tags for instance to use"
  default = ["dev-server"]
  type = list(string)
}


variable "http-rule" {
  description = "port for sg"
  default = ["22", "8080"]
  type = list(string)
}

