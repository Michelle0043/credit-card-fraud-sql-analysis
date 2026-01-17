-- 06_fraud_vs_legit_amount_comparison.sql
-- Purpose: Compare amount distributions between fraud and legitimate transactions

WITH fraud_stats AS (
    SELECT
        COUNT(*) AS fraud_count,
        ROUND(AVG(Amount), 2) AS fraud_avg,
        ROUND(MIN(Amount), 2) AS fraud_min,
        ROUND(MAX(Amount), 2) AS fraud_max
    FROM creditcard
    WHERE Class = 1
),
legit_stats AS (
    SELECT
        COUNT(*) AS legit_count,
        ROUND(AVG(Amount), 2) AS legit_avg,
        ROUND(MIN(Amount), 2) AS legit_min,
        ROUND(MAX(Amount), 2) AS legit_max
    FROM creditcard
    WHERE Class = 0
)
SELECT
    'Fraud Transactions' AS category,
    fraud_count AS count,
    fraud_min AS min,
    fraud_avg AS average,
    fraud_max AS max
FROM fraud_stats

UNION ALL

SELECT
    'Legitimate Transactions',
    legit_count,
    legit_min,
    legit_avg,
    legit_max
FROM legit_stats;