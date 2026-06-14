# UNIFIED CONTROL ARCHITECTURE (UCA) — METADATA GOVERNANCE STANDARDS
# VERSION: 1.0 | ENTERPRISE TRACKING STANDARD

## 1. DECLARATIVE NAMING CONVENTION
All resources provisioned across global cloud footprints must comply strictly with the following deterministic format:
`[Org]-[Project]-[Environment]-[Region]-[Resource_Type]-[Index]`

* Example: `uca-quickreserve-prod-uscentral1-vpc-01`
* Example: `uca-quickreserve-dev-uscentral1-subnet-web-01`

## 2. MANDATORY RESOURCE TAGGING MATRIX
Every resource block must encapsulate the following metadata tags. Resources found without these tags are subject to automated programmatic termination via compliance clean-up scripts:

| Tag Key | Accepted Value Pattern | Purpose / FinOps Metric |
| :--- | :--- | :--- |
| `Organization` | `uca` | Identifies global root governance ownership |
| `Project` | Alpha-numeric string (e.g., `quickreserve`) | Cost-center tracking across business units |
| `Environment` | `dev` \| `test` \| `prod` | Guardrail validation and blast-radius filtering |
| `ManagedBy` | `terraform` | Segregates manual changes from automated state |
| `Owner` | Valid corporate email string | Direct structural accountability for billing alerts |

## 3. COMPLIANCE ENFORCEMENT
No code deployment pipeline will execute unless the Terraform layout verification step confirms presence of this metadata baseline.
