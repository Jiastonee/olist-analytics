-- =============================================
-- 05_cohort_retention.sql
-- 用户留存分析（Cohort Retention）
-- 口径：仅统计 order_status = 'delivered' 的订单
-- =============================================

USE olist;

-- 第一步：建立 cohort 基础表
CREATE TABLE cohort_base AS
SELECT
    c.customer_unique_id,
    first_order.cohort_month,
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN (
    SELECT c2.customer_unique_id,
           DATE_FORMAT(MIN(o2.order_purchase_timestamp), '%Y-%m') AS cohort_month
    FROM customers c2
    JOIN orders o2 ON c2.customer_id = o2.customer_id
    WHERE o2.order_status = 'delivered'
    GROUP BY c2.customer_unique_id
) first_order ON c.customer_unique_id = first_order.customer_unique_id
WHERE o.order_status = 'delivered';

-- 第二步：计算留存率
SELECT
    a.cohort_month,
    a.order_month,
    COUNT(DISTINCT a.customer_unique_id)            AS user_count,
    b.cohort_size,
    ROUND(COUNT(DISTINCT a.customer_unique_id) 
          / b.cohort_size * 100, 2)                 AS retention_rate
FROM cohort_base a
JOIN (
    SELECT cohort_month,
           COUNT(DISTINCT customer_unique_id) AS cohort_size
    FROM cohort_base
    WHERE cohort_month = order_month
    GROUP BY cohort_month
) b ON a.cohort_month = b.cohort_month
GROUP BY a.cohort_month, a.order_month, b.cohort_size
ORDER BY a.cohort_month, a.order_month;
