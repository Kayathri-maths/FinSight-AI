# FinSight AI — Complete Project Design

## 1. Project Overview

**Project Name:** FinSight AI

**Project Type:** Intelligent FinTech Operations & Risk Intelligence Platform

FinSight AI is an enterprise-style FinTech platform designed to combine traditional software engineering, machine learning, document intelligence, LLMs, Retrieval-Augmented Generation (RAG), AI agents, analytics, and background processing into one practical product.

The platform is designed for internal FinTech operations teams such as risk analysts, fraud/operations teams, compliance teams, support teams, and administrators.

The project will be developed incrementally. The first versions will use synthetic data and local/open-source components wherever practical so that development can begin with minimal cost.

---

# 2. Problem Statement

FinTech platforms generate large amounts of transactional, customer, merchant, payment, refund, chargeback, and operational data.

Operations teams may need to:

- identify potentially risky transactions
- investigate unusual activity
- understand customer and merchant behavior
- analyze chargebacks
- process operational documents
- search internal policies and documentation
- generate reports
- answer questions using company knowledge
- connect information from multiple systems
- maintain audit trails
- process background jobs reliably

Traditional dashboards can display information, but they do not necessarily provide intelligent analysis or natural-language interaction.

FinSight AI aims to provide a single platform where structured FinTech data, machine learning, documents, knowledge retrieval, and AI-assisted investigation can work together.

---

# 3. Project Objectives

The main objectives are:

1. Build a production-style FinTech application.
2. Implement a relational financial data model.
3. Build an ML-based transaction risk prediction system.
4. Implement anomaly detection.
5. Add document upload and document intelligence.
6. Build a RAG-based knowledge assistant.
7. Build an AI investigation assistant/agent.
8. Add natural-language analytics.
9. Add chargeback intelligence.
10. Add AI-generated operational reports.
11. Implement authentication and role-based authorization.
12. Maintain audit logs.
13. Implement asynchronous processing using Redis and BullMQ.
14. Add model and AI evaluation.
15. Add monitoring and operational visibility.
16. Deploy the application.
17. Document architecture, decisions, APIs, database design, AI design, and setup.

---

# 4. Target Users

## 4.1 Risk Analyst

Responsibilities:

- review risky transactions
- investigate suspicious activity
- inspect risk scores
- review anomalies
- examine evidence
- create investigations

## 4.2 Operations Analyst

Responsibilities:

- monitor transactions
- review failures
- analyze refunds
- monitor settlements
- generate operational reports

## 4.3 Compliance Analyst

Responsibilities:

- review customer/merchant information
- search internal policies
- inspect documents
- review audit records
- support investigations

## 4.4 Support User

Responsibilities:

- search customer information
- inspect transaction history
- understand transaction failures
- search internal knowledge

## 4.5 Administrator

Responsibilities:

- manage users
- manage roles
- manage permissions
- review audit logs
- monitor system health

---

# 5. Major Modules

The platform will contain the following modules:

1. Authentication & Authorization
2. Customer Management
3. Merchant Management
4. Wallet Management
5. Transaction Management
6. Payment Management
7. Refund Management
8. Chargeback Management
9. Settlement Management
10. Risk Prediction
11. Anomaly Detection
12. Document Management
13. Document Intelligence
14. RAG Knowledge Assistant
15. AI Investigation Agent
16. Natural Language Analytics
17. Chargeback Intelligence
18. AI Reports
19. Audit & Monitoring
20. Background Jobs
21. AI Evaluation
22. System Administration

---

# 6. Proposed Technology Stack

## Frontend

- React
- TypeScript
- Vite
- Tailwind CSS
- React Router
- Redux Toolkit where required
- shadcn/ui or equivalent component system
- Data grids/charts where required

## Application Backend

- Node.js
- Express.js
- TypeScript
- REST APIs
- Authentication and authorization
- PostgreSQL access
- Redis integration
- BullMQ integration

## AI/ML Service

- Python
- FastAPI
- scikit-learn
- XGBoost where useful
- pandas
- NumPy
- model evaluation libraries
- LLM integration
- embedding models

## Database

- PostgreSQL
- pgvector

## Cache / Queue

- Redis
- BullMQ

## Storage

Object/file storage for:

- PDF
- DOCX
- XLSX
- CSV
- images
- other supported documents

PostgreSQL stores document metadata rather than the binary files themselves.

## Development Tools

- VS Code
- Git
- GitHub
- Git Bash
- PostgreSQL tools
- Python virtual environment
- npm

## Deployment

Initially develop locally.

Later:

- Docker
- frontend hosting
- backend hosting
- Python AI service hosting
- PostgreSQL hosting
- Redis hosting
- object storage

---

# 7. High-Level Architecture

```text
                         ┌─────────────────────────┐
                         │        React UI         │
                         │   React + TypeScript     │
                         └────────────┬────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────┐
                         │     Node.js Backend     │
                         │   Express + TypeScript  │
                         └────────────┬────────────┘
                                      │
                ┌─────────────────────┼─────────────────────┐
                │                     │                     │
                ▼                     ▼                     ▼
        ┌───────────────┐      ┌───────────────┐    ┌───────────────┐
        │  PostgreSQL   │      │    Redis      │    │ Object Storage│
        │ + pgvector    │      │ + BullMQ      │    │   Documents   │
        └───────┬───────┘      └───────┬───────┘    └───────────────┘
                │                      │
                │                      ▼
                │              ┌───────────────┐
                │              │    Workers    │
                │              │ Background    │
                │              │ Processing    │
                │              └───────┬───────┘
                │                      │
                ▼                      ▼
        ┌─────────────────────────────────────────┐
        │            Python AI Service             │
        │                FastAPI                   │
        │                                         │
        │  ML │ Anomaly │ LLM │ RAG │ Agents     │
        └─────────────────────────────────────────┘
```

---

# 8. Repository Structure

```text
FinSight-AI/
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── ...
│
├── backend/
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── middleware/
│   │   ├── routes/
│   │   ├── services/
│   │   ├── repositories/
│   │   ├── validators/
│   │   ├── utils/
│   │   └── app.ts
│   ├── package.json
│   └── ...
│
├── ai-service/
│   ├── app/
│   │   ├── api/
│   │   ├── ml/
│   │   ├── llm/
│   │   ├── rag/
│   │   ├── agents/
│   │   ├── evaluation/
│   │   ├── schemas/
│   │   └── main.py
│   ├── models/
│   ├── notebooks/
│   ├── requirements.txt
│   └── ...
│
├── workers/
│   ├── src/
│   │   ├── queues/
│   │   ├── jobs/
│   │   └── workers/
│   └── ...
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── synthetic/
│
├── docs/
│   ├── requirements/
│   ├── architecture/
│   ├── database/
│   ├── ai/
│   └── decisions/
│
├── .gitignore
├── README.md
└── ...
```

