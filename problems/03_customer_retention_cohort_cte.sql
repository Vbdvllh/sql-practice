-- Problem 03 (Multi-CTE Cohort Retention)
-- Goal: Group customers by signup month and count how many placed >= 2 completed orders.

WITH order_counts AS (
    SELECT
        c.customer_id,
        SUBSTR(CAST(c.signup_date AS VARCHAR(10)), 1, 7) AS cohort_month,
        COUNT(o.order_id) AS completed_orders
    FROM customers c
    LEFT JOIN orders o
        ON o.customer_id = c.customer_id
       AND o.status = 'completed'
    GROUP BY c.customer_id, SUBSTR(CAST(c.signup_date AS VARCHAR(10)), 1, 7)
)
SELECT
    cohort_month,
    COUNT(*) AS cohort_size,
    SUM(CASE WHEN completed_orders >= 1 THEN 1 ELSE 0 END) AS active_buyers,
    SUM(CASE WHEN completed_orders >= 2 THEN 1 ELSE 0 END) AS repeat_buyers,
    ROUND(
        100.0 * SUM(CASE WHEN completed_orders >= 2 THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS repeat_rate_pct
FROM order_counts
GROUP BY cohort_month
ORDER BY cohort_month;
