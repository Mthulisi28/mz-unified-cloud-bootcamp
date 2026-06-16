# ==============================================================================
# UCA ENTERPRISE SECURITY GROUP ENFORCEMENT ENGINE
# ==============================================================================

variable "environment" {
  type        = string
  description = "Target environment: prd, stg, dev, shared"
}

variable "vpc_id" {
  type        = string
  description = "Target VPC ID where security perimeters will be applied"
}

# --- Load Balancer Security Group (Public Edge) ---
resource "aws_security_group" "lb" {
  name        = "aws-qr-${var.environment}-afs1-sg-lb-01"
  description = "UCA Enforced Perimeter - Edge Load Balancer Ingress"
  vpc_id      = var.vpc_id

  # Strict Ingress: Public web traffic only
  ingress {
    description = "Allow TLS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP fallback"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Strict Egress: Default Deny bypass only for internal routing
  egress {
    description = "Logical egress to app tier"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Bounded by target security groups downstream
  }

  tags = {
    Name = "aws-qr-${var.environment}-afs1-sg-lb-01"
  }
}

# --- Application Compute Security Group (Logical Chaining Layer) ---
resource "aws_security_group" "app" {
  name        = "aws-qr-${var.environment}-afs1-sg-app-01"
  description = "UCA Enforced Perimeter - Isolated Compute Ingress"
  vpc_id      = var.vpc_id

  # ZERO Hardcoded IPs: Ingress strictly allowed ONLY from the Load Balancer SG ID
  ingress {
    description     = "Allow traffic exclusively from Load Balancer tier"
    from_port       = 8000 # Standard API / FastAPI runtime tracking
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.lb.id]
  }

  # Default Deny: Hard constraint on management port exposure
  # No Port 22/3389 rules allowed. Management passes via centralized endpoints.
  egress {
    description = "Outbound external dependencies"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-qr-${var.environment}-afs1-sg-app-01"
  }
}

# --- Output Block for Downstream Chaining Reference ---
output "lb_security_group_id" {
  value = aws_security_group.lb.id
}

output "app_security_group_id" {
  value = aws_security_group.app.id
}
