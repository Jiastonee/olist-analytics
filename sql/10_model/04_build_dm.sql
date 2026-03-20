-- =============================================
-- 04_build_dm.sql
-- 建立用户主题表 dim_customers
-- 粒度：一行 = 一个真实用户
-- =============================================

USE olist;

CREATE TABLE dim_customers AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id)                    AS order_count,
    SUM(op.payment_value)                         AS total_spent,
    MIN(o.order_purchase_timestamp)               AS first_order_time,
    MAX(o.order_purchase_timestamp)               AS last_order_time,
    DATEDIFF(
        MAX(o.order_purchase_timestamp),
        MIN(o.order_purchase_timestamp)
    )                                             AS customer_lifespan_days
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_unique_id;

-- 验证
SELECT COUNT(*) FROM dim_customers;
