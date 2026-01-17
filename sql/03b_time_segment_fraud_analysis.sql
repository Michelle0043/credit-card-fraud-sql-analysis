-- 03b_time_segment_fraud_analysis.sql
-- Purpose:
-- Analyze fraud distribution by relative time segments
-- Note:
-- Time segments are defined heuristically for exploratory analysis
-- and do not represent actual clock time.

SELECT
    CASE
        WHEN hour_bucket BETWEEN 0 AND 5 THEN 'Hours 0–5'
        WHEN hour_bucket BETWEEN 6 AND 11 THEN 'Hours 6–11'
        WHEN hour_bucket BETWEEN 12 AND 17 THEN 'Hours 12–17'
        ELSE 'Hours 18–23'
    END AS time_segment,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_transactions,
    ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
FROM (
    SELECT
        CAST(Time / 3600 AS INTEGER) AS hour_bucket,
        Class
    FROM creditcard
) t
GROUP BY time_segment
ORDER BY fraud_rate DESC;