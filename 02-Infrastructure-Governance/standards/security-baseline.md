# UCA Infrastructure Security Baseline

## 1. Network Guardrails
- **Zero Hardcoded IPs**: Security group rules and firewall policies must reference logical Security Group IDs or Network Tags rather than hardcoded IPv4/IPv6 addresses.
- **Default Deny Model**: All ingress and egress paths default to an implicit drop; explicit allow-lists must be justified via architectural decision records.
- **Ingress Restrictions**: Port `22` (SSH) and Port `3389` (RDP) must never be exposed to `0.0.0.0/0`. Management paths must go through private endpoints or Bastion/IAP controls.

## 2. Identity & Access Guardrails
- **Zero Static Credentials**: Service accounts and IAM roles must never employ embedded access keys or permanent long-lived secret tokens.
- **Least-Privilege Baseline**: Cross-account interactions and workload processing execution must be bound strictly to assumed IAM roles with bounded permissions.
