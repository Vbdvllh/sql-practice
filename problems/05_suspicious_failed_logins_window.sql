-- Problem 05 (SOC / GRC Audit Log Investigation with Window Functions)
-- Goal: Detect brute-force sequences where a LOGIN_SUCCESS follows >= 3 LOGIN_FAILED
--       events from the same (username, source_ip) pair, plus subsequent privileged actions.

WITH annotated_events AS (
    SELECT
        event_id,
        event_time,
        username,
        source_ip,
        event_type,
        resource,
        severity,
        SUM(CASE WHEN event_type = 'LOGIN_FAILED' THEN 1 ELSE 0 END) OVER (
            PARTITION BY username, source_ip
            ORDER BY event_time
            ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING
        ) AS prior_failures_in_window,
        LEAD(event_type, 1) OVER (
            PARTITION BY username, source_ip
            ORDER BY event_time
        ) AS next_action_1,
        LEAD(event_type, 2) OVER (
            PARTITION BY username, source_ip
            ORDER BY event_time
        ) AS next_action_2
    FROM security_audit_logs
)
SELECT
    event_time,
    username,
    source_ip,
    prior_failures_in_window,
    event_type AS compromise_event,
    next_action_1,
    next_action_2
FROM annotated_events
WHERE event_type = 'LOGIN_SUCCESS'
  AND prior_failures_in_window >= 3
ORDER BY event_time;
