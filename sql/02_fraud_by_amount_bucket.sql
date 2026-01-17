-- 02_fraud_by_amount_bucket.sql
-- Purpose:
-- Analyze fraud distribution across transaction amount ranges

SELECT
    CASE
        WHEN Amount < 10 THEN '< $10'
        WHEN Amount < 100 THEN '$10 - $100'
        WHEN Amount < 500 THEN '$100 - $500'
        WHEN Amount < 1000 THEN '$500 - $1000'
        ELSE '> $1000'
    END AS amount_bucket,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_transactions,
    ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
FROM creditcard
GROUP BY amount_bucket
ORDER BY fraud_rate DESC;
