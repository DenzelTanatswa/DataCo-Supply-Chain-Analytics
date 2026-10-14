SELECT
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT customer_id) AS total_customers,

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
            / NULLIF(COUNT(DISTINCT order_id), 0)
        )::numeric, 2
    ) AS average_order_value

FROM analytics.supply_chain_orders;