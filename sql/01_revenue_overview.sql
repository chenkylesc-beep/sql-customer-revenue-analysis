-- Revenue overview analysis
-- Monthly revenue trend
WITH cleaned_orders AS (
    SELECT
        invoice_no,
        customer_id,
        invoice_date,
        quantity * unit_price AS revenue
    FROM orders
    WHERE
        customer_id IS NOT NULL
        AND quantity > 0 --
        AND unit_price > 0
),

monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS month,
        SUM(revenue) AS total_revenue,
        COUNT(DISTINCT invoice_no) AS number_of_orders,
        COUNT(DISTINCT customer_id) AS number_of_customers
    FROM cleaned_orders
    GROUP BY 1
)

SELECT
    month,
    total_revenue,
    number_of_orders,
    number_of_customers
FROM monthly_revenue
ORDER BY month;
