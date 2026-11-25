-- Problem 01 (Window Function: LAG + CTE)
-- Goal: Compute monthly net completed revenue (EGP) and month-over-month growth %.

WITH monthly_revenue AS (
    SELECT
        SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7) AS order_month,
        ROUND(
            SUM(oi.quantity * p.unit_price_egp * (1.0 - oi.discount_pct / 100.0)),
            2
        ) AS net_revenue_egp
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.status = 'completed'
    GROUP BY SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7)
)
SELECT
    order_month,
    net_revenue_egp,
    LAG(net_revenue_egp) OVER (ORDER BY order_month) AS prev_month_egp,
    ROUND(
        100.0 * (net_revenue_egp - LAG(net_revenue_egp) OVER (ORDER BY order_month))
        / NULLIF(LAG(net_revenue_egp) OVER (ORDER BY order_month), 0),
        2
    ) AS mom_growth_pct
FROM monthly_revenue
ORDER BY order_month;
