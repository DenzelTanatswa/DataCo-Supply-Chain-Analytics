SELECT
    customer_segment,

    COUNT(DISTINCT customer_id) AS total_customers,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(order_item_total)::numeric, 2
    ) AS total_sales,

    ROUND(
        SUM(order_profit_per_order)::numeric, 2
    ) AS total_profit,

    ROUND(
        (
            100.0 * SUM(order_profit_per_order)
            / NULLIF(SUM(order_item_total), 0)
        )::numeric, 2
    ) AS profit_margin_pct,

    ROUND(
        (
            SUM(order_item_total)
            / NULLIF(COUNT(DISTINCT customer_id), 0)
        )::numeric, 2
    ) AS revenue_per_customer

FROM analytics.supply_chain_orders

GROUP BY customer_segment

ORDER BY total_sales DESC;