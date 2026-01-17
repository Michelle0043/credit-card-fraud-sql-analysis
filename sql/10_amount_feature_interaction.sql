-- 10_amount_feature_interaction.sql
-- Purpose: Compare V17 patterns between small and large transactions

WITH amount_segments AS (
    SELECT
        CASE WHEN Amount < 100 THEN 'Small Amount' ELSE 'Large Amount' END AS amount_group,
        CASE 
            WHEN ABS(V17 - (SELECT AVG(V17) FROM creditcard)) > 5 THEN 'V17 Extreme'
            ELSE 'V17 Normal'
        END AS v17_category,
        Class
    FROM creditcard
)
SELECT
    amount_group,
    v17_category,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_count,
    ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
FROM amount_segments
GROUP BY amount_group, v17_category
ORDER BY fraud_rate DESC;