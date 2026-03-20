-- =============================================
-- 07_sales_trends.sql
-- 销售趋势分析：品类 + 地区 GMV 拆解
-- 口径：item_gmv = sum(price + freight_value)
--       仅统计 order_status = 'delivered'
-- =============================================

USE olist;

-- Top 10 品类 GMV
SELECT
    p.product_category_name                          AS category,
    ROUND(SUM(oi.price + oi.freight_value), 2)       AS item_gmv,
    COUNT(DISTINCT o.order_id)                       AS order_count,
    ROUND(SUM(oi.price + oi.freight_value)
          / COUNT(DISTINCT o.order_id), 2)           AS aov
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
AND p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY item_gmv DESC
LIMIT 10;

-- Top 10 州 GMV
SELECT
    c.customer_state                                 AS state,
    ROUND(SUM(oi.price + oi.freight_value), 2)       AS item_gmv,
    COUNT(DISTINCT o.order_id)                       AS order_count,
    ROUND(SUM(oi.price + oi.freight_value)
          / COUNT(DISTINCT o.order_id), 2)           AS aov
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY item_gmv DESC
LIMIT 10;
