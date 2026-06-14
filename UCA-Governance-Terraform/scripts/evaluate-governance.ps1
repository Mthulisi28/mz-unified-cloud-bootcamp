
# UCA Governance Evaluator
$reportPath = "reports/Governance_Scorecard.md"
$scorecardTemplate = Get-Content "reports/scorecard-template.yaml" -Raw

# 1. Identity Audit: Check for service account keys older than 90 days
$oldKeys = gcloud iam service-accounts keys list --iam-account=uca-cicd-deployer@uca-infra-001.iam.gserviceaccount.com --format="json" | ConvertFrom-Json | Where-Object { ([datetime]::Parse($_.validAfterTime)) -lt (Get-Date).AddDays(-90) }

# 2. FinOps Audit: Check for untagged resources
$untaggedResources = gcloud asset search-all-resources --query="NOT labels:owner" --format="json" | ConvertFrom-Json

# 3. Generate Markdown Report
$report = @"
# UCA Governance Scorecard
Generated: $(Get-Date)

## Identity Governance
- Keys > 90 days: $($oldKeys.Count)

## FinOps Governance
- Untagged resources found: $($untaggedResources.Count)

## Status: $(if($oldKeys.Count -eq 0 -and $untaggedResources.Count -eq 0) {"PASS"} else {"FAIL"})
"@

$report | Out-File -FilePath $reportPath
Write-Host "Scorecard generated at $reportPath"

