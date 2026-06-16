# ==============================================================================
# UCA ENTERPRISE AUTOMATED IAM ROLE ENGINE MODULE
# ==============================================================================

variable "environment" {
  type        = string
  description = "Target environment: prd, stg, dev, shared"
}

variable "trusted_entity_arn" {
  type        = string
  description = "The centralized corporate identity provider or automation runner ARN allowed to assume this role"
}

# --- Assume Role Trust Policy Data Source ---
data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.trusted_entity_arn]
    }
    
    # Enforce MFA multi-factor validation condition context at runtime
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

# --- Enterprise Workload Execution Role ---
resource "aws_iam_role" "workload_execution" {
  name               = "aws-qr-${var.environment}-afs1-role-exec-01"
  description        = "UCA Enforced Role - Minimal permission boundary for active application mutations"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

# --- Strict Application Permission Definition (Least-Privilege Boundary) ---
resource "aws_iam_policy" "workload_permissions" {
  name        = "aws-qr-${var.environment}-afs1-policy-exec-01"
  description = "Strict least-privilege boundary limiting mutations to application state buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "UCABoundedS3ObjectAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::aws-qr-${var.environment}-afs1-data-01",
          "arn:aws:s3:::aws-qr-${var.environment}-afs1-data-01/*"
        ]
      }
    ]
  })
}

# --- Connect the Policy to the Exec Role ---
resource "aws_iam_role_policy_attachment" "workload_binding" {
  role       = aws_iam_role.workload_execution.name
  policy_arn = aws_iam_policy.workload_permissions.arn
}

# --- Output the Role ARN for App Configuration Insertion ---
output "workload_execution_role_arn" {
  value = aws_iam_role.workload_execution.arn
}
