# UCA Architecture Baseline v1
*Unified Control Architecture (UCA) Governance Framework*

## Executive Summary
The UCA platform is a governance-first cloud operating model designed to transition from manual infrastructure deployment to an **Autonomous Governance Engine**. This document serves as the foundational artifact (v1) for the UCA consulting practice.

## 1. Governance KPI Framework (Target State)
| Domain | Key Performance Indicators (KPIs) |
| :--- | :--- |
| **Identity** | Zero long-lived credentials; 100% Workload Identity Federation; Least-privilege; Quarterly reviews. |
| **Infrastructure**| 100% IaC coverage; Zero drift; Standardized module architecture; Full environment isolation. |
| **Network** | Private-by-default; Zero public ingress; Segmented tiers; Centralized logging. |
| **Security** | Encryption by default; Public storage blocked; Policy-as-code enforcement. |
| **Logging** | 100% coverage; Centralized aggregation; 90-day retention; Compliance-ready audit trails. |
| **FinOps** | Mandatory tagging; Automated budget controls; Cost ownership mapping; Showback readiness. |
| **Landing Zone** | Shared services model; Policy-driven provisioning; Standardized project hierarchy. |
| **Executive** | Governance maturity scoring; Risk register lifecycle; Executive scorecard reporting. |

## 2. Platform Maturity: Current vs. Target
| Layer | Current State (Laboratory) | Target State (Platform) |
| :--- | :--- | :--- |
| **IaC Platform** | Terraform (Local State) | Terraform (Remote State/GitOps) |
| **Identity** | Project-scoped Service Accounts | WIF + OIDC + Dynamic Secrets |
| **Governance** | Immutable IAM Bindings | Automated Policy Engines (OPA/SCC) |
| **Landing Zone**| Project-based (4 projects) | Hub-and-Spoke Enterprise LZ |

## 3. Roadmap & Strategic Sprints
- **Sprint 1:** Centralize Terraform Remote State; Implement Workload Identity Federation (WIF).
- **Sprint 2:** Enforce Organization Policy constraints; FinOps labeling.
- **Sprint 3:** Automated drift detection; Executive Governance Scorecard.
