-- Problem 02 (Window Function: DENSE_RANK partitioned by segment)
-- Goal: Rank customers within each business segment by completed gross profit (EGP).

WITH customer_profit AS (
    SELECT
        c.customer_id,
        c.full_name,
        c.segment,
        ROUND(
            SUM(
                oi.quantity * (
                    p.unit_price_egp * (1.0 - oi.discount_pct / 100.0) - p.unit_cost_egp
                )
            ),
            2
        ) AS gross_profit_egp
    FROM customers c
    JOIN orders o       ON o.customer_id = c.customer_id AND o.status = 'completed'
    JOIN order_items oi ON oi.order_id = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    GROUP BY c.customer_id, c.full_name, c.segment
)
SELECT
    segment,
    full_name,
    gross_profit_egp,
    DENSE_RANK() OVER (PARTITION BY segment ORDER BY gross_profit_egp DESC) AS segment_rank
FROM customer_profit
ORDER BY segment, segment_rank;
