-- 03_time_based_fraud_patterns.sql
-- Purpose:
-- Analyze fraud distribution by hourly time buckets

SELECT
    CAST(Time / 3600 AS INTEGER) AS hour_bucket,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_transactions,
    ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
FROM creditcard
GROUP BY hour_bucket
ORDER BY fraud_rate DESC;

-- Fraud activity is unevenly distributed over time, 
-- with certain hourly periods exhibiting significantly 
-- higher fraud rates.