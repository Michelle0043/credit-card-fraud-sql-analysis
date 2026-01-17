-- 12_executive_summary.sql
-- Purpose: One-page summary of key fraud patterns

SELECT 'OVERALL METRICS' AS category, '' AS subcategory, '' AS value
UNION ALL
SELECT '├─ Total Transactions', '', CAST(COUNT(*) AS TEXT) FROM creditcard
UNION ALL
SELECT '├─ Total Frauds', '', CAST(SUM(Class) AS TEXT) FROM creditcard
UNION ALL
SELECT '└─ Overall Fraud Rate', '', ROUND(SUM(Class)*100.0/COUNT(*), 2) || '%' FROM creditcard

UNION ALL SELECT '', '', ''
UNION ALL SELECT 'AMOUNT INSIGHTS', '', ''
UNION ALL
SELECT '├─ Highest Risk Bucket', 
       (SELECT amount_bucket FROM (
           SELECT CASE
               WHEN Amount < 10 THEN '< $10'
               WHEN Amount < 100 THEN '$10-$100'
               WHEN Amount < 500 THEN '$100-$500'
               ELSE '>$500'
           END AS amount_bucket,
           ROUND(SUM(Class)*1.0/COUNT(*), 4) AS fraud_rate
           FROM creditcard
           GROUP BY amount_bucket
           ORDER BY fraud_rate DESC LIMIT 1
       )),
       ''

UNION ALL SELECT '', '', ''
UNION ALL SELECT 'TIME INSIGHTS', '', ''
UNION ALL
SELECT '├─ Riskiest Hour Bucket',
       CAST((SELECT CAST(Time/3600 AS INTEGER) FROM creditcard 
             WHERE Class=1 GROUP BY CAST(Time/3600 AS INTEGER) 
             ORDER BY COUNT(*) DESC LIMIT 1) AS TEXT),
       ''

UNION ALL SELECT '', '', ''
UNION ALL SELECT 'FEATURE INSIGHTS', '', ''
UNION ALL
SELECT '└─ V17 Extreme Fraud Rate',
       '',
       (SELECT ROUND(SUM(Class)*100.0/COUNT(*), 2) || '%'
        FROM creditcard
        WHERE ABS(V17 - (SELECT AVG(V17) FROM creditcard)) > 5);