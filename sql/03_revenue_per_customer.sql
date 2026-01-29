-- ============================================
-- Revenue Analysis
-- Objective:
-- Analyze monthly revenue and customer value
-- ============================================
WITH cleaned_orders AS (
    SELECT
        invoice_no,
        customer_id,
        invoice_date,
		unit_price*quantity as revenue
    FROM orders
    WHERE
        customer_id IS NOT NULL
        AND quantity > 0
        AND unit_price > 0
),

monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS month,
		count(distinct customer_id) as active_customers,
		count(distinct invoice_no) as number_of_orders,
		sum(revenue) as total_revenue
    FROM cleaned_orders
    GROUP BY 1
)

SELECT
    month,
	active_customers,
	total_revenue as monthly_revenue,
	round(total_revenue/nullif(active_customers,0),2) as value_per_customer,
	round(total_revenue/nullif(number_of_orders,0),2) as value_per_order
	
from monthly_revenue
