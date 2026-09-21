# FinSight AI — Database Design

## 1. Database

PostgreSQL

Database Name:

finsight

---

# 2. Database Design Principles

1. Use UUIDs for primary keys.
2. Use foreign keys for relationships.
3. Use NUMERIC(18,2) for monetary values.
4. Use TIMESTAMPTZ for timestamps.
5. Use database constraints to maintain data integrity.
6. Use indexes for frequently searched fields.
7. Keep transactional data normalized.
8. Keep AI/ML results separately from core transaction records.
9. Store document metadata in PostgreSQL.
10. Store vector embeddings separately using pgvector.

---

# 3. Tables

## Identity

- users
- roles
- permissions
- role_permissions

## FinTech

- customers
- merchants
- wallets
- transactions
- payments
- refunds
- chargebacks
- settlements

## Machine Learning

- risk_assessments
- anomalies

## Documents and RAG

- documents
- document_versions
- document_chunks

## AI

- conversations
- messages
- investigations

## Enterprise

- audit_logs