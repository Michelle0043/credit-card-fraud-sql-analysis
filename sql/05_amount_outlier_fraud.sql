-- 05_amount_outlier_fraud.sql
-- Purpose: Analyze fraud rate for statistical outliers in transaction amount

WITH amount_stats AS (
    SELECT
        AVG(Amount) AS mean_amount,
        SQRT(AVG(Amount * Amount) - AVG(Amount) * AVG(Amount)) AS stddev_amount
    FROM creditcard
)
SELECT
    CASE
        WHEN Amount > (SELECT mean_amount + 2 * stddev_amount FROM amount_stats) 
            THEN 'High Outlier (>2σ)'
        WHEN Amount > (SELECT mean_amount + stddev_amount FROM amount_stats) 
            THEN 'Above Average (1-2σ)'
        WHEN Amount > (SELECT mean_amount FROM amount_stats) 
            THEN 'Above Mean'
        ELSE 'Below Mean'
    END AS amount_category,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_count,
    ROUND(AVG(Amount), 2) AS avg_amount,
    ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
FROM creditcard
GROUP BY amount_category
ORDER BY fraud_rate DESC;