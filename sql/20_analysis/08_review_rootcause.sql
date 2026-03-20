-- =============================================
-- 08_review_rootcause.sql
-- 差评根因分析：延迟与差评率的关系
-- 口径：bad_review_rate = review_score <= 2 的订单占比
--       仅统计 order_status = 'delivered'
-- =============================================

USE olist;

-- 差评率 vs 延迟分组
SELECT
    CASE
        WHEN DATEDIFF(o.order_delivered_customer_date,
             o.order_estimated_delivery_date) <= 0  THEN '准时'
        WHEN DATEDIFF(o.order_delivered_customer_date,
             o.order_estimated_delivery_date) <= 3  THEN '延迟1-3天'
        WHEN DATEDIFF(o.order_delivered_customer_date,
             o.order_estimated_delivery_date) <= 7  THEN '延迟4-7天'
        ELSE '延迟8天以上'
    END                                              AS delay_group,
    COUNT(DISTINCT o.order_id)                       AS order_count,
    ROUND(SUM(CASE WHEN r.review_score <= 2
              THEN 1 ELSE 0 END)
          / COUNT(DISTINCT o.order_id) * 100, 2)    AS bad_review_rate
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delay_group
ORDER BY bad_review_rate DESC;