---

# 9. Development Philosophy

The project should be developed in this order:

```text
Understand
   ↓
Define requirements
   ↓
Design architecture
   ↓
Design database
   ↓
Create actual database
   ↓
Build backend foundation
   ↓
Create synthetic data
   ↓
Build ML
   ↓
Build anomaly detection
   ↓
Build document intelligence
   ↓
Build RAG
   ↓
Build LLM assistant
   ↓
Build AI agent
   ↓
Build analytics
   ↓
Add security
   ↓
Add evaluation
   ↓
Add monitoring
   ↓
Deploy
```

Do not start by adding LangChain, LangGraph, agents, or an LLM before understanding the underlying application.

---

# 10. Cost Strategy

The initial project can be developed with very low or zero external API cost.

Use:

- local PostgreSQL
- local Redis
- synthetic data
- scikit-learn
- open-source/local embedding models where practical
- local development tools
- Git/GitHub

Commercial LLM APIs can be added later when the application reaches the LLM/RAG/agent phase.

Do not purchase API credits before the LLM functionality is actually required.

---

# 11. Database Architecture

PostgreSQL is the primary database.

The database is divided conceptually into:

```text
Identity
  users
  roles
  permissions
  role_permissions

FinTech
  customers
  merchants
  wallets
  transactions
  payments
  refunds
  chargebacks
  settlements

ML
  risk_assessments
  anomalies

Documents / RAG
  documents
  document_versions
  document_chunks

AI
  conversations
  messages
  investigations

Enterprise
  audit_logs
```

---

# 12. Database Design Principles

## 12.1 Primary Keys

Use UUIDs as internal primary keys.

Example:

```text
id UUID PRIMARY KEY
```

Use separate business-readable codes when useful:

```text
CUS-100001
MER-100001
WAL-100001
TXN-100001
CB-100001
```

---

## 12.2 Money

Never use FLOAT or DOUBLE for financial amounts.

Use:

```text
NUMERIC(18,2)
```

Examples:

- transaction amount
- wallet balance
- refund amount
- chargeback amount
- settlement amount
- fee amount

---

## 12.3 Time

Use:

```text
TIMESTAMPTZ
```

This keeps timestamps timezone-aware.

---

## 12.4 Foreign Keys

Use foreign keys wherever a direct relationship exists.

Example:

```text
transactions.customer_id
        ↓
customers.id
```

---

## 12.5 Constraints

Use:

- NOT NULL
- UNIQUE
- CHECK
- FOREIGN KEY
- PRIMARY KEY

where appropriate.

---

## 12.6 Indexes

Create indexes for frequently queried fields such as:

- email
- customer_code
- merchant_code
- transaction_code
- transaction_time
- customer_id
- merchant_id
- transaction status
- risk level
- anomaly status
- document status

Indexes should be added based on query patterns rather than indiscriminately.

---

# 13. Identity Tables

## 13.1 Table: users

Purpose:

Stores application users.

Fields:

```text
id                  UUID PRIMARY KEY
name                VARCHAR(100)
email               VARCHAR(255) UNIQUE
password_hash       TEXT
role_id             UUID FK roles
department          VARCHAR(100)
is_active           BOOLEAN
last_login_at       TIMESTAMPTZ
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

Example departments:

```text
RISK
OPERATIONS
COMPLIANCE
SUPPORT
ADMIN
```

---

# 14. Table: roles

Purpose:

Stores application roles.

Fields:

```text
id                  UUID PRIMARY KEY
name                VARCHAR(50) UNIQUE
description         TEXT
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

Possible roles:

```text
ADMIN
RISK_ANALYST
OPERATIONS_ANALYST
COMPLIANCE_ANALYST
SUPPORT
```

---

# 15. Table: permissions

Purpose:

Stores granular system permissions.

Fields:

```text
id                  UUID PRIMARY KEY
name                VARCHAR(100) UNIQUE
description         TEXT
created_at          TIMESTAMPTZ
```

Example permissions:

```text
transaction.read
transaction.investigate
document.read
document.upload
document.delete
ai.chat
investigation.create
report.create
merchant.read
customer.read
audit.read
```

---

# 16. Table: role_permissions

Purpose:

Many-to-many relationship between roles and permissions.

Fields:

```text
role_id             UUID FK roles
permission_id       UUID FK permissions
```

Primary key:

```text
(role_id, permission_id)
```

---

# 17. FinTech Customer Tables

## 17.1 Table: customers

Purpose:

Stores customer information.

Fields:

```text
id                  UUID PRIMARY KEY
customer_code       VARCHAR(40) UNIQUE
first_name          VARCHAR(100)
last_name           VARCHAR(100)
email               VARCHAR(255)
phone               VARCHAR(30)
date_of_birth       DATE
account_created_at  TIMESTAMPTZ
status              VARCHAR(30)
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

Possible statuses:

```text
ACTIVE
INACTIVE
BLOCKED
SUSPENDED
```

---

# 18. Table: merchants

Purpose:

Stores merchant information.

Fields:

```text
id                  UUID PRIMARY KEY
merchant_code       VARCHAR(40) UNIQUE
business_name       VARCHAR(255)
business_type       VARCHAR(100)
email               VARCHAR(255)
phone               VARCHAR(30)
gst_number          VARCHAR(50)
onboarding_date     DATE
status              VARCHAR(30)
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

---

# 19. Table: wallets

Purpose:

Represents customer wallets.

Fields:

```text
id                  UUID PRIMARY KEY
wallet_code         VARCHAR(40) UNIQUE
customer_id         UUID FK customers
balance             NUMERIC(18,2)
currency            CHAR(3)
status              VARCHAR(30)
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

Example:

```text
customer
   ↓
wallet
   ↓
