# 50 SQL Problems Checklist (Mission S1-02)

Create one `.sql` file per problem inside `problems/` (e.g., `problems/06_cancelled_order_rate.sql`) and verify with `python scripts/run_sql.py --all`.

## Reference Examples (Included: 5/50)
- [x] `01` Monthly net revenue & MoM growth % (`CTE` + `LAG`)
- [x] `02` Top customers per segment by gross profit (`CTE` + `DENSE_RANK`)
- [x] `03` Cohort repeat-purchase rate (`LEFT JOIN` + `CASE` + `CTE`)
- [x] `04` Product Pareto 80/20 cumulative share (`SUM() OVER` running frame)
- [x] `05` Brute-force login followed by privilege escalation (`SUM() OVER` + `LEAD`)

## Joins & Aggregations (06–20)
- [ ] `06` Order cancellation & refund rate by sales channel
- [ ] `07` Customers with zero completed orders (`LEFT JOIN ... IS NULL`)
- [ ] `08` Average order value (AOV) by city and customer segment
- [ ] `09` Gross margin % per product category
- [ ] `10` Products never ordered in cancelled/refunded orders (`NOT EXISTS`)
- [ ] `11` Top 3 cities by Enterprise segment revenue
- [ ] `12` Discount impact: total EGP discounted per product
- [ ] `13` Orders containing more than one distinct product category (`HAVING COUNT(DISTINCT ...)`)
- [ ] `14` Revenue contribution by acquisition channel per month
- [ ] `15` Average days from customer `signup_date` to first completed `order_date`
- [ ] `16` Customers who bought both `Security` and `Compliance` categories (`INTERSECT` or `HAVING`)
- [ ] `17` Highest single line-item net value and the customer who placed it
- [ ] `18` Category-level units sold vs. order count
- [ ] `19` Unprofitable or low-margin (< 35%) line items after discounts
- [ ] `20` Full customer summary card (orders, units, gross spend, net spend, last order date)

## Subqueries & CTEs (21–32)
- [ ] `21` Customers spending above the overall average customer spend (scalar subquery / CTE)
- [ ] `22` Products priced above their category average
- [ ] `23` First product ever purchased by each customer
- [ ] `24` Repeat customers whose second order value exceeded their first order value
- [ ] `25` Monthly active customers vs. new signups in the same month
- [ ] `26` Share of Security product revenue per Enterprise customer
- [ ] `27` Basket attach-rate: which product pairs appear together in the same order (`self-join`)
- [ ] `28` Customers inactive for >= 45 days after their latest completed order
- [ ] `29` Revenue lost to `cancelled` and `refunded` orders by month
- [ ] `30` Customer lifetime value (LTV) tiers (`Gold`, `Silver`, `Bronze`) using `CASE`
- [ ] `31` Channel mix shift between Q1 and Q2
- [ ] `32` Executive KPI single-row summary (Total Revenue, Gross Profit, Margin %, Active Customers, AOV)

## Window Functions (33–42)
- [ ] `33` `ROW_NUMBER`: first completed order per customer
- [ ] `34` `NTILE(4)`: quartile segmentation of orders by net value
- [ ] `35` Rolling 2-order moving average spend per customer (`AVG() OVER`)
- [ ] `36` Days elapsed between consecutive orders per customer (`LAG(order_date)`)
- [ ] `37` Rank products by units sold vs. rank by profit (`RANK` comparison)
- [ ] `38` Each order's % of that customer's lifetime spend (`SUM() OVER (PARTITION BY customer_id)`)
- [ ] `39` Highest-value order per month (`FIRST_VALUE` or `ROW_NUMBER = 1`)
- [ ] `40` Cumulative customer signups over time
- [ ] `41` Difference between each order's value and the customer's average order value
- [ ] `42` Identify orders where discount % exceeds the product's historical average discount

## GRC & SOC Audit Log SQL (43–50)
- [ ] `43` Count of security events by `event_type` and `severity`
- [ ] `44` External (non-RFC1918 `10.*`) IP addresses accessing internal resources
- [ ] `45` Off-hours privileged events (between `22:00` and `06:00`)
- [ ] `46` Users with failed login ratio > 50%
- [ ] `47` Sensitive `DATA_EXPORT` or `ROLE_CHANGED` events within 10 minutes of login (`LAG`)
- [ ] `48` Distinct source IPs per user (impossible travel / multi-IP anomaly indicator)
- [ ] `49` Full incident timeline reconstruction for `185.220.101.9`
- [ ] `50` Daily compliance summary view: total logins, failures, role changes, exports, critical alerts
