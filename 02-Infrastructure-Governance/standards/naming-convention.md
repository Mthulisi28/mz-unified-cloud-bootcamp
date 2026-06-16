# UCA Enterprise Naming Convention Standard

## 1. Core Format
All resource names must strictly adhere to the following global kebab-case format:
`[provider]-[project/bu]-[env]-[region]-[resource-type]-[index]`

## 2. Token Definitions
- **provider**: `gcp` or `aws`
- **project/bu**: Core application or business unit identifier (e.g., `qr` for QuickReserve)
- **env**: `prd` (Production), `stg` (Staging), `dev` (Development), `shared` (Shared Services)
- **region**: Standard shortcodes (e.g., `af-south-1` -> `afs1`, `europe-west1` -> `euw1`)
- **resource-type**: Canonical resource abbreviations (e.g., `vpc`, `sg`, `iam-role`, `sa`)
- **index**: Dynamic two-digit ordering baseline starting at `01`

## 3. Strict Examples
- AWS VPC (Production): `aws-qr-prd-afs1-vpc-01`
- GCP Cloud Run Service Account (Staging): `gcp-qr-stg-euw1-sa-02`
