-- FinSight AI
-- Migration: 006_ai
-- Purpose: Create AI conversation, investigation, and audit tables

-- ============================================================
-- CONVERSATIONS
-- ============================================================

CREATE TABLE conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    conversation_code VARCHAR(40) NOT NULL UNIQUE,

    user_id UUID NOT NULL,

    title VARCHAR(255),

    conversation_type VARCHAR(50) NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_conversations_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_conversation_type
        CHECK (
            conversation_type IN (
                'KNOWLEDGE_ASSISTANT',
                'INVESTIGATION',
                'DOCUMENT_ANALYSIS',
                'ANALYTICS'
            )
        )
);

CREATE INDEX idx_conversations_user_id
    ON conversations(user_id);

CREATE INDEX idx_conversations_type
    ON conversations(conversation_type);

CREATE INDEX idx_conversations_updated_at
    ON conversations(updated_at);


-- ============================================================
-- MESSAGES
-- ============================================================

CREATE TABLE messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    conversation_id UUID NOT NULL,

    role VARCHAR(20) NOT NULL,

    content TEXT NOT NULL,

    sources JSONB,
    tool_calls JSONB,

    model_name VARCHAR(100),

    input_tokens INTEGER,
    output_tokens INTEGER,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_messages_conversation
        FOREIGN KEY (conversation_id)
        REFERENCES conversations(id)
        ON DELETE CASCADE,

    CONSTRAINT chk_message_role
        CHECK (
            role IN (
                'USER',
                'ASSISTANT',
                'SYSTEM',
                'TOOL'
            )
        ),

    CONSTRAINT chk_message_input_tokens
        CHECK (input_tokens IS NULL OR input_tokens >= 0),

    CONSTRAINT chk_message_output_tokens
        CHECK (output_tokens IS NULL OR output_tokens >= 0)
);

CREATE INDEX idx_messages_conversation_id
    ON messages(conversation_id);

CREATE INDEX idx_messages_created_at
    ON messages(created_at);


-- ============================================================
-- INVESTIGATIONS
-- ============================================================

CREATE TABLE investigations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    investigation_code VARCHAR(40) NOT NULL UNIQUE,

    created_by UUID NOT NULL,

    entity_type VARCHAR(50) NOT NULL,
    entity_id UUID NOT NULL,

    reason TEXT NOT NULL,

    status VARCHAR(30) NOT NULL DEFAULT 'OPEN',

    risk_level VARCHAR(20),

    summary TEXT,

    findings JSONB,
    evidence JSONB,
    tools_used JSONB,

    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_investigations_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_investigation_status
        CHECK (
            status IN (
                'OPEN',
                'IN_PROGRESS',
                'COMPLETED',
                'CLOSED'
            )
        ),

    CONSTRAINT chk_investigation_risk_level
        CHECK (
            risk_level IS NULL
            OR risk_level IN (
                'LOW',
                'MEDIUM',
                'HIGH',
                'CRITICAL'
            )
        )
);

CREATE INDEX idx_investigations_created_by
    ON investigations(created_by);

CREATE INDEX idx_investigations_entity
    ON investigations(entity_type, entity_id);

CREATE INDEX idx_investigations_status
    ON investigations(status);

CREATE INDEX idx_investigations_risk_level
    ON investigations(risk_level);

CREATE INDEX idx_investigations_created_at
    ON investigations(created_at);


-- ============================================================
-- AUDIT LOGS
-- ============================================================

CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID,

    action VARCHAR(100) NOT NULL,

    resource_type VARCHAR(100),

    resource_id UUID,

    description TEXT,

    metadata JSONB,

    ip_address INET,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_audit_logs_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
);

CREATE INDEX idx_audit_logs_user_id
    ON audit_logs(user_id);

CREATE INDEX idx_audit_logs_action
    ON audit_logs(action);

CREATE INDEX idx_audit_logs_resource
    ON audit_logs(resource_type, resource_id);

CREATE INDEX idx_audit_logs_created_at
    ON audit_logs(created_at);