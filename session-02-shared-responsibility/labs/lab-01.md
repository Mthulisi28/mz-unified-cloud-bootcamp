\# ◆ LAB — IAM + SECURITY GROUPS



\## Objective

Understand AWS access control and basic security configuration.



\---



\# ◆ PART 1 — IAM EXPLORATION



Go to AWS Console:

IAM → Users



Observe:

\- Users

\- Groups

\- Permissions



\---



\# ◆ PART 2 — SECURITY GROUPS



Go to:

EC2 → Security Groups



Observe:

\- Inbound rules

\- Outbound rules



\---



\# ◆ KEY LEARNING



IAM controls WHO can access AWS.



Security Groups control WHAT can access servers.



\---



\# ◆ WARNING EXAMPLE



Never allow:

0.0.0.0/0 on all ports



This means:

Everyone on the internet can access your server.

