[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateScript({Test-Path $_})]
    [string]$ConfigPath
)

process {
    try {
        $Topology = Get-Content -Raw -Path $ConfigPath | ConvertFrom-Json
        $Report = [System.Collections.Generic.List[PSCustomObject]]::new()

        foreach ($OU in $Topology.OrganizationalUnits) {
            $Status = [PSCustomObject]@{
                OUName        = $OU.Name
                GuardrailsTag = if ($null -ne $OU.ServiceControlPolicies -and $OU.ServiceControlPolicies.Count -gt 0) { "COMPLIANT" } else { "NON-COMPLIANT" }
                IAMSecurity   = if ($OU.CrossAccountRole -eq "EnterpriseAdmin-DoNotDelete") { "SECURED" } else { "EXPOSED" }
                Timestamp     = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            }
            $Report.Add($Status)
        }

        $MarkdownOutput = [System.Text.StringBuilder]::new()
        [void]$MarkdownOutput.AppendLine("# Enterprise Cloud Governance Report`n")
        [void]$MarkdownOutput.AppendLine("| Organizational Unit | SCP Status | IAM Boundary | Last Verified |")
        [void]$MarkdownOutput.AppendLine("|---|---|---|---|")

        foreach ($Row in $Report) {
            [void]$MarkdownOutput.AppendLine("| $($Row.OUName) | $($Row.GuardrailsTag) | $($Row.IAMSecurity) | $($Row.Timestamp) |")
        }

        return @{ RawData = $Report; MarkdownSchema = $MarkdownOutput.ToString() }
    }
    catch {
        Write-Error "Critical engine failure: $_"
        throw
    }
}
