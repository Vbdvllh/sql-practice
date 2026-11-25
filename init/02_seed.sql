-- Seed data for SQL practice (PostgreSQL & SQLite compatible)

INSERT INTO customers (customer_id, full_name, city, segment, signup_date) VALUES
(1, 'Nour El-Din Corp',   'Cairo',      'Enterprise', '2026-01-10'),
(2, 'Delta Logistics',    'Alexandria', 'Enterprise', '2026-01-22'),
(3, 'Salma Retail',       'Giza',       'SMB',        '2026-02-05'),
(4, 'Mansoura Tech',      'Mansoura',   'SMB',        '2026-02-18'),
(5, 'Karim Hassan',       'Cairo',      'Consumer',   '2026-03-02'),
(6, 'Canal Trade Group',  'Ismailia',   'Enterprise', '2026-03-15'),
(7, 'Aswan Solar Co',     'Aswan',      'SMB',        '2026-04-01'),
(8, 'Mona Abdelrahman',   'Alexandria', 'Consumer',   '2026-04-12');

INSERT INTO products (product_id, sku, product_name, category, unit_cost_egp, unit_price_egp) VALUES
(101, 'NET-FW-01', 'Managed Firewall Appliance', 'Security',   18000.00, 26500.00),
(102, 'CLD-BK-02', 'Cloud Backup Annual Seat',   'Cloud',       1200.00,  2200.00),
(103, 'BI-DSH-03', 'Executive BI License',       'Analytics',   2500.00,  4800.00),
(104, 'GRC-AUD-04','ISO 27001 Readiness Kit',    'Compliance',  6000.00, 11500.00),
(105, 'END-EDR-05','Endpoint Detection Seat',    'Security',     850.00,  1600.00);

INSERT INTO orders (order_id, customer_id, order_date, status, channel) VALUES
(1001, 1, '2026-01-15', 'completed', 'account_exec'),
(1002, 2, '2026-01-28', 'completed', 'account_exec'),
(1003, 3, '2026-02-10', 'completed', 'web'),
(1004, 1, '2026-02-19', 'completed', 'account_exec'),
(1005, 4, '2026-02-25', 'cancelled', 'web'),
(1006, 5, '2026-03-05', 'completed', 'mobile'),
(1007, 6, '2026-03-20', 'completed', 'account_exec'),
(1008, 2, '2026-03-27', 'completed', 'web'),
(1009, 1, '2026-04-04', 'completed', 'account_exec'),
(1010, 7, '2026-04-11', 'completed', 'web'),
(1011, 3, '2026-04-18', 'refunded',  'mobile'),
(1012, 8, '2026-04-24', 'completed', 'mobile'),
(1013, 6, '2026-05-03', 'completed', 'account_exec'),
(1014, 2, '2026-05-16', 'completed', 'account_exec');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, discount_pct) VALUES
(1,  1001, 101, 2,  5.0),
(2,  1001, 105, 25, 10.0),
(3,  1002, 104, 1,  0.0),
(4,  1003, 102, 10, 0.0),
(5,  1004, 103, 8,  5.0),
(6,  1005, 102, 5,  0.0),
(7,  1006, 105, 2,  0.0),
(8,  1007, 101, 3,  10.0),
(9,  1007, 104, 2,  5.0),
(10, 1008, 103, 5,  0.0),
(11, 1009, 104, 1,  0.0),
(12, 1010, 102, 12, 5.0),
(13, 1011, 105, 4,  0.0),
(14, 1012, 103, 1,  0.0),
(15, 1013, 105, 50, 15.0),
(16, 1014, 101, 1,  0.0),
(17, 1014, 103, 6,  5.0);

INSERT INTO security_audit_logs (event_id, event_time, username, source_ip, event_type, resource, severity) VALUES
(1,  '2026-05-01 08:55:10', 'ahmed.admin', '10.10.1.15',    'LOGIN_SUCCESS', 'erp-portal',    'INFO'),
(2,  '2026-05-01 09:12:01', 'sara.fin',    '10.10.2.44',    'LOGIN_SUCCESS', 'payroll-db',    'INFO'),
(3,  '2026-05-01 23:01:11', 'ahmed.admin', '185.220.101.9', 'LOGIN_FAILED',  'erp-portal',    'WARN'),
(4,  '2026-05-01 23:01:24', 'ahmed.admin', '185.220.101.9', 'LOGIN_FAILED',  'erp-portal',    'WARN'),
(5,  '2026-05-01 23:01:39', 'ahmed.admin', '185.220.101.9', 'LOGIN_FAILED',  'erp-portal',    'HIGH'),
(6,  '2026-05-01 23:01:52', 'ahmed.admin', '185.220.101.9', 'LOGIN_SUCCESS', 'erp-portal',    'CRITICAL'),
(7,  '2026-05-01 23:04:05', 'ahmed.admin', '185.220.101.9', 'ROLE_CHANGED',  'iam-roles',     'CRITICAL'),
(8,  '2026-05-01 23:06:18', 'ahmed.admin', '185.220.101.9', 'DATA_EXPORT',   'customers-csv', 'CRITICAL'),
(9,  '2026-05-02 10:15:00', 'omar.analyst','10.10.3.21',    'LOGIN_FAILED',  'bi-dashboard',  'INFO'),
(10, '2026-05-02 10:15:19', 'omar.analyst','10.10.3.21',    'LOGIN_SUCCESS', 'bi-dashboard',  'INFO');
