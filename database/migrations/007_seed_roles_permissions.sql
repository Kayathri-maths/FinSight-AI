BEGIN;

-- =========================================================
-- 1. Roles
-- =========================================================

INSERT INTO roles (name, description)
VALUES
    ('ADMIN', 'Full access to the FinSight AI platform'),
    ('RISK_ANALYST', 'Analyzes transactions, risk assessments, and investigations'),
    ('OPERATIONS', 'Handles operational transaction and document activities'),
    ('COMPLIANCE', 'Handles compliance, investigations, documents, and reports'),
    ('VIEWER', 'Read-only access to platform information')
ON CONFLICT (name) DO NOTHING;


-- =========================================================
-- 2. Permissions
-- =========================================================

INSERT INTO permissions (name, description)
VALUES
    ('transaction.read', 'View transaction information'),
    ('transaction.investigate', 'Investigate suspicious transactions'),
    ('customer.read', 'View customer information'),
    ('merchant.read', 'View merchant information'),
    ('document.read', 'View documents'),
    ('document.upload', 'Upload documents'),
    ('document.delete', 'Delete documents'),
    ('ai.chat', 'Use the AI assistant'),
    ('investigation.create', 'Create AI or manual investigations'),
    ('report.create', 'Generate reports')
ON CONFLICT (name) DO NOTHING;


-- =========================================================
-- 3. ADMIN permissions
-- =========================================================

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
CROSS JOIN permissions p
WHERE r.name = 'ADMIN'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 4. RISK_ANALYST permissions
-- =========================================================

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
JOIN permissions p
    ON p.name IN (
        'transaction.read',
        'transaction.investigate',
        'customer.read',
        'merchant.read',
        'document.read',
        'ai.chat',
        'investigation.create',
        'report.create'
    )
WHERE r.name = 'RISK_ANALYST'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 5. OPERATIONS permissions
-- =========================================================

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
JOIN permissions p
    ON p.name IN (
        'transaction.read',
        'customer.read',
        'merchant.read',
        'document.read',
        'document.upload'
    )
WHERE r.name = 'OPERATIONS'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 6. COMPLIANCE permissions
-- =========================================================

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
JOIN permissions p
    ON p.name IN (
        'transaction.read',
        'customer.read',
        'merchant.read',
        'document.read',
        'document.upload',
        'document.delete',
        'investigation.create',
        'report.create'
    )
WHERE r.name = 'COMPLIANCE'
ON CONFLICT DO NOTHING;


-- =========================================================
-- 7. VIEWER permissions
-- =========================================================

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
JOIN permissions p
    ON p.name IN (
        'transaction.read',
        'customer.read',
        'merchant.read',
        'document.read',
        'ai.chat'
    )
WHERE r.name = 'VIEWER'
ON CONFLICT DO NOTHING;


COMMIT;