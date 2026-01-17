# Credit Card Fraud Analysis (SQL)

This project demonstrates a practical, SQL-driven approach to exploratory fraud analysis using anonymized credit card transaction data.

The analysis focuses on identifying behavioral patterns, risk signals, and anomaly indicators commonly used in real-world fraud detection and risk analytics teams.

---

## Dataset

- Public anonymized credit card transaction dataset
- Total transactions: ~280,000+
- Fraud rate: ~0.17%

### Feature Description
- `Time`: Seconds elapsed since the first transaction in the dataset
- `Amount`: Transaction amount
- `V1` – `V28`: PCA-transformed features to protect sensitive information
- `Class`:
  - `1` → Fraudulent transaction
  - `0` → Legitimate transaction

> Due to anonymization, feature semantics are not interpretable.  
> Analysis emphasizes **transaction behavior patterns** rather than feature meaning.

---

## Project Objectives

- Understand overall fraud distribution and baseline metrics
- Identify high-risk transaction amount ranges
- Explore time-based fraud patterns
- Detect anomalous behavior using statistical thresholds
- Analyze feature extremes linked to higher fraud probability
- Build interpretable, rule-based risk scoring logic using SQL

---

## Key Analyses

### 1. Overall Fraud Overview
- Transaction volume and baseline fraud rate
- Establishes reference metrics for downstream analysis

### 2. Fraud by Transaction Amount
- Bucketed amount analysis
- Identifies amount ranges with elevated fraud rates
- Compares fraud frequency vs. fraud probability

### 3. Time-Based Fraud Patterns
- Hourly fraud rate analysis using relative time buckets
- Segmented time risk profiling (heuristic, exploratory)

### 4. Feature Anomaly Detection
- Statistical extreme-value analysis on selected PCA features (V10, V12, V14, V17)
- Compares fraud rates between normal and extreme observations
- Demonstrates anomaly-driven risk segmentation

### 5. Amount Outlier Analysis
- Standard deviation–based amount categorization
- Evaluates fraud behavior across amount outliers

### 6. Fraud Concentration & Velocity
- Identifies high-risk time periods contributing disproportionate fraud volume
- Transaction density vs. fraud rate analysis

### 7. Rule-Based Risk Scoring
- Combines multiple risk signals:
  - High transaction amount
  - Risky time segments
  - Extreme feature values
- Produces an interpretable risk score
- Evaluates fraud rate by score level

### 8. Rule Effectiveness Evaluation
- Measures coverage and precision of simple fraud flagging rules
- Demonstrates trade-offs between recall and false positives

## Project Structure
sql/
├─ 00_preview_data.sql
├─ 01_basic_overview.sql
├─ 02_fraud_by_amount_bucket.sql
├─ 03_time_based_fraud_patterns.sql
├─ 03b_time_segment_fraud_analysis.sql
├─ 04a_v17_anomaly_analysis.sql
├─ 04b_multifeature_anomaly_analysis.sql
├─ 05_amount_outlier_fraud.sql
├─ 06_fraud_vs_legit_amount_comparison.sql
├─ 07_fraud_concentration.sql
├─ 08_transaction_velocity_analysis.sql
├─ 09_risk_scoring_combined.sql
├─ 10_amount_feature_interaction.sql
├─ 11_rule_effectiveness.sql
└─ 12_executive_summary.sql

## Notes
- Due to feature anonymization, analysis focuses on behavior patterns rather than feature semantics
- Thresholds are heuristic and used for exploratory analysis
