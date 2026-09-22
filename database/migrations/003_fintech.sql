-- FinSight AI
-- Migration: 003_fintech
-- Purpose: Create core FinTech business tables

-- ============================================================
-- CUSTOMERS
-- ============================================================

CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_code VARCHAR(40) NOT NULL UNIQUE,

    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),

    email VARCHAR(255),
    phone VARCHAR(30),

    date_of_birth DATE,
    account_created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_customers_status
        CHECK (status IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'CLOSED'))
);

CREATE INDEX idx_customers_status
    ON customers(status);

CREATE INDEX idx_customers_email
    ON customers(email);


-- ============================================================
-- MERCHANTS
-- ============================================================

CREATE TABLE merchants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    merchant_code VARCHAR(40) NOT NULL UNIQUE,

    business_name VARCHAR(255) NOT NULL,
    business_type VARCHAR(100),

    email VARCHAR(255),
    phone VARCHAR(30),

    gst_number VARCHAR(30),

    onboarding_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_merchants_status
        CHECK (status IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'CLOSED', 'PENDING'))
);

CREATE INDEX idx_merchants_status
    ON merchants(status);

CREATE INDEX idx_merchants_business_name
    ON merchants(business_name);


-- ============================================================
-- WALLETS
-- ============================================================

CREATE TABLE wallets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    wallet_code VARCHAR(40) NOT NULL UNIQUE,

    customer_id UUID NOT NULL,

    balance NUMERIC(18,2) NOT NULL DEFAULT 0.00,
    currency CHAR(3) NOT NULL DEFAULT 'INR',

    status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_wallets_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_wallets_balance
        CHECK (balance >= 0),

    CONSTRAINT chk_wallets_status
        CHECK (status IN ('ACTIVE', 'BLOCKED', 'CLOSED')),

    CONSTRAINT chk_wallets_currency
        CHECK (currency ~ '^[A-Z]{3}$')
);

CREATE INDEX idx_wallets_customer_id
    ON wallets(customer_id);

CREATE INDEX idx_wallets_status
    ON wallets(status);


-- ============================================================
-- TRANSACTIONS
-- ============================================================

CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    transaction_code VARCHAR(40) NOT NULL UNIQUE,

    customer_id UUID NOT NULL,
    merchant_id UUID NOT NULL,
    wallet_id UUID,

    amount NUMERIC(18,2) NOT NULL,
    currency CHAR(3) NOT NULL DEFAULT 'INR',

    transaction_type VARCHAR(30) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,

    status VARCHAR(30) NOT NULL,

    failure_reason TEXT,

    device_id VARCHAR(255),
    is_new_device BOOLEAN NOT NULL DEFAULT FALSE,

    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100) DEFAULT 'India',
    is_new_location BOOLEAN NOT NULL DEFAULT FALSE,

    ip_address INET,

    channel VARCHAR(30),

    transaction_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_transactions_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_transactions_merchant
        FOREIGN KEY (merchant_id)
        REFERENCES merchants(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_transactions_wallet
        FOREIGN KEY (wallet_id)
        REFERENCES wallets(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_transactions_amount
        CHECK (amount > 0),

    CONSTRAINT chk_transactions_currency
        CHECK (currency ~ '^[A-Z]{3}$'),

    CONSTRAINT chk_transactions_type
        CHECK (
            transaction_type IN (
                'PAYMENT',
                'TRANSFER',
                'WITHDRAWAL',
                'DEPOSIT',
                'REFUND'
            )
        ),

    CONSTRAINT chk_transactions_payment_method
        CHECK (
            payment_method IN (
                'UPI',
                'CARD',
                'NET_BANKING',
                'WALLET',
                'BANK_TRANSFER',
                'CASH'
            )
        ),

    CONSTRAINT chk_transactions_status
        CHECK (
            status IN (
                'PENDING',
                'SUCCESS',
                'FAILED',
                'CANCELLED',
                'REVERSED'
            )
        )
);

CREATE INDEX idx_transactions_customer_id
    ON transactions(customer_id);

CREATE INDEX idx_transactions_merchant_id
    ON transactions(merchant_id);

CREATE INDEX idx_transactions_wallet_id
    ON transactions(wallet_id);

CREATE INDEX idx_transactions_status
    ON transactions(status);

CREATE INDEX idx_transactions_transaction_time
    ON transactions(transaction_time);

CREATE INDEX idx_transactions_customer_time
    ON transactions(customer_id, transaction_time);

CREATE INDEX idx_transactions_merchant_time
    ON transactions(merchant_id, transaction_time);


-- ============================================================
-- PAYMENTS
-- ============================================================

CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    payment_code VARCHAR(40) NOT NULL UNIQUE,

    transaction_id UUID NOT NULL,

    gateway VARCHAR(100),
    gateway_transaction_id VARCHAR(255),

    payment_method VARCHAR(30) NOT NULL,

    amount NUMERIC(18,2) NOT NULL,
    currency CHAR(3) NOT NULL DEFAULT 'INR',

    status VARCHAR(30) NOT NULL,

    processed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_payments_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_payments_amount
        CHECK (amount > 0),

    CONSTRAINT chk_payments_currency
        CHECK (currency ~ '^[A-Z]{3}$'),

    CONSTRAINT chk_payments_status
        CHECK (
            status IN (
                'INITIATED',
                'PROCESSING',
                'SUCCESS',
                'FAILED',
                'CANCELLED'
            )
        )
);

