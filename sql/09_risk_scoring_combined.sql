-- 09_risk_scoring_combined.sql
-- Purpose: Create a simple risk score combining amount, time, and V features

WITH risk_factors AS (
    SELECT
        -- Amount risk
        CASE WHEN Amount > 500 THEN 1 ELSE 0 END AS high_amount_flag,
        -- Time risk (based on your 03b findings)
        CASE WHEN CAST(Time / 3600 AS INTEGER) BETWEEN 0 AND 11 THEN 1 ELSE 0 END AS risky_time_flag,
        -- V17 extreme risk (based on your 04a)
        CASE WHEN ABS(V17 - (SELECT AVG(V17) FROM creditcard)) > 5 THEN 1 ELSE 0 END AS v17_extreme_flag,
        -- V14 extreme risk
        CASE WHEN ABS(V14 - (SELECT AVG(V14) FROM creditcard)) > 5 THEN 1 ELSE 0 END AS v14_extreme_flag,
        Class
    FROM creditcard
)
SELECT
    (high_amount_flag + risky_time_flag + v17_extreme_flag + v14_extreme_flag) AS risk_score,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_count,
    ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
FROM risk_factors
GROUP BY risk_score
ORDER BY risk_score DESC;