# ==============================================================================
# UCA ENTERPRISE AUTOMATED VPC ENGINE MODULE
# ==============================================================================

variable "environment" {
  type        = string
  description = "Target environment: prd, stg, dev, shared"
}

variable "vpc_cidr" {
  type        = string
  description = "Deterministic non-overlapping CIDR block"
}

variable "public_subnets" {
  type        = list(string)
  description = "Explicit list of frontend public subnet CIDRs"
}

variable "private_subnets" {
  type        = list(string)
  description = "Explicit list of isolated backend compute subnet CIDRs"
}

# --- VPC Core Resource ---
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "aws-qr-${var.environment}-afs1-vpc-01"
  }
}

# --- Internet Gateway ---
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "aws-qr-${var.environment}-afs1-igw-01"
  }
}

# --- Public Subnet Layout ---
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-qr-${var.environment}-afs1-sub-pub-0${count.index + 1}"
  }
}

# --- Private Subnet Layout ---
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "aws-qr-${var.environment}-afs1-sub-priv-0${count.index + 1}"
  }
}

# --- Data Source for Multi-AZ Availability ---
data "aws_availability_zones" "available" {
  state = "available"
}