CREATE INDEX idx_payments_transaction_id
    ON payments(transaction_id);

CREATE INDEX idx_payments_gateway_transaction_id
    ON payments(gateway_transaction_id);

CREATE INDEX idx_payments_status
    ON payments(status);


-- ============================================================
-- REFUNDS
-- ============================================================

CREATE TABLE refunds (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    refund_code VARCHAR(40) NOT NULL UNIQUE,

    transaction_id UUID NOT NULL,
    payment_id UUID,

    customer_id UUID NOT NULL,

    amount NUMERIC(18,2) NOT NULL,

    reason TEXT,

    status VARCHAR(30) NOT NULL DEFAULT 'PENDING',

    requested_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    processed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_refunds_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_refunds_payment
        FOREIGN KEY (payment_id)
        REFERENCES payments(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_refunds_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_refunds_amount
        CHECK (amount > 0),

    CONSTRAINT chk_refunds_status
        CHECK (
            status IN (
                'PENDING',
                'PROCESSING',
                'COMPLETED',
                'REJECTED',
                'CANCELLED'
            )
        )
);

CREATE INDEX idx_refunds_transaction_id
    ON refunds(transaction_id);

CREATE INDEX idx_refunds_customer_id
    ON refunds(customer_id);

CREATE INDEX idx_refunds_status
    ON refunds(status);


-- ============================================================
-- CHARGEBACKS
-- ============================================================

CREATE TABLE chargebacks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    chargeback_code VARCHAR(40) NOT NULL UNIQUE,

    transaction_id UUID NOT NULL,
    customer_id UUID NOT NULL,
    merchant_id UUID NOT NULL,

    amount NUMERIC(18,2) NOT NULL,

    reason_code VARCHAR(50),
    reason_description TEXT,

    status VARCHAR(30) NOT NULL DEFAULT 'OPEN',

    dispute_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    response_due_date TIMESTAMPTZ,

    resolved_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_chargebacks_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_chargebacks_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_chargebacks_merchant
        FOREIGN KEY (merchant_id)
        REFERENCES merchants(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_chargebacks_amount
        CHECK (amount > 0),

    CONSTRAINT chk_chargebacks_status
        CHECK (
            status IN (
                'OPEN',
                'UNDER_REVIEW',
                'ACCEPTED',
                'REPRESENTED',
                'WON',
                'LOST',
                'CLOSED'
            )
        )
);

CREATE INDEX idx_chargebacks_transaction_id
    ON chargebacks(transaction_id);

CREATE INDEX idx_chargebacks_customer_id
    ON chargebacks(customer_id);

CREATE INDEX idx_chargebacks_merchant_id
    ON chargebacks(merchant_id);

CREATE INDEX idx_chargebacks_status
    ON chargebacks(status);

CREATE INDEX idx_chargebacks_response_due_date
    ON chargebacks(response_due_date);


-- ============================================================
-- SETTLEMENTS
-- ============================================================

CREATE TABLE settlements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    settlement_code VARCHAR(40) NOT NULL UNIQUE,

    merchant_id UUID NOT NULL,

    settlement_date DATE NOT NULL,

    gross_amount NUMERIC(18,2) NOT NULL DEFAULT 0.00,
    refund_amount NUMERIC(18,2) NOT NULL DEFAULT 0.00,
    chargeback_amount NUMERIC(18,2) NOT NULL DEFAULT 0.00,
    fee_amount NUMERIC(18,2) NOT NULL DEFAULT 0.00,
    net_amount NUMERIC(18,2) NOT NULL DEFAULT 0.00,

    currency CHAR(3) NOT NULL DEFAULT 'INR',

    status VARCHAR(30) NOT NULL DEFAULT 'PENDING',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_settlements_merchant
        FOREIGN KEY (merchant_id)
        REFERENCES merchants(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_settlements_amounts
        CHECK (
            gross_amount >= 0
            AND refund_amount >= 0
            AND chargeback_amount >= 0
            AND fee_amount >= 0
        ),

    CONSTRAINT chk_settlements_currency
        CHECK (currency ~ '^[A-Z]{3}$'),

    CONSTRAINT chk_settlements_status
        CHECK (
            status IN (
                'PENDING',
                'PROCESSING',
                'COMPLETED',
                'FAILED'
            )
        )
);

CREATE INDEX idx_settlements_merchant_id
    ON settlements(merchant_id);

CREATE INDEX idx_settlements_settlement_date
    ON settlements(settlement_date);

CREATE INDEX idx_settlements_status
    ON settlements(status);