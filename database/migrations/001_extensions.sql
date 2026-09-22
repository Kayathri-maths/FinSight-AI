-- FinSight AI
-- Migration: 001_extensions
-- Purpose: Enable required PostgreSQL extensions

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE EXTENSION IF NOT EXISTS vector;