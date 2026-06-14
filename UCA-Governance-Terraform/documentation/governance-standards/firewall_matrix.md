# UNIFIED CONTROL ARCHITECTURE (UCA) — FIREWALL GOVERNANCE MATRIX
# VERSION: 1.0 | EDGE TRAFFIC CONTROLS

## 1. ZERO-TRUST INGRESS EDGE DESIGN
All ingress paths are explicitly denied by default. Traffic promotion across tiers is governed strictly using target network tags.

| Rule Name | Source Filter | Target Tag (Destination) | Protocol/Port | Governance Action |
| :--- | :--- | :--- | :--- | :--- |
| `allow-lb-to-web` | `0.0.0.0/0` (or WAF Range) | `uca-web-ingress` | TCP / `80`, `443` | Permits public internet traffic exclusively to edge proxy/load balancers. |
| `allow-web-to-app` | Tag: `uca-web-ingress` | `uca-app-engine` | TCP / `8080` | Restricts application tier ingress to traffic originating from verified web proxies. |
| `allow-app-to-db` | Tag: `uca-app-engine` | `uca-db-storage` | TCP / `5432` (Postgres) | Locks down database storage tier to accept requests only from the application compute instances. |

## 2. EXPLICIT ADMINISTRATIVE ACCESS GUARDRAILS
* Direct SSH (`22`) or RDP (`3389`) ingress from the public internet to any internal workload tag is permanently blocked.
* Administrative maintenance access must route through a dedicated Identity-Aware Proxy (IAP) endpoint tunnel or verified secure enterprise bastion systems.
