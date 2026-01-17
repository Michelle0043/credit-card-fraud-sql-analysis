-- 07_fraud_concentration.sql
-- Purpose: Analyze what percentage of frauds fall into top risk segments

WITH ranked_hours AS (
    SELECT
        CAST(Time / 3600 AS INTEGER) AS hour_bucket,
        COUNT(*) AS total_trans,
        SUM(Class) AS fraud_count,
        ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
    FROM creditcard
    GROUP BY hour_bucket
    ORDER BY fraud_count DESC
),
cumulative AS (
    SELECT
        hour_bucket,
        fraud_count,
        SUM(fraud_count) OVER (ORDER BY fraud_count DESC) AS cumulative_frauds,
        (SELECT SUM(Class) FROM creditcard) AS total_frauds
    FROM ranked_hours
)
SELECT
    hour_bucket,
    fraud_count,
    cumulative_frauds,
    ROUND(cumulative_frauds * 100.0 / total_frauds, 2) AS cumulative_pct
FROM cumulative
LIMIT 10;