transactions
```

---

# 20. Table: transactions

Purpose:

Central FinTech transaction table.

Fields:

```text
id                  UUID PRIMARY KEY
transaction_code    VARCHAR(40) UNIQUE
customer_id         UUID FK customers
merchant_id         UUID FK merchants
wallet_id           UUID FK wallets
amount              NUMERIC(18,2)
currency            CHAR(3)
transaction_type    VARCHAR(30)
payment_method      VARCHAR(30)
status              VARCHAR(30)
failure_reason      TEXT
device_id           VARCHAR(255)
is_new_device       BOOLEAN
city                VARCHAR(100)
state               VARCHAR(100)
country             VARCHAR(100)
is_new_location     BOOLEAN
ip_address          INET
channel             VARCHAR(30)
transaction_time    TIMESTAMPTZ
created_at          TIMESTAMPTZ
```

Possible transaction types:

```text
PAYMENT
TRANSFER
WITHDRAWAL
TOPUP
PURCHASE
```

Possible statuses:

```text
SUCCESS
FAILED
PENDING
REVERSED
CANCELLED
```

Possible channels:

```text
MOBILE
WEB
POS
API
```

This is the central table for:

- ML
- anomaly detection
- analytics
- investigations
- risk dashboards

---

# 21. ML Features Derived From Transactions

Potential derived features include:

```text
failed_transactions_last_24h
transactions_last_1_hour
transactions_last_24_hours
average_transaction_amount
transaction_count_last_7_days
merchant_failure_rate
customer_transaction_frequency
is_new_device
is_new_location
amount_deviation_from_customer_average
amount_deviation_from_merchant_average
distance_from_previous_location
```

These features can be generated dynamically or stored in feature datasets depending on the ML architecture.

---

# 22. Table: payments

Purpose:

Stores payment processing information.

Fields:

```text
id                      UUID PRIMARY KEY
payment_code            VARCHAR(40) UNIQUE
transaction_id          UUID FK transactions
gateway                  VARCHAR(100)
gateway_transaction_id  VARCHAR(255)
payment_method          VARCHAR(30)
amount                  NUMERIC(18,2)
currency                CHAR(3)
status                  VARCHAR(30)
processed_at             TIMESTAMPTZ
created_at               TIMESTAMPTZ
updated_at               TIMESTAMPTZ
```

---

# 23. Table: refunds

Purpose:

Stores refund records.

Fields:

```text
id                  UUID PRIMARY KEY
refund_code         VARCHAR(40) UNIQUE
transaction_id      UUID FK transactions
payment_id          UUID FK payments
customer_id         UUID FK customers
amount              NUMERIC(18,2)
reason              TEXT
status              VARCHAR(30)
requested_at        TIMESTAMPTZ
processed_at        TIMESTAMPTZ
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

---

# 24. Table: chargebacks

Purpose:

Stores chargeback/dispute information.

Fields:

```text
id                  UUID PRIMARY KEY
chargeback_code     VARCHAR(40) UNIQUE
transaction_id      UUID FK transactions
customer_id         UUID FK customers
merchant_id         UUID FK merchants
amount              NUMERIC(18,2)
reason_code         VARCHAR(50)
reason_description  TEXT
status              VARCHAR(30)
dispute_date        DATE
response_due_date   DATE
resolved_at         TIMESTAMPTZ
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

---

# 25. Table: settlements

Purpose:

Stores merchant settlement information.

Fields:

```text
id                  UUID PRIMARY KEY
settlement_code     VARCHAR(40) UNIQUE
merchant_id         UUID FK merchants
settlement_date     DATE
gross_amount        NUMERIC(18,2)
refund_amount       NUMERIC(18,2)
chargeback_amount   NUMERIC(18,2)
fee_amount          NUMERIC(18,2)
net_amount          NUMERIC(18,2)
currency             CHAR(3)
status               VARCHAR(30)
created_at           TIMESTAMPTZ
updated_at           TIMESTAMPTZ
```

---

# 26. ML Tables

## 26.1 Table: risk_assessments

Purpose:

Stores ML risk predictions separately from transactions.

Fields:

```text
id                  UUID PRIMARY KEY
transaction_id      UUID FK transactions
model_name          VARCHAR(100)
model_version       VARCHAR(50)
risk_score          NUMERIC(5,4)
risk_level          VARCHAR(30)
prediction          VARCHAR(50)
feature_snapshot    JSONB
created_at          TIMESTAMPTZ
```

Example risk score:

```text
0.0000 → 1.0000
```

Example levels:

```text
LOW
MEDIUM
HIGH
CRITICAL
```

Keeping ML results separate allows multiple model versions to assess the same transaction.

The `feature_snapshot` stores the feature values used for a particular prediction.

---

# 27. Table: anomalies

Purpose:

Stores anomalies detected by statistical or ML methods.

Fields:

```text
id                  UUID PRIMARY KEY
entity_type         VARCHAR(50)
entity_id           UUID
anomaly_type        VARCHAR(100)
anomaly_score       NUMERIC(5,4)
severity            VARCHAR(30)
description         TEXT
detection_method    VARCHAR(100)
status              VARCHAR(30)
detected_at         TIMESTAMPTZ
resolved_at         TIMESTAMPTZ
created_at          TIMESTAMPTZ
```

Example anomaly types:

```text
UNUSUAL_AMOUNT
UNUSUAL_FREQUENCY
UNUSUAL_LOCATION
NEW_DEVICE_PATTERN
MERCHANT_SPIKE
FAILURE_SPIKE
```

Example detection methods:

```text
ISOLATION_FOREST
STATISTICAL_THRESHOLD
RULE_ENGINE
CLUSTERING
```

Important:

`entity_type/entity_id` is a polymorphic relationship.

Because PostgreSQL cannot enforce a normal foreign key across multiple possible tables for this pattern, application-level validation is required.

---

# 28. Document Management

Documents are not stored directly inside PostgreSQL as large binary objects in the initial design.

Instead:

```text
Object/File Storage
        │
        │ actual file
        ▼
documents
        │
        ▼
document_versions
        │
        ▼
document_chunks
        │
        ▼
pgvector embeddings
```

PostgreSQL stores metadata and searchable document content.

---

# 29. Table: documents

Purpose:

Stores document metadata.

Fields:

```text
id                  UUID PRIMARY KEY
document_code       VARCHAR(40) UNIQUE
name                VARCHAR(255)
description         TEXT
file_name           VARCHAR(255)
file_type           VARCHAR(50)
file_size           BIGINT
storage_path        TEXT
department          VARCHAR(100)
uploaded_by         UUID FK users
access_level        VARCHAR(30)
processing_status   VARCHAR(30)
current_version     INTEGER
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

Possible processing statuses:

```text
UPLOADED
PROCESSING
PROCESSED
FAILED
```

Possible access levels:

```text
PUBLIC_INTERNAL
DEPARTMENT
RESTRICTED
CONFIDENTIAL
```

---

# 30. Table: document_versions

Purpose:

Supports document versioning.

Fields:

