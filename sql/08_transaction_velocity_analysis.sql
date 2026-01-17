-- 08_transaction_velocity_analysis.sql
-- Purpose: Analyze fraud patterns based on transaction density per time period

WITH hourly_activity AS (
    SELECT
        CAST(Time / 3600 AS INTEGER) AS hour_bucket,
        COUNT(*) AS transactions_per_hour,
        SUM(Class) AS fraud_count
    FROM creditcard
    GROUP BY hour_bucket
)
SELECT
    CASE
        WHEN transactions_per_hour < 1000 THEN 'Low Activity (<1000)'
        WHEN transactions_per_hour < 5000 THEN 'Medium Activity (1000-5000)'
        WHEN transactions_per_hour < 10000 THEN 'High Activity (5000-10000)'
        ELSE 'Very High Activity (>10000)'
    END AS activity_level,
    COUNT(*) AS time_periods,
    SUM(transactions_per_hour) AS total_transactions,
    SUM(fraud_count) AS total_frauds,
    ROUND(SUM(fraud_count) * 1.0 / SUM(transactions_per_hour), 4) AS fraud_rate
FROM hourly_activity
GROUP BY activity_level
ORDER BY fraud_rate DESC;