# MZ UCA Cloud Academy - AWS Solutions Architect Associate (SAA)
## Module: Identity & Access Management (IAM)
**Instructor:** Zulu Mthulisi (Cloud Governance Architect)

### 📌 Core Architecture & Learning Framework

#### 1. What is AWS IAM?
* **Definition:** Identity and Access Management is the primary security gatekeeper of AWS infrastructure.
* **Authentication:** Answers the core question: *"Who are you?"*
* **Authorization:** Answers the core question: *"What are you allowed to do?"*

#### 2. IAM Identity Components
* **IAM Users:** Represents a unique individual identity (e.g., Siya, Vusi, Oageng, Zongezile). Architecture Best Practice: *One person, one account, one identity.*
* **IAM Groups:** A collection of users to simplify permission deployment and inheritance at scale.
* **IAM Roles:** Provides temporary, secure credentials. Essential for service-to-service permissions (e.g., EC2 to S3, Lambda to DynamoDB) and cross-account or federated access.

#### 3. Policy Evaluation Logic & Decision Engine
* **Policy Components:** * *Effect:* Allow or Deny
  * *Action:* What specific API operation can be done
  * *Resource:* Which AWS resource is targeted
* **CRITICAL CERTIFICATION RULE:** **Explicit Deny Always Wins.** Even if an explicit allow statement exists elsewhere, a single explicit deny statement instantly overrides all permissions to secure the asset.

#### 4. The Principle of Least Privilege
* Enforce cloud financial and security governance by provisioning **only** the minimum API permissions required to perform a specific task.

---
*Building Architects. Establishing Governance. Creating Leaders.*