```text
id                  UUID PRIMARY KEY
document_id         UUID FK documents
version_number      INTEGER
storage_path        TEXT
file_hash           VARCHAR(128)
file_size           BIGINT
uploaded_by         UUID FK users
processing_status   VARCHAR(30)
processed_at        TIMESTAMPTZ
created_at          TIMESTAMPTZ
```

Recommended constraint:

```text
UNIQUE(document_id, version_number)
```

---

# 31. Table: document_chunks

Purpose:

Stores chunks generated from documents for RAG.

Fields:

```text
id                  UUID PRIMARY KEY
document_version_id UUID FK document_versions
chunk_index         INTEGER
content             TEXT
page_number         INTEGER
section_title       VARCHAR(255)
token_count         INTEGER
embedding            VECTOR
metadata             JSONB
created_at           TIMESTAMPTZ
```

The vector dimension will be selected after the embedding model is finalized.

For the initial architecture, PostgreSQL + pgvector is preferred.

A dedicated vector database can be evaluated later if scale requirements justify it.

---

# 32. Document Processing Pipeline

```text
User Uploads Document
        ↓
Document Metadata Stored
        ↓
File Stored in Object Storage
        ↓
Background Job Created
        ↓
Document Text Extraction
        ↓
Text Cleaning
        ↓
Chunking
        ↓
Metadata Extraction
        ↓
Embedding Generation
        ↓
Embeddings Stored in pgvector
        ↓
Document Ready for RAG
```

This process should be asynchronous for larger files.

Redis + BullMQ will handle the background processing.

---

# 33. RAG Architecture

RAG means Retrieval-Augmented Generation.

The assistant does not rely only on the LLM's training knowledge.

Instead:

```text
User Question
      ↓
Question Embedding
      ↓
Vector Search
      ↓
Relevant Document Chunks
      ↓
Context Construction
      ↓
LLM
      ↓
Answer + Sources
```

Sources should include information such as:

```text
document_id
chunk_id
page_number
document_name
```

This allows the user to inspect the source material behind an answer.

---

# 34. Table: conversations

Purpose:

Stores AI conversations.

Fields:

```text
id                  UUID PRIMARY KEY
conversation_code   VARCHAR(40) UNIQUE
user_id             UUID FK users
title               VARCHAR(255)
conversation_type   VARCHAR(50)
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

Possible conversation types:

```text
KNOWLEDGE_ASSISTANT
INVESTIGATION
DOCUMENT_ANALYSIS
ANALYTICS
```

---

# 35. Table: messages

Purpose:

Stores conversation messages.

Fields:

```text
id                  UUID PRIMARY KEY
conversation_id     UUID FK conversations
role                VARCHAR(20)
content             TEXT
sources             JSONB
tool_calls          JSONB
model_name          VARCHAR(100)
input_tokens        INTEGER
output_tokens       INTEGER
created_at          TIMESTAMPTZ
```

Possible roles:

```text
USER
ASSISTANT
SYSTEM
TOOL
```

`source` information can contain:

```json
[
  {
    "document_id": "...",
    "chunk_id": "...",
    "page_number": 4
  }
]
```

Tool call information can contain:

```json
[
  {
    "tool": "get_transaction",
    "arguments": {},
    "result_summary": "..."
  }
]
```

---

# 36. AI Knowledge Assistant

The assistant should support questions such as:

```text
What is the refund policy?

What is the response deadline for this chargeback type?

Explain the merchant onboarding policy.

What documents are required for a specific operational process?
```

The assistant should:

1. understand the user question
2. retrieve relevant documents
3. construct context
4. generate an answer
5. provide source references
6. avoid claiming information that is not supported by the retrieved context

---

# 37. AI Investigation Agent

The investigation agent is a controlled AI workflow that can use application tools.

Example investigation:

```text
User
  ↓
"Investigate transaction TXN-100421"
  ↓
Agent
  ↓
Get Transaction
  ↓
Get Customer History
  ↓
Get Merchant History
  ↓
Get Risk Assessment
  ↓
Get Related Anomalies
  ↓
Check Chargebacks / Refunds
  ↓
Retrieve Relevant Policies
  ↓
Analyze Evidence
  ↓
Generate Investigation Summary
```

The agent should not directly modify financial records without explicit application-level authorization and controlled tools.

---

# 38. Table: investigations

Purpose:

Stores investigation cases and AI-generated investigation information.

Fields:

```text
id                  UUID PRIMARY KEY
investigation_code  VARCHAR(40) UNIQUE
created_by          UUID FK users
entity_type         VARCHAR(50)
entity_id           UUID
reason              TEXT
status              VARCHAR(30)
risk_level          VARCHAR(30)
summary             TEXT
findings            JSONB
evidence            JSONB
tools_used          JSONB
started_at          TIMESTAMPTZ
completed_at        TIMESTAMPTZ
created_at          TIMESTAMPTZ
updated_at          TIMESTAMPTZ
```

Possible statuses:

```text
OPEN
IN_PROGRESS
COMPLETED
ESCALATED
CLOSED
```

Possible evidence structure:

```json
[
  {
    "type": "TRANSACTION",
    "reference_id": "...",
    "description": "..."
  },
  {
    "type": "ANOMALY",
    "reference_id": "...",
    "description": "..."
  }
]
```

---

# 39. AI Agent Tool Design

The agent may have read-only tools such as:

```text
get_transaction(transaction_id)

get_customer(customer_id)

get_customer_transactions(customer_id)

get_merchant(merchant_id)

get_merchant_transactions(merchant_id)

get_risk_assessment(transaction_id)

get_anomalies(entity_id)

get_chargebacks(transaction_id)

get_refunds(transaction_id)

search_knowledge_base(query)

get_document(document_id)
```

Tools should:

- validate input
- enforce authorization
- return structured data
- log important actions
- have clear descriptions
- avoid unrestricted database access

---

# 40. Natural Language Analytics

The platform should allow users to ask questions such as:

```text
Show the total transaction value for last month.

Which merchants had the highest failure rate?

How many high-risk transactions occurred today?

Show refund trends for the last 30 days.

Which cities have the highest transaction volume?

What percentage of transactions were flagged as high risk?
```

Architecture:

```text
Natural Language Question
        ↓
Intent / Query Understanding
        ↓
Validated Query Generation
        ↓
SQL Safety Validation
        ↓
PostgreSQL
        ↓
Structured Result
        ↓
Chart / Table
        ↓
