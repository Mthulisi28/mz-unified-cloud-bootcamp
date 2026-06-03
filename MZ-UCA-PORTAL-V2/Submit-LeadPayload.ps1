param (
    [string]$StudentName,
    [int]$SecureScore,      # 0-100
    [int]$ResilientScore,   # 0-100
    [int]$HighPerfScore,    # 0-100
    [int]$CostOptScore      # 0-100
)

# Execute the updated Student SAA engine
$Evaluation = .\Get-LEADScore.ps1 -SecureScore $SecureScore -ResilientScore $ResilientScore -HighPerfScore $HighPerfScore -CostOptScore $CostOptScore

Write-Output "=== EVALUATING BOOTCAMP STUDENT: $StudentName ==="
Write-Output "Scaled Exam Score : $($Evaluation.ScaledScore) / 1000 (Passing Target: $($Evaluation.TargetScore))"
Write-Output "Readiness Status  : $($Evaluation.Status)"

if ($Evaluation.Action -eq "PROCEED_TO_VOUCHER_ISSUANCE") {
    Write-Output "AUTOMATED ACTION  : Clear for Exam. Triggering Exam Voucher Delivery Route."
} else {
    Write-Output "AUTOMATED ACTION  : Flagged for Remediation. Routing to Targeted Domain Review."
}
Write-Output "========================================="
