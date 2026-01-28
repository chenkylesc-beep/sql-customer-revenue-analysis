-- ============================================
-- Customer Activity Analysis
-- Objective:
-- Analyze monthly customer and order activity
-- ============================================
WITH cleaned_orders AS (
    SELECT
        invoice_no,
        customer_id,
        invoice_date
    FROM orders
    WHERE
        customer_id IS NOT NULL
        AND quantity > 0
        AND unit_price > 0
),

monthly_active_user AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS month,
		count(distinct customer_id) as active_customers,
		count(distinct invoice_no) as number_of_orders
    FROM cleaned_orders
    GROUP BY 1
)

SELECT
    month, 
	active_customers,
	number_of_orders,
	round(number_of_orders::numeric/nullif(active_customers,0),2) as order_number_per_user
from monthly_active_user