Natural Language Explanation
```

Generated SQL must be restricted and validated.

The LLM should not receive unrestricted database write access.

---

# 41. Chargeback Intelligence

Chargeback intelligence can analyze:

- chargeback volume
- chargeback rate
- reason codes
- merchant trends
- customer patterns
- response deadlines
- historical outcomes
- transaction context
- related refunds
- supporting evidence

Potential output:

```text
Chargeback Summary
Risk Indicators
Transaction Context
Customer Context
Merchant Context
Related Transactions
Recommended Evidence to Review
Policy References
```

Any AI-generated recommendation should be presented as analysis/supporting information rather than an automatic financial decision.

---

# 42. AI Reports

The system can generate reports such as:

```text
Daily Risk Report
Weekly Transaction Report
Merchant Risk Report
Chargeback Report
Anomaly Report
Operational Summary
Investigation Summary
```

A report can combine:

```text
SQL analytics
+
ML results
+
anomaly results
+
RAG references
+
LLM-generated narrative
```

---

# 43. Authentication

Authentication should include:

```text
Login
Logout
Password hashing
Session/JWT handling
Token validation
Account status
Last login tracking
```

Passwords must never be stored as plaintext.

Use a secure password hashing algorithm such as bcrypt or Argon2.

---

# 44. Authorization

Use Role-Based Access Control (RBAC).

Example:

```text
ADMIN
   ↓
Most administrative permissions

RISK_ANALYST
   ↓
Risk + transaction investigation permissions

OPERATIONS_ANALYST
   ↓
Operational transaction/report permissions

COMPLIANCE_ANALYST
   ↓
Document + investigation + audit permissions

SUPPORT
   ↓
Customer + transaction read permissions
```

Permissions should be checked in backend middleware/services rather than relying only on frontend controls.

---

# 45. Audit Logging

Important actions should be logged.

Examples:

```text
LOGIN
LOGOUT
DOCUMENT_UPLOAD
DOCUMENT_DELETE
TRANSACTION_VIEW
INVESTIGATION_CREATE
INVESTIGATION_UPDATE
REPORT_CREATE
USER_CREATE
ROLE_UPDATE
PERMISSION_UPDATE
AI_TOOL_CALL
```

Audit record:

```text
user
action
resource
resource_id
description
metadata
ip_address
timestamp
```

---

# 46. Background Processing

Redis + BullMQ will be used for asynchronous work.

Possible queues:

```text
document-processing
embedding-generation
risk-scoring
anomaly-detection
report-generation
notification
data-processing
```

Example:

```text
Document Upload
      ↓
Create Job
      ↓
Redis Queue
      ↓
Worker
      ↓
Extract Text
      ↓
Chunk
      ↓
Generate Embeddings
      ↓
Store Chunks
```

This prevents long-running operations from blocking normal API requests.

---

# 47. ML Risk Prediction

The ML system should predict the risk of a transaction.

Possible first approach:

```text
Dataset
   ↓
Feature Engineering
   ↓
Train/Test Split
   ↓
Baseline Model
   ↓
Evaluation
   ↓
Model Selection
   ↓
Model Serialization
   ↓
FastAPI Prediction Endpoint
   ↓
Node Backend
   ↓
PostgreSQL risk_assessments
```

Start with a simple baseline before moving to more advanced models.

Possible models:

```text
Logistic Regression
Random Forest
XGBoost
```

---

# 48. ML Dataset

The initial dataset should be synthetic.

Possible fields:

```text
transaction_id
customer_id
merchant_id
amount
transaction_hour
transaction_frequency
customer_average_amount
merchant_average_amount
failed_transactions
is_new_device
is_new_location
distance_from_previous_transaction
merchant_failure_rate
payment_method
channel
transaction_status
fraud_label
```

The dataset should contain both normal and suspicious patterns.

---

# 49. ML Evaluation

Do not evaluate a risk model using accuracy alone.

Use metrics such as:

```text
Precision
Recall
F1 Score
ROC-AUC
PR-AUC
Confusion Matrix
```

For fraud/risk problems, class imbalance is important.

The evaluation should clearly document:

- dataset size
- class distribution
- train/test strategy
- feature set
- model version
- evaluation metrics
- limitations

---

# 50. Anomaly Detection

Anomaly detection is different from supervised risk prediction.

Risk prediction:

```text
Uses labeled examples
```

Anomaly detection:

```text
Looks for unusual behavior
```

Possible techniques:

```text
Isolation Forest
Statistical thresholds
Clustering
Rolling-window analysis
Behavioral baselines
```

Examples:

```text
Customer suddenly makes 20 transactions in 5 minutes.

Transaction amount is far above the customer's normal range.

Merchant suddenly experiences a major failure spike.

Customer logs in from an unusual location.

```

---

# 51. ML + Anomaly + Investigation Relationship

```text
Transaction
    │
    ├──────────────► Risk Model
    │                    │
    │                    ▼
    │             Risk Assessment
    │
    ├──────────────► Anomaly Detection
    │                    │
    │                    ▼
    │                Anomaly
    │
    └──────────────► Analytics
                         │
                         ▼
                    Investigation
                         │
                         ▼
                    AI Assistant
```

---

# 52. LLM Architecture

The LLM layer should be introduced after the basic application, ML, and RAG systems are understood.

Possible capabilities:

```text
Question answering
Summarization
Document analysis
Investigation summaries
Natural-language analytics explanations
Report generation
Tool calling
```

The LLM should not be treated as the database or source of truth.

The source of truth remains:

```text
PostgreSQL
Documents
ML results
Application services
Audit logs
```

---

# 53. RAG vs LLM vs Agent

## LLM

Generates and understands language.

```text
Question → LLM → Answer
```

## RAG

Adds external knowledge retrieval.

```text
Question
   ↓
Retrieve documents
   ↓
LLM
   ↓
Answer with context
```

## Agent

Uses an LLM to decide which tools/actions are needed.

```text
Goal
 ↓
LLM
 ↓
Tool
 ↓
Result
 ↓
LLM
 ↓
Next Tool
 ↓
