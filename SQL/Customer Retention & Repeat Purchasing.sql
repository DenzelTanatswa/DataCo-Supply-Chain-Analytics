WITH customer_orders AS (
    SELECT
        customer_id,

        COUNT(DISTINCT order_id) AS total_orders,

        SUM(order_item_total) AS total_spending

    FROM analytics.supply_chain_orders

    GROUP BY customer_id
)

SELECT
    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE total_orders > 1
    ) AS repeat_customers,

    COUNT(*) FILTER (
        WHERE total_orders = 1
    ) AS one_time_customers,

    ROUND(
        (
            100.0 * COUNT(*) FILTER (
                WHERE total_orders > 1
            )
            / NULLIF(COUNT(*), 0)
        )::numeric, 2
    ) AS repeat_customer_rate_pct,

    ROUND(
        AVG(total_spending)::numeric, 2
    ) AS avg_customer_spending

FROM customer_orders;