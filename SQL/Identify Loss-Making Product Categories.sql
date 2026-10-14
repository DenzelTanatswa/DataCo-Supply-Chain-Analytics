SELECT
    category_name,

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
    ) AS profit_margin_pct

FROM analytics.supply_chain_orders

GROUP BY category_name

HAVING SUM(order_profit_per_order) < 0

ORDER BY total_profit ASC;