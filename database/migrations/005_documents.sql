-- FinSight AI
-- Migration: 005_documents
-- Purpose: Create document management and RAG tables

-- ============================================================
-- DOCUMENTS
-- ============================================================

CREATE TABLE documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_code VARCHAR(40) NOT NULL UNIQUE,

    name VARCHAR(255) NOT NULL,
    description TEXT,

    file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    file_size BIGINT NOT NULL,

    storage_path TEXT NOT NULL,

    department VARCHAR(100),

    uploaded_by UUID NOT NULL,

    access_level VARCHAR(30) NOT NULL DEFAULT 'INTERNAL',

    processing_status VARCHAR(30) NOT NULL DEFAULT 'PENDING',

    current_version INTEGER NOT NULL DEFAULT 1,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_documents_uploaded_by
        FOREIGN KEY (uploaded_by)
        REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_documents_file_size
        CHECK (file_size >= 0),

    CONSTRAINT chk_documents_access_level
        CHECK (
            access_level IN (
                'PUBLIC',
                'INTERNAL',
                'CONFIDENTIAL',
                'RESTRICTED'
            )
        ),

    CONSTRAINT chk_documents_processing_status
        CHECK (
            processing_status IN (
                'PENDING',
                'PROCESSING',
                'COMPLETED',
                'FAILED'
            )
        ),

    CONSTRAINT chk_documents_current_version
        CHECK (current_version >= 1)
);

CREATE INDEX idx_documents_uploaded_by
    ON documents(uploaded_by);

CREATE INDEX idx_documents_department
    ON documents(department);

CREATE INDEX idx_documents_access_level
    ON documents(access_level);

CREATE INDEX idx_documents_processing_status
    ON documents(processing_status);


-- ============================================================
-- DOCUMENT VERSIONS
-- ============================================================

CREATE TABLE document_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    document_id UUID NOT NULL,

    version_number INTEGER NOT NULL,

    storage_path TEXT NOT NULL,

    file_hash VARCHAR(128) NOT NULL,

    file_size BIGINT NOT NULL,

    uploaded_by UUID NOT NULL,

    processing_status VARCHAR(30) NOT NULL DEFAULT 'PENDING',

    processed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_document_versions_document
        FOREIGN KEY (document_id)
        REFERENCES documents(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_document_versions_uploaded_by
        FOREIGN KEY (uploaded_by)
        REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_document_versions_number
        CHECK (version_number >= 1),

    CONSTRAINT chk_document_versions_file_size
        CHECK (file_size >= 0),

    CONSTRAINT chk_document_versions_status
        CHECK (
            processing_status IN (
                'PENDING',
                'PROCESSING',
                'COMPLETED',
                'FAILED'
            )
        ),

    CONSTRAINT uq_document_version
        UNIQUE (document_id, version_number)
);

CREATE INDEX idx_document_versions_document_id
    ON document_versions(document_id);

CREATE INDEX idx_document_versions_status
    ON document_versions(processing_status);


-- ============================================================
-- DOCUMENT CHUNKS
-- ============================================================

CREATE TABLE document_chunks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    document_version_id UUID NOT NULL,

    chunk_index INTEGER NOT NULL,

    content TEXT NOT NULL,

    page_number INTEGER,

    section_title VARCHAR(255),

    token_count INTEGER,

    embedding VECTOR(1536),

    metadata JSONB,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_document_chunks_version
        FOREIGN KEY (document_version_id)
        REFERENCES document_versions(id)
        ON DELETE CASCADE,

    CONSTRAINT chk_document_chunks_index
        CHECK (chunk_index >= 0),

    CONSTRAINT chk_document_chunks_page
        CHECK (page_number IS NULL OR page_number >= 1),

    CONSTRAINT chk_document_chunks_token_count
        CHECK (token_count IS NULL OR token_count >= 0),

    CONSTRAINT uq_document_chunk
        UNIQUE (document_version_id, chunk_index)
);

CREATE INDEX idx_document_chunks_version_id
    ON document_chunks(document_version_id);

CREATE INDEX idx_document_chunks_page_number
    ON document_chunks(page_number);

CREATE INDEX idx_document_chunks_metadata
    ON document_chunks
    USING GIN(metadata);