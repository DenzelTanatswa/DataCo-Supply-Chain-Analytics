SELECT
    market,

    COUNT(*) AS total_order_items,

    COUNT(*) FILTER (
        WHERE delivery_delay_days > 0
    ) AS late_deliveries,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (
                WHERE delivery_delay_days > 0
            )
            / NULLIF(COUNT(*), 0)
        )::numeric, 2
    ) AS late_delivery_rate_pct,

    ROUND(
        AVG(days_for_shipping_real)::numeric, 2
    ) AS avg_shipping_days,

    ROUND(
        AVG(delivery_delay_days)::numeric, 2
    ) AS avg_delay_days

FROM analytics.supply_chain_orders

WHERE delivery_performance <> 'Canceled'

GROUP BY market

ORDER BY late_delivery_rate_pct DESC;