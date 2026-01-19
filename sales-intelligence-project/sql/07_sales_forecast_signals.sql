-- Purpose: Weekly revenue outlook and risk signals for automation

CREATE OR REPLACE VIEW sales_forecast_signals AS
WITH base AS (
    SELECT
        period_date,
        revenue,
        revenue_growth_pct,
        rolling_avg_revenue
    FROM weekly_sales
),
signals AS (
    SELECT
        period_date,
        revenue,
        rolling_avg_revenue,
        revenue_growth_pct,

        -- Momentum: change in growth rate
        revenue_growth_pct
        - LAG(revenue_growth_pct) OVER (ORDER BY period_date)
        AS growth_momentum,

        -- Simple 30-day outlook (4-week projection)
        rolling_avg_revenue * 4 AS projected_30d_revenue
    FROM base
)
SELECT
    period_date,
    revenue,
    rolling_avg_revenue,
    revenue_growth_pct,
    growth_momentum,
    projected_30d_revenue,

    -- Risk classification
    CASE
        WHEN revenue_growth_pct < -0.10 THEN 'HIGH_RISK'
        WHEN revenue_growth_pct BETWEEN -0.10 AND -0.03 THEN 'MEDIUM_RISK'
        WHEN revenue_growth_pct > 0 THEN 'LOW_RISK'
        ELSE 'NEUTRAL'
    END AS risk_level,

    -- Alert flag (used by automations)
    CASE
        WHEN revenue_growth_pct < -0.10
          OR growth_momentum < -0.05
        THEN TRUE
        ELSE FALSE
    END AS alert_required

FROM signals;
