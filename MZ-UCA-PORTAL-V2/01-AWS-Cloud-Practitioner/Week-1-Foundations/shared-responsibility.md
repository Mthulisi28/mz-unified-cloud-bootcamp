# [UCA-GRID] SESSION 02: SHARED RESPONSIBILITY & RISK GOVERNANCE
**Operational Track:** AWS Cloud Practitioner Bootcamp  
**Clearance Level Requirement:** CL-1 Foundation  
**Status:** [ UCA VERIFIED TEMPLATE ]

---

## 📑 Executive Study Notes: The Security Divide

In cloud governance, understanding the boundaries of liability prevents catastrophic enterprise data exposures. AWS operates on a strict model of split operational accountability.

### 🛡️ 1. Security OF the Cloud (AWS Responsibility)
AWS maintains sole physical and logical control over the global infrastructure layer. Customers have no entry or configuration rights here.
* **Physical Security:** Data center perimeters, biometric access controls, video surveillance.
* **Hardware Infrastructure:** Fleet management, server maintenance, storage blade disposal.
* **Software Overlay:** Host operating systems, virtualization layer hypervisors, core networking fabrics.

### 🔐 2. Security IN the Cloud (Customer Responsibility)
The customer retains complete ownership and configuration liability for anything deployed within their allocated AWS tenant space.
* **Data Layer:** Client-side encryption, asset classification, data protection controls.
* **Platform Configurations:** Network Access Control Lists (NACLs), Security Groups, OS patching of EC2 instances.
* **Identity Infrastructure:** IAM password policies, Multi-Factor Authentication (MFA) enforcement, user permission boundaries.

---

## 🧠 UCA GOVERNANCE EXAM SIMULATION BANK (SESSION 2)

#### 🗂️ Question 1: Architectural Liability Breakdown
An enterprise shifts a high-availability legacy application running on custom physical servers to Amazon EC2 instances. Under the AWS Shared Responsibility Model, which operational task remains the exclusive liability of the customer?
- [ ] A) Maintaining the hypervisor software layer virtualization engine.
- [ ] B) Replacing degraded physical memory drives inside the host blade server.
- [ ] C) Executing security updates and patches on the guest operating system.
- [ ] D) Managing the physical perimeter access control systems of the data center.
* **UCA Verified Answer Key:** C  
* **Governance Rationale:** AWS handles the physical hardware and the virtualization layer. The customer selects and runs the Guest OS, making them entirely responsible for its security updates, configuration, and patching.

#### 🗂️ Question 2: Managed Database Boundaries
A data architecture team deploys a production warehouse using Amazon RDS (Relational Database Service). Under the split accountability framework, what is AWS responsible for managing?
- [ ] A) Optimization of custom database indexes and query execution plans.
- [ ] B) Orchestration of underlying database engine patching and automated backups.
- [ ] C) Constructing the application-level tables and schema relationships.
- [ ] D) Setting up row-level security permissions for end-users.
* **UCA Verified Answer Key:** B  
* **Governance Rationale:** RDS is a managed service. AWS handles the maintenance, storage optimization, underlying database engine patching, and infrastructure backups, while the customer controls data ingestion and user permissions.

---
© 2026 MZ UCA Cloud Academy • Pan-African Enterprise Cloud Leadership Network
