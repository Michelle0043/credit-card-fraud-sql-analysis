-- 00_preview_data.sql
SELECT *
FROM creditcard
LIMIT 5

-- Data understanding:
-- Time - Seconds elapsed since the first transaction in the dataset
-- V1 - V28 - PCA-transformed to protect sensitive info
-- Amount - transaction amount
-- Class - Binary response variable (1 = fraud, 0 = non-fraud)