
# Automated Revenue Intelligence System

## Overview
This project implements an **automated weekly revenue intelligence system** that detects revenue risks, growth patterns, and pricing signals using SQL analytics, Make.com automation, and AI-generated executive summaries.

The system is designed to replace manual reporting and provide decision-ready insights to business leaders.

---

## Key Capabilities
- Weekly revenue, orders, and AOV aggregation
- Moving average and trend comparison
- Deterministic risk and growth detection (non-AI)
- AI-generated executive summaries
- Automated reporting to Google Sheets
- Scalable, configuration-driven design

---

## Architecture
```
PostgreSQL / Supabase
        ↓
   SQL Analytics
        ↓
   Make.com Logic
        ↓
  Risk & Growth Classification
        ↓
     OpenAI (Explanation Only)
        ↓
   Google Sheets Reporting
```

---

## Tech Stack
- PostgreSQL / Supabase
- SQL (aggregations, moving averages, comparisons)
- Make.com (automation & orchestration)
- OpenAI (executive insight generation)
- Google Sheets (reporting layer)

---

## Data Quality Checks
Before processing, the system validates:
- Presence of recent data
- Non-zero row counts
- Valid date ranges

If checks fail, the workflow stops and flags the issue.

---

## Example Output
Each week produces:
- Revenue and order metrics
- Risk or growth signals
- Executive summary with recommended actions

---

## Use Cases
- Ecommerce revenue monitoring
- Subscription business performance tracking
- SME financial intelligence automation

---

## Author
Marvyn De Sousa

---

## Status
Production-ready concept – suitable for portfolio, demos, or client delivery.
