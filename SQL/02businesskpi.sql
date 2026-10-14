SELECT
    COUNT(*) FILTER (
        WHERE delivery_performance <> 'Canceled'
    ) AS eligible_order_items,

    COUNT(*) FILTER (
        WHERE delivery_performance = 'Late'
    ) AS late_order_items,

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
    ) AS late_delivery_rate_pct,

    ROUND(
        AVG(days_for_shipping_real)::numeric,
        2
    ) AS avg_shipping_days

FROM analytics.supply_chain_orders

WHERE delivery_performance <> 'Canceled';