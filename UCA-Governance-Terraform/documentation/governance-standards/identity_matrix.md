# UNIFIED CONTROL ARCHITECTURE (UCA) — IDENTITY GOVERNANCE MATRIX
# VERSION: 1.0 | LEAST-PRIVILEGE STANDARD

## 1. AUTOMATION SERVICE IDENTITIES
To maintain absolute security boundaries, all infrastructure-as-code automation execution loops must bypass human credentials and bind explicitly to specialized programmatic identities.

| Service Account Identity Name | AWS Concept Match | Minimum Assigned GCP Roles | Specific Governance Purpose |
| :--- | :--- | :--- | :--- |
| `tf-net-deployer` | `Network-CI-CD-Role` | `roles/compute.networkAdmin` | Restricts automation to managing only VPCs, subnets, and routing rules. Cannot delete storage or read data databases. |
| `tf-state-manager` | `S3-State-Lock-Policy` | `roles/storage.objectAdmin` (Scoped) | Grants read/write access explicitly to the remote state bucket metadata paths. |

## 2. HUMAN RECOURSE BOUNDARY
* Human operators are explicitly barred from holding persistent project-owner status in production environments.
* Production modifications require automated pipeline execution through the tracked service accounts, establishing an unalterable git-backed cryptographic trail.
