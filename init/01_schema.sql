-- =============================================================================
-- Schema: Egyptian B2B/B2C Commerce + Security Audit Logs
-- Designed for both Data Analytics (KPIs, cohorts, window functions)
-- and GRC / SOC SQL investigations (failed logins, privilege changes).
-- =============================================================================

CREATE TABLE customers (
    customer_id   INTEGER PRIMARY KEY,
    full_name     VARCHAR(120) NOT NULL,
    city          VARCHAR(60)  NOT NULL,
    segment       VARCHAR(30)  NOT NULL, -- 'Enterprise', 'SMB', 'Consumer'
    signup_date   DATE         NOT NULL
);

CREATE TABLE products (
    product_id    INTEGER PRIMARY KEY,
    sku           VARCHAR(30)  NOT NULL UNIQUE,
    product_name  VARCHAR(120) NOT NULL,
    category      VARCHAR(50)  NOT NULL,
    unit_cost_egp NUMERIC(10,2) NOT NULL,
    unit_price_egp NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders (
    order_id      INTEGER PRIMARY KEY,
    customer_id   INTEGER NOT NULL REFERENCES customers(customer_id),
    order_date    DATE    NOT NULL,
    status        VARCHAR(20) NOT NULL, -- 'completed', 'cancelled', 'refunded'
    channel       VARCHAR(30) NOT NULL  -- 'web', 'mobile', 'account_exec'
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id      INTEGER NOT NULL REFERENCES orders(order_id),
    product_id    INTEGER NOT NULL REFERENCES products(product_id),
    quantity      INTEGER NOT NULL CHECK (quantity > 0),
    discount_pct  NUMERIC(5,2) NOT NULL DEFAULT 0
);

CREATE TABLE security_audit_logs (
    event_id      INTEGER PRIMARY KEY,
    event_time    TIMESTAMP   NOT NULL,
    username      VARCHAR(60) NOT NULL,
    source_ip     VARCHAR(45) NOT NULL,
    event_type    VARCHAR(40) NOT NULL, -- 'LOGIN_SUCCESS', 'LOGIN_FAILED', 'ROLE_CHANGED', 'DATA_EXPORT'
    resource      VARCHAR(80) NOT NULL,
    severity      VARCHAR(15) NOT NULL  -- 'INFO', 'WARN', 'HIGH', 'CRITICAL'
);
