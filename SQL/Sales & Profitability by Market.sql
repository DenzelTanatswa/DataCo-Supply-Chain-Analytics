SELECT
    market,

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
        )::numeric,
        2
    ) AS profit_margin_pct,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (
                WHERE delivery_performance = 'Late'
            )
            / NULLIF(
                COUNT(*) FILTER (
                    WHERE delivery_performance <> 'Canceled'
                ), 0
            )
        )::numeric,
        2
    ) AS late_delivery_rate_pct

FROM analytics.supply_chain_orders

GROUP BY market

ORDER BY total_sales DESC;