Final Result
```

FinSight AI uses all three for different purposes.

---

# 54. AI Evaluation

AI responses should be evaluated rather than assumed to be correct.

Possible RAG evaluation dimensions:

```text
Retrieval relevance
Context relevance
Answer faithfulness
Source correctness
Answer completeness
```

Possible agent evaluation:

```text
Tool selection accuracy
Argument correctness
Task completion
Unsupported claims
Authorization compliance
```

Possible LLM evaluation:

```text
Factuality
Groundedness
Relevance
Format compliance
Latency
Token usage
Cost
```

---

# 55. AI Guardrails

The AI system should include:

```text
Input validation
Output validation
Prompt boundaries
Tool authorization
SQL validation
Sensitive-data controls
Source grounding
Audit logging
Rate limiting
Error handling
```

The agent should not be given unrestricted system access.

---

# 56. Data Privacy and Security

The application should be designed with security in mind.

Important controls:

```text
Password hashing
JWT/session security
RBAC
Input validation
Rate limiting
Audit logging
Parameterized SQL
Secret management
Secure file validation
File-size limits
Access control for documents
Restricted AI tools
```

Do not commit:

```text
.env
API keys
passwords
private credentials
database credentials
model secrets
```

to Git.

---

# 57. API Architecture

Node.js should expose REST APIs.

Example API groups:

```text
/auth
/users
/roles
/permissions

/customers
/merchants
/wallets
/transactions
/payments
/refunds
/chargebacks
/settlements

/risk
/anomalies

/documents
/document-versions

/conversations
/messages
/investigations

/reports
/analytics

/audit
```

---

# 58. Example Transaction API Flow

```text
React
  ↓
POST /api/transactions
  ↓
Node Controller
  ↓
Validation
  ↓
Transaction Service
  ↓
PostgreSQL
  ↓
Transaction Created
  ↓
Risk Job
  ↓
Redis/BullMQ
  ↓
AI Service
  ↓
Risk Assessment
  ↓
PostgreSQL
```

---

# 59. AI Service API

FastAPI may expose endpoints such as:

```text
POST /predict-risk

POST /detect-anomaly

POST /embed

POST /retrieve

POST /generate-answer

POST /investigate

POST /generate-report
```

The exact API structure can be refined during implementation.

---

# 60. Frontend Pages

Potential application pages:

```text
Login

Dashboard

Customers
Customer Details

Merchants
Merchant Details

Transactions
Transaction Details

Risk Dashboard

Anomaly Dashboard

Investigations
Investigation Details

Documents
Document Details

Knowledge Assistant

AI Investigation

Analytics

Chargebacks

Reports

Audit Logs

User Management

Role & Permission Management

System Health
```

---

# 61. Main Dashboard

The dashboard can show:

```text
Total Transactions
Transaction Value
High-Risk Transactions
Anomalies
Open Investigations
Chargebacks
Refunds
Failed Transactions
Top Risky Merchants
Recent Alerts
```

Charts can include:

```text
Transaction volume
Risk trend
Failure trend
Chargeback trend
Refund trend
Anomaly trend
```

---

# 62. Transaction Details Page

The transaction page can display:

```text
Transaction Information
Customer Information
Merchant Information
Payment Information
Risk Score
Risk Level
Risk Features
Anomalies
Related Refunds
Related Chargebacks
Transaction History
Investigation Status
Audit Information
```

---

# 63. Investigation UI

Example layout:

```text
Investigation Header
    ↓
Target Entity
    ↓
Reason
    ↓
Risk Summary
    ↓
Timeline
    ↓
Evidence
    ↓
Related Transactions
    ↓
Anomalies
    ↓
ML Assessment
    ↓
Policy References
    ↓
AI Investigation Summary
    ↓
Analyst Notes
```

---

# 64. Documentation Structure

The `docs/` directory should contain:

```text
docs/
├── requirements/
│   ├── 01-project-overview.md
│   ├── 02-functional-requirements.md
│   └── 03-non-functional-requirements.md
│
├── architecture/
│   ├── 01-system-architecture.md
│   ├── 02-service-architecture.md
│   └── 03-data-flow.md
│
├── database/
│   ├── 01-database-design.md
│   ├── 02-relationships.md
│   └── 03-indexing-strategy.md
│
├── ai/
│   ├── 01-ml-design.md
│   ├── 02-rag-design.md
│   ├── 03-agent-design.md
│   └── 04-ai-evaluation.md
│
└── decisions/
    ├── 001-postgresql.md
    ├── 002-pgvector.md
    ├── 003-redis-bullmq.md
    └── ...
```

---

# 65. Complete Database Relationship Overview

```text
roles
  │
  ├────────────── role_permissions ────────────── permissions
  │
  ▼
users
  │
  ├────────────── documents
  │
  ├────────────── conversations
  │
  ├────────────── investigations
  │
  └────────────── audit_logs


customers
  │
  ├────────────── wallets
  │                    │
  │                    └────────────── transactions
  │
  ├────────────── transactions
  │
  ├────────────── refunds
  │
  └────────────── chargebacks


merchants
  │
  ├────────────── transactions
  │
  ├────────────── chargebacks
  │
  └────────────── settlements


transactions
  │
  ├────────────── payments
  │
  ├────────────── refunds
  │
  ├────────────── chargebacks
  │
  └────────────── risk_assessments


documents
  │
  └────────────── document_versions
                         │
                         └────────────── document_chunks
                                              │
                                              └── embedding


conversations
  │
  └────────────── messages


investigations
  │
  ├── entity
  ├── findings
  ├── evidence
  └── tools_used
```

---

# 66. Complete Module Map

```text
FinSight AI
│
├── Identity
│   ├── Users
│   ├── Roles
│   └── Permissions
│
├── FinTech Core
│   ├── Customers
│   ├── Merchants
│   ├── Wallets
│   ├── Transactions
│   ├── Payments
│   ├── Refunds
│   ├── Chargebacks
│   └── Settlements
│
├── Intelligence
│   ├── Risk Prediction
│   ├── Anomaly Detection
│   ├── Chargeback Intelligence
│   └── Analytics
│
├── Documents
│   ├── Document Management
│   ├── Document Versions
│   ├── Text Extraction
│   ├── Chunking
│   └── Embeddings
│
├── AI
│   ├── LLM
│   ├── RAG
│   ├── Knowledge Assistant
│   ├── Investigation Agent
│   └── AI Reports
│
├── Enterprise
│   ├── Audit Logs
│   ├── Monitoring
│   ├── Evaluation
│   └── Background Jobs
│
└── Security
    ├── Authentication
    ├── Authorization
    ├── RBAC
    ├── Validation
    └── Audit
