# UCA Infrastructure Governance Linting Standard Matrix
fail_on_severe = true
style_check    = true

rule "aws_resource_missing_tags" {
  enabled  = true
  severity = "CRITICAL"
}
