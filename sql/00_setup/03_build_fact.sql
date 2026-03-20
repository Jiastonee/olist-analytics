-- =============================================
-- 03_build_fact.sql
-- 建立事实表 fact_orders
-- 粒度：一行 = 一笔支付记录
-- =============================================

USE olist;

CREATE TABLE fact_orders AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    op.payment_type,
    op.payment_value
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN order_payments op ON o.order_id = op.order_id;

-- 验证
SELECT COUNT(*) FROM fact_orders;