```

---

# 67. Development Roadmap

## Phase 1 — Project Definition

Tasks:

- define problem
- define users
- define objectives
- define modules
- define technology stack
- create README
- create project documentation

Status:

Completed/planned as the first stage.

---

## Phase 2 — Architecture

Tasks:

- design system architecture
- design service boundaries
- define frontend/backend/AI communication
- define background processing
- define document pipeline
- define AI flow

---

## Phase 3 — Database

Tasks:

- install PostgreSQL
- create `finsight` database
- enable required extensions
- create migrations
- create tables
- create constraints
- create indexes
- seed roles
- seed permissions

Potential PostgreSQL extensions:

```text
pgcrypto
vector
```

`vector` requires pgvector to be installed and available in the PostgreSQL environment.

---

## Phase 4 — Backend Foundation

Tasks:

- initialize Node.js + TypeScript
- configure Express
- configure PostgreSQL
- create environment configuration
- create error handling
- create validation
- create logging
- create API structure
- create health endpoint
- create authentication foundation

---

## Phase 5 — Synthetic FinTech Data

Generate realistic synthetic data for:

```text
customers
merchants
wallets
transactions
payments
refunds
chargebacks
settlements
```

The synthetic dataset should include realistic patterns rather than completely random values.

Examples:

```text
normal users
high-frequency users
high-value users
new-device users
location changes
merchant spikes
payment failures
refund patterns
chargeback patterns
```

---

# 68. Phase 6 — ML Risk Engine

Tasks:

1. prepare dataset
2. explore data
3. clean data
4. engineer features
5. split data
6. train baseline
7. evaluate baseline
8. train advanced model
9. compare metrics
10. select documented model
11. save model
12. create FastAPI endpoint
13. integrate with Node.js
14. store predictions

---

# 69. Phase 7 — Anomaly Detection

Tasks:

1. define behavioral baselines
2. create anomaly features
3. implement Isolation Forest or another baseline
4. detect anomalies
5. store anomalies
6. build anomaly dashboard
7. link anomalies to investigations

---

# 70. Phase 8 — Document Intelligence

Tasks:

1. document upload
2. file validation
3. storage
4. metadata storage
5. background processing
6. text extraction
7. document versioning
8. chunking
9. metadata extraction
10. embedding generation
11. vector storage

---

# 71. Phase 9 — RAG

Tasks:

1. build embedding pipeline
2. build vector search
3. implement retrieval
4. create context builder
5. integrate LLM
6. create source references
7. build chat UI
8. evaluate retrieval
9. evaluate answer grounding

---

# 72. Phase 10 — AI Investigation Agent

Tasks:

1. define investigation workflow
2. define tools
3. create tool schemas
4. implement authorization
5. implement tool execution
6. connect LLM
7. create investigation state
8. store tool calls
9. store evidence
10. generate final investigation summary
11. build investigation UI

---

# 73. Phase 11 — Natural Language Analytics

Tasks:

1. define safe analytics queries
2. create query intent layer
3. generate or map SQL
4. validate SQL
5. execute read-only queries
6. return structured data
7. generate charts
8. provide explanation

---

# 74. Phase 12 — Chargeback Intelligence

Tasks:

1. build chargeback dashboard
2. calculate chargeback metrics
3. connect transactions
4. connect refunds
5. connect merchants
6. retrieve policies
7. build AI summary
8. build evidence view

---

# 75. Phase 13 — Security

Tasks:

- authentication
- RBAC
- permission middleware
- secure password hashing
- rate limiting
- request validation
- SQL injection prevention
- file validation
- document access control
- secrets management
- audit logs

---

# 76. Phase 14 — AI Evaluation

Tasks:

- create evaluation datasets
- test RAG retrieval
- test groundedness
- test agent tool selection
- test tool arguments
- test analytics queries
- measure latency
- measure token usage
- document failures
- improve prompts/workflows

---

# 77. Phase 15 — Monitoring and Background Processing

Tasks:

- Redis setup
- BullMQ setup
- queue creation
- worker implementation
- retry strategy
- failed job handling
- job monitoring
- structured logs
- API health checks
- AI service health checks
- database health checks

---

# 78. Phase 16 — Deployment

Potential deployment architecture:

```text
React Frontend
      ↓
Frontend Hosting

Node Backend
      ↓
Backend Hosting

Python AI Service
      ↓
AI Service Hosting

PostgreSQL
      ↓
Managed PostgreSQL

Redis
      ↓
Managed Redis

Object Storage
      ↓
Managed Storage
```

Docker can be introduced before deployment to make the services reproducible.

---

# 79. Testing Strategy

## Frontend

Test:

- components
- forms
- navigation
- API states
- error states
- loading states

## Backend

Test:

- authentication
- authorization
- services
- validation
- APIs
- database operations

## ML

Test:

- preprocessing
- feature engineering
- prediction
- evaluation
- model loading

## RAG

Test:

- chunking
- embedding
- retrieval
- source mapping
- grounded answers

## Agent

Test:

- tool selection
- authorization
- tool parameters
- error handling
- final summaries

---

# 80. Error Handling

All services should have consistent error handling.

Example backend response:

```json
{
  "success": false,
  "error": {
    "code": "TRANSACTION_NOT_FOUND",
    "message": "Transaction was not found."
  }
}
```

Avoid exposing:

- database credentials
- stack traces
- internal secrets
- unnecessary infrastructure details

in production responses.

---

# 81. Environment Configuration

Example:

```text
DATABASE_URL=
REDIS_URL=
JWT_SECRET=
AI_SERVICE_URL=
LLM_API_KEY=
OBJECT_STORAGE_URL=
OBJECT_STORAGE_KEY=
OBJECT_STORAGE_SECRET=
```

Use `.env` locally.

Never commit `.env`.

Maintain:

```text
.env.example
```

with placeholder values.

---

# 82. Git Strategy

Use meaningful commits.

Examples:

```text
Initial project structure

Add project overview documentation

Add database design

Add document RAG and AI database design

Add PostgreSQL migrations

Add backend foundation

Add authentication

Add synthetic transaction generator

Add risk prediction service

Add anomaly detection

Add document processing pipeline

Add RAG assistant

Add investigation agent

Add analytics module

Add audit logging

Add evaluation framework
```

---

# 83. Architecture Decision Records

Important decisions should be documented.

Example:

```text
Decision: PostgreSQL

Reason:
FinTech data requires strong relational integrity,
ACID transactions, joins, constraints, analytics,
and support for structured financial records.
```

Other decisions:

```text
PostgreSQL instead of MongoDB
pgvector instead of a separate vector DB initially
Redis + BullMQ for background jobs
Node.js for application backend
Python for ML/AI
React for frontend
Synthetic data for initial development
```

---

# 84. Why PostgreSQL

PostgreSQL is selected because the application has strongly relational data:

```text
Customer
   ↓
Wallet
   ↓
Transaction
   ↓
Payment
   ↓
Refund
   ↓
