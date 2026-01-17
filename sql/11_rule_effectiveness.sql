-- 11_rule_effectiveness.sql
-- Purpose: Evaluate coverage and precision of risk rules

WITH flagged AS (
    SELECT
        Class,
        CASE
            WHEN Amount > 500
              OR ABS(V17 - (SELECT AVG(V17) FROM creditcard)) > 5
              OR CAST(Time / 3600 AS INTEGER) BETWEEN 0 AND 11
            THEN 1 ELSE 0
        END AS flagged
    FROM creditcard
)
SELECT
    flagged,
    COUNT(*) AS transactions,
    SUM(Class) AS frauds,
    ROUND(SUM(Class)*1.0/COUNT(*), 4) AS fraud_rate
FROM flagged
GROUP BY flagged;