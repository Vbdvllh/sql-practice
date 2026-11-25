-- Problem 04 (Running Total / Cumulative Revenue Share - Pareto 80/20)
-- Goal: Compute each product's share of total revenue and cumulative running share.

WITH product_rev AS (
    SELECT
        p.sku,
        p.product_name,
        p.category,
        ROUND(
            SUM(oi.quantity * p.unit_price_egp * (1.0 - oi.discount_pct / 100.0)),
            2
        ) AS revenue_egp
    FROM products p
    JOIN order_items oi ON oi.product_id = p.product_id
    JOIN orders o       ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY p.sku, p.product_name, p.category
)
SELECT
    sku,
    product_name,
    category,
    revenue_egp,
    ROUND(100.0 * revenue_egp / SUM(revenue_egp) OVER (), 2) AS pct_of_total,
    ROUND(
        100.0 * SUM(revenue_egp) OVER (
            ORDER BY revenue_egp DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) / SUM(revenue_egp) OVER (),
        2
    ) AS cumulative_share_pct
FROM product_rev
ORDER BY revenue_egp DESC;
