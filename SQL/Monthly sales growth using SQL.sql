WITH monthly_sales AS (
    SELECT
        DATE_TRUNC(
            'month',
            order_date_dateorders
        )::date AS sales_month,

        SUM(order_item_total) AS revenue

    FROM analytics.supply_chain_orders

    GROUP BY 1
),

sales_growth AS (
    SELECT
        sales_month,
        revenue,

        LAG(revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue

    FROM monthly_sales
)

SELECT
    sales_month,

    ROUND(revenue::numeric, 2) AS revenue,

    ROUND(
        previous_month_revenue::numeric, 2
    ) AS previous_month_revenue,

    ROUND(
        (
            100.0 * (revenue - previous_month_revenue)
            / NULLIF(previous_month_revenue, 0)
        )::numeric, 2
    ) AS monthly_growth_pct

FROM sales_growth

ORDER BY sales_month;