Chargeback
```

It also provides:

- ACID transactions
- foreign keys
- constraints
- joins
- window functions
- CTEs
- JSONB
- strong analytics capabilities
- pgvector integration

MongoDB can be useful in other workloads, but it is not required for this project.

---

# 85. Why pgvector

pgvector allows vector embeddings to live alongside relational application data.

This makes the initial architecture simpler:

```text
PostgreSQL
 ├── customers
 ├── transactions
 ├── risk_assessments
 ├── documents
 ├── document_chunks
 └── embeddings
```

A dedicated vector database can be evaluated later if the scale or retrieval requirements demand it.

---

# 86. Why Redis + BullMQ

Some operations can take too long for a normal HTTP request.

Examples:

```text
PDF processing
Embedding generation
Large report generation
Batch risk scoring
Large data processing
```

Instead:

```text
API
 ↓
Queue
 ↓
Worker
 ↓
Long-running operation
```

Redis stores the queue state and BullMQ manages jobs, retries, delays, and worker processing.

---

# 87. Why Node.js + Python

Node.js is used for:

```text
Authentication
REST APIs
Business logic
Database interaction
RBAC
Application services
Queue integration
```

Python is used for:

```text
ML
Data processing
Model inference
Embeddings
LLM orchestration
RAG
AI agents
Evaluation
```

This keeps the application layer and AI/ML layer logically separated.

---

# 88. Data Flow — Transaction Risk

```text
Transaction Created
        ↓
PostgreSQL
        ↓
Risk Scoring Job
        ↓
Redis
        ↓
Worker
        ↓
Python AI Service
        ↓
Feature Engineering
        ↓
ML Model
        ↓
Risk Score
        ↓
Node Backend
        ↓
risk_assessments
        ↓
Frontend Dashboard
```

---

# 89. Data Flow — Document RAG

```text
Document Upload
      ↓
Node Backend
      ↓
Object Storage
      ↓
PostgreSQL Metadata
      ↓
BullMQ Job
      ↓
Document Worker
      ↓
Text Extraction
      ↓
Chunking
      ↓
Embedding Model
      ↓
pgvector
      ↓
RAG Ready
```

---

# 90. Data Flow — AI Investigation

```text
Analyst
   ↓
Investigation Request
   ↓
Node Backend
   ↓
Python AI Service
   ↓
LLM
   ↓
Tool Selection
   ↓
Application Tools
   ↓
PostgreSQL / RAG
   ↓
Evidence
   ↓
LLM Analysis
   ↓
Investigation Summary
   ↓
PostgreSQL
   ↓
Frontend
```

---

# 91. Data Flow — Natural Language Analytics

```text
User Question
      ↓
AI Service
      ↓
Intent Understanding
      ↓
SQL Generation / Query Mapping
      ↓
SQL Validation
      ↓
Read-only PostgreSQL Query
      ↓
Structured Result
      ↓
Chart / Table
      ↓
Natural Language Explanation
```

---

# 92. Important Design Rules

1. Financial values must use exact numeric types.
2. Never store plaintext passwords.
3. Never commit secrets.
4. Do not allow unrestricted AI database access.
5. Validate all AI-generated SQL.
6. Keep ML predictions separate from core transactions.
7. Store model version with predictions.
8. Keep document metadata in PostgreSQL.
9. Store actual files in object storage.
10. Use source references in RAG answers.
11. Log important AI tool usage.
12. Use background jobs for long-running tasks.
13. Use synthetic data during initial development.
14. Document architectural decisions.
15. Test every major module.
16. Add monitoring before production deployment.
17. Treat AI output as an assistive layer, not the system of record.
18. Enforce authorization in backend services, not only in the UI.

---

# 93. Initial Project Status

Completed/planned foundation:

```text
Project folder
Documentation folders
Git repository
.gitignore
README
Project overview
Database architecture
Core database design
Document/RAG design
AI conversation design
Investigation design
```

Next major implementation step:

```text
Create actual PostgreSQL database
```

---

# 94. Immediate Next Steps

The next implementation sequence should be:

```text
1. Verify PostgreSQL installation

2. Verify:
   psql --version

3. Create database:
   finsight

4. Connect to database

5. Enable pgcrypto

6. Check/install pgvector

7. Create database migrations

8. Create tables in dependency order

9. Add constraints

10. Add indexes

11. Seed roles

12. Seed permissions

13. Verify relationships

14. Create backend connection

15. Create synthetic data
```

---

# 95. Recommended Table Creation Order

Because foreign keys create dependencies, create tables approximately in this order:

```text
1. roles
2. permissions
3. role_permissions
4. users

5. customers
6. merchants
7. wallets

8. transactions
9. payments
10. refunds
11. chargebacks
12. settlements

13. risk_assessments
14. anomalies

15. documents
16. document_versions
17. document_chunks

18. conversations
19. messages
20. investigations

21. audit_logs
```

---

# 96. Final Architecture Summary

FinSight AI combines:

```text
Software Engineering
        +
FinTech Data
        +
PostgreSQL
        +
Machine Learning
        +
Anomaly Detection
        +
Document Intelligence
        +
Embeddings
        +
RAG
        +
LLM
        +
AI Agents
        +
Natural Language Analytics
        +
Background Jobs
        +
RBAC
        +
Audit Logging
        +
Evaluation
        +
Monitoring
```

The goal is not to create a collection of unrelated AI demos.

The goal is to build one coherent enterprise-style FinTech platform in which every technology has a clear purpose and connects to the rest of the system.

---

# 97. Project Success Criteria

The project will be considered a strong portfolio project when it can demonstrate an end-to-end flow such as:

```text
Synthetic Transaction
       ↓
PostgreSQL
       ↓
Risk Prediction
       ↓
Anomaly Detection
       ↓
Investigation
       ↓
AI Agent
       ↓
Customer / Merchant / Transaction Tools
       ↓
Relevant Policy Retrieval
       ↓
RAG
       ↓
Evidence-based Investigation Summary
       ↓
Audit Log
       ↓
Dashboard
```

And a second complete flow:

```text
Document Upload
       ↓
Storage
       ↓
Text Extraction
       ↓
Chunking
       ↓
Embeddings
       ↓
pgvector
       ↓
RAG Search
       ↓
LLM
       ↓
Source-backed Answer
```

This provides a clear demonstration of:

- full-stack development
- database engineering
- FinTech domain modeling
- machine learning
- anomaly detection
- document processing
- vector search
- RAG
- LLM integration
- agentic workflows
- asynchronous processing
- security
- evaluation
- deployment
