param (
    [int]$SecureScore,      # 0 to 100
    [int]$ResilientScore,   # 0 to 100
    [int]$HighPerfScore,    # 0 to 100
    [int]$CostOptScore      # 0 to 100
)

# Load Student SAA Configuration
$Config = Get-Content "./portal-config.json" | ConvertFrom-Json

# Calculate Weighted percentage
$WeightedPercentage = ($SecureScore * $Config.ExamDomains.Domain_1_Secure_Architectures) +
                      ($ResilientScore * $Config.ExamDomains.Domain_2_Resilient_Architectures) +
                      ($HighPerfScore * $Config.ExamDomains.Domain_3_High_Performing) +
                      ($CostOptScore * $Config.ExamDomains.Domain_4_Cost_Optimized)

# Scale to AWS Scoring System (100 - 1000)
$ScaledScore = [Math]::Round(100 + ($WeightedPercentage * 9), 0)
$Target = $Config.TargetPassingScore

if ($ScaledScore -ge $Target) {
    $Status = "EXAM_READY"
    $Action = "PROCEED_TO_VOUCHER_ISSUANCE"
} else {
    $Status = "REMEDIATION_REQUIRED"
    $Action = "TRIGGER_DOMAIN_REVIEW"
}

[PSCustomObject]@{
    ScaledScore = $ScaledScore
    TargetScore = $Target
    Status      = $Status
    Action      = $Action
}
