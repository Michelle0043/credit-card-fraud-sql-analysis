-- 04a_v17_anomaly_analysis.sql
-- Purpose:
-- Analyze fraud rate for extreme values of V17

WITH v17_stats AS (
    SELECT
        AVG(V17) AS mean_v17
    FROM creditcard
),
v17_extreme AS (
    SELECT
        CASE
            WHEN ABS(V17 - (SELECT mean_v17 FROM v17_stats)) > 5 THEN 'Extreme'
            ELSE 'Normal'
        END AS v17_group,
        Class
    FROM creditcard
)
SELECT
    v17_group,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_transactions,
    ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
FROM v17_extreme
GROUP BY v17_group;