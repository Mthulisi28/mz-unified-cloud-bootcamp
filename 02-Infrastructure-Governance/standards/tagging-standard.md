# UCA Global Tagging & Labeling Standard

## 1. Mandatory Metadata Keys
Every resource MUST possess the following exact keys:

| Key | Example Value | Purpose |
| :--- | :--- | :--- |
| `uca:owner` | `governance-engine` | Operational tracking and system accountability |
| `uca:environment`| `production` | Scope isolation and blast-radius filtering |
| `uca:business-unit`| `core-tech` | Corporate cost alignment |
| `uca:application` | `quickreserve` | Direct application workload attribution |
| `uca:cost-center` | `cc-global-01` | Financial reconciliation alignment |

## 2. Enforcement Logic
- **IaC Layer**: Terraform / OpenTofu providers must inject these via `default_tags` or project-level labels.
- **Runtime Layer**: Non-compliant resources are automatically flagged by security baseline modules for programmatic termination.
