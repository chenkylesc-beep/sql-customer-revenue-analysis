-- ============================================
-- Customer Segmentation Analysis
-- Objective:
-- Repeat vs One-time Customers
-- Customer Lifetime Revenue
-- ============================================
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS total_orders,
		SUM(quantity * unit_price) AS lifetime_revenue
    FROM orders
    WHERE
        customer_id IS NOT NULL
        AND quantity > 0
        AND unit_price > 0
    GROUP BY customer_id
)

select 
    	case 
      		when total_orders = 1 then 'One-time customer'
      		else 'Repeat'
      		end as customer_type,
    	COUNT(customer_id) AS number_of_customers,
    	SUM(lifetime_revenue) AS total_revenue,
    	ROUND(
    	SUM(lifetime_revenue)::NUMERIC / NULLIF(COUNT(customer_id), 0),
    	2
      ) AS avg_revenue_per_customer
FROM customer_orders
GROUP BY 1

	
