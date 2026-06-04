# [UCA-GRID] SESSION 03: IDENTITY & ACCESS MANAGEMENT (IAM) IDENTITY CONTROLS
**Operational Track:** AWS Cloud Practitioner Bootcamp  
**Clearance Level Requirement:** CL-1 Foundation  
**Status:** [ UCA VERIFIED TEMPLATE ]

---

## 📑 Executive Study Notes: AAA Security Framework

Identity and Access Management (IAM) is the primary software-defined perimeter protecting enterprise infrastructure assets. Access governance relies on a zero-trust architecture.

### 🛡️ The Architecture of IAM Components
1. **IAM Users:** Permanent long-term identities assigned to individual humans or automated services requiring console or programmatic interaction.
2. **IAM Groups:** Logical collections of IAM Users. Permissions are assigned to the group, ensuring uniform privilege distribution across teams.
3. **IAM Roles:** Short-term, ephemeral identities that can be dynamically assumed by users, applications, or external AWS resources. Uses temporary security tokens instead of static passwords.
4. **IAM Policies:** Explicit JSON text documents detailing precise permissions (Allow/Deny) mapped against AWS Resource ARNs.

### 🚨 Core Governance Directive: The Principle of Least Privilege
> **"An identity must only be granted the absolute minimum operational access necessary to execute its specific business function, and nothing more."**

---

## 🧠 UCA GOVERNANCE EXAM SIMULATION BANK (SESSION 3)

#### 🗂️ Question 1: Root Credentials Protocol
A junior cloud administrator requests the permanent access keys for the AWS Account Root User to establish a continuous integration deployment pipeline. What is the correct architectural decision according to AWS governance best practices?
- [ ] A) Generate the keys immediately and assign them full administrative rights.
- [ ] B) Deny the request, lock down the root user with hardware MFA, and create an isolated IAM Role with scoped-down permissions for the deployment pipeline.
- [ ] C) Issue the access keys but set an automated calendar reminder to change the password every 90 days.
- [ ] D) Share the root console login credentials via an encrypted internal channel.
* **UCA Verified Answer Key:** B  
* **Governance Rationale:** The Root Account has unrestricted control over billing and resource deletion. It should never be used for programmatic actions or daily administrative work. Secure it with MFA and use limited-privilege IAM Roles instead.

---
© 2026 MZ UCA Cloud Academy • Pan-African Enterprise Cloud Leadership Network
