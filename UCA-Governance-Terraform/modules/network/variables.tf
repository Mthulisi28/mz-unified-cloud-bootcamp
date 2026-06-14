variable "project_id" {
  type        = string
  description = "The target Google Cloud Project ID where the network resources will be provisioned."
}

variable "network_name" {
  type        = string
  description = "The declarative name assigned to the core global VPC."
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "The target deployment region for the multi-tier subnets."
}

variable "web_cidr" {
  type        = string
  description = "The isolated IP CIDR block allocated exclusively to the public/ingress web-tier subnet."
}

variable "app_cidr" {
  type        = string
  description = "The private IP CIDR block allocated exclusively to the enterprise application-tier subnet."
}

variable "db_cidr" {
  type        = string
  description = "The isolated private IP CIDR block allocated exclusively to the backend database-tier subnet."
}
