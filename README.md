# Credit Card Fraud Analysis (SQL)

This project explores fraud patterns in anonymized credit card transaction data using pure SQL.

## Dataset
- Source: Public anonymized credit card transactions dataset
- Features V1–V28 are PCA-transformed to protect sensitive information
- Target variable:
  - `Class = 1` → Fraud
  - `Class = 0` → Legitimate transaction

## Objectives
- Understand overall fraud distribution
- Identify high-risk transaction amount ranges
- Explore time-based fraud patterns
- Detect anomalous behavior using statistical thresholds
- Build simple rule-based risk scoring logic

## Tools
- SQLite
- SQL (CTEs, window functions, conditional logic)

## Project Structure
sql/
├─ 00_preview_data.sql
├─ 01_basic_overview.sql
├─ 02_fraud_by_amount_bucket.sql
├─ ...
└─ 12_executive_summary.sql

## Notes
- Due to feature anonymization, analysis focuses on behavior patterns rather than feature semantics
- Thresholds are heuristic and used for exploratory analysis
