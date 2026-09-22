-- FinSight AI
-- Migration: 004_risk
-- Purpose: Create ML risk assessment and anomaly detection tables

-- ============================================================
-- RISK ASSESSMENTS
-- ============================================================

CREATE TABLE risk_assessments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    transaction_id UUID NOT NULL,

    model_name VARCHAR(100) NOT NULL,
    model_version VARCHAR(50) NOT NULL,

    risk_score NUMERIC(5,4) NOT NULL,
    risk_level VARCHAR(20) NOT NULL,

    prediction VARCHAR(30) NOT NULL,

    feature_snapshot JSONB,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_risk_assessments_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_risk_score
        CHECK (risk_score >= 0 AND risk_score <= 1),

    CONSTRAINT chk_risk_level
        CHECK (
            risk_level IN (
                'LOW',
                'MEDIUM',
                'HIGH',
                'CRITICAL'
            )
        ),

    CONSTRAINT chk_risk_prediction
        CHECK (
            prediction IN (
                'LEGITIMATE',
                'SUSPICIOUS',
                'FRAUD'
            )
        )
);

CREATE INDEX idx_risk_assessments_transaction_id
    ON risk_assessments(transaction_id);

CREATE INDEX idx_risk_assessments_risk_level
    ON risk_assessments(risk_level);

CREATE INDEX idx_risk_assessments_created_at
    ON risk_assessments(created_at);

CREATE INDEX idx_risk_assessments_score
    ON risk_assessments(risk_score);


-- ============================================================
-- ANOMALIES
-- ============================================================

CREATE TABLE anomalies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    entity_type VARCHAR(50) NOT NULL,
    entity_id UUID NOT NULL,

    anomaly_type VARCHAR(100) NOT NULL,

    anomaly_score NUMERIC(5,4) NOT NULL,
    severity VARCHAR(20) NOT NULL,

    description TEXT,

    detection_method VARCHAR(100) NOT NULL,

    status VARCHAR(30) NOT NULL DEFAULT 'OPEN',

    detected_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    resolved_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_anomaly_score
        CHECK (anomaly_score >= 0 AND anomaly_score <= 1),

    CONSTRAINT chk_anomaly_severity
        CHECK (
            severity IN (
                'LOW',
                'MEDIUM',
                'HIGH',
                'CRITICAL'
            )
        ),

    CONSTRAINT chk_anomaly_status
        CHECK (
            status IN (
                'OPEN',
                'INVESTIGATING',
                'RESOLVED',
                'DISMISSED'
            )
        )
);

CREATE INDEX idx_anomalies_entity
    ON anomalies(entity_type, entity_id);

CREATE INDEX idx_anomalies_anomaly_type
    ON anomalies(anomaly_type);

CREATE INDEX idx_anomalies_severity
    ON anomalies(severity);

CREATE INDEX idx_anomalies_status
    ON anomalies(status);

CREATE INDEX idx_anomalies_detected_at
    ON anomalies(detected_at);