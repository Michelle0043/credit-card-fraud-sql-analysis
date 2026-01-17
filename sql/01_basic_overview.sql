-- 01_basic_overview.sql
-- Purpose:
-- Get a high-level overview of transaction volume, fraud rate,
-- and basic amount statistics.

SELECT
	COUNT(*) AS total_transactions,
	SUM(Class) AS fraud_transactions,
	ROUND(SUM(Class)*1.0 / COUNT(*), 5) AS fraud_rate
FROM creditcard;