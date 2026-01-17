-- 04b_multifeature_anomaly_analysis.sql
-- Purpose:
-- Analyze fraud rate for multiple features: V10, V12, V14, V17

WITH stats AS (
    SELECT 
        AVG(V10) AS mean_v10,
        AVG(V12) AS mean_v12,
        AVG(V14) AS mean_v14,
        AVG(V17) AS mean_v17
    FROM creditcard
),
extreme_flags AS (
    SELECT
        CASE WHEN ABS(V10 - (SELECT mean_v10 FROM stats)) > 5 THEN 'Extreme' ELSE 'Normal' END AS V10_group,
        CASE WHEN ABS(V12 - (SELECT mean_v12 FROM stats)) > 5 THEN 'Extreme' ELSE 'Normal' END AS V12_group,
        CASE WHEN ABS(V14 - (SELECT mean_v14 FROM stats)) > 5 THEN 'Extreme' ELSE 'Normal' END AS V14_group,
        CASE WHEN ABS(V17 - (SELECT mean_v17 FROM stats)) > 5 THEN 'Extreme' ELSE 'Normal' END AS V17_group,
        Class
    FROM creditcard
)
-- Aggregate fraud rates per feature
SELECT 'V10' AS feature, V10_group AS group_type,
       COUNT(*) AS total_transactions,
       SUM(Class) AS fraud_transactions,
       ROUND(SUM(Class) * 1.0 / COUNT(*), 4) AS fraud_rate
FROM extreme_flags
GROUP BY V10_group
UNION ALL
SELECT 'V12', V12_group,
       COUNT(*), SUM(Class),
       ROUND(SUM(Class) * 1.0 / COUNT(*), 4)
FROM extreme_flags
GROUP BY V12_group
UNION ALL
SELECT 'V14', V14_group,
       COUNT(*), SUM(Class),
       ROUND(SUM(Class) * 1.0 / COUNT(*), 4)
FROM extreme_flags
GROUP BY V14_group
UNION ALL
SELECT 'V17', V17_group,
       COUNT(*), SUM(Class),
       ROUND(SUM(Class) * 1.0 / COUNT(*), 4)
FROM extreme_flags
GROUP BY V17_group;