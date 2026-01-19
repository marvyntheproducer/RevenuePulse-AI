-- Purpose: Monthly revenue trends for forecasting and planning

CREATE OR REPLACE VIEW monthly_sales AS
WITH base AS (
    SELECT
        DATE_TRUNC('month', order_date) AS period_date,
        SUM(item_revenue) AS revenue,
        COUNT(DISTINCT order_id) AS order_count,
        SUM(item_revenue) / COUNT(DISTINCT order_id) AS aov
    FROM sales_fact
    WHERE order_status = 'delivered'
    GROUP BY DATE_TRUNC('month', order_date)
),
with_growth AS (
    SELECT
        period_date,
        revenue,
        order_count,
        aov,
        LAG(revenue) OVER (ORDER BY period_date) AS prev_period_revenue,
        CASE
            WHEN LAG(revenue) OVER (ORDER BY period_date) IS NULL THEN NULL
            ELSE (revenue - LAG(revenue) OVER (ORDER BY period_date))
                 / LAG(revenue) OVER (ORDER BY period_date)
        END AS revenue_growth_pct,
        AVG(revenue) OVER (
            ORDER BY period_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS rolling_avg_revenue
    FROM base
)
SELECT
    *,
    CASE
        WHEN revenue > rolling_avg_revenue THEN 'UP'
        WHEN revenue < rolling_avg_revenue THEN 'DOWN'
        ELSE 'FLAT'
    END AS trend_direction
FROM with_growth;
