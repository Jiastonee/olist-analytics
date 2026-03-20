-- =============================================
-- 09_rfm_segmentation.sql
-- RFM 用户分层分析
-- 口径：仅统计 order_status = 'delivered'
--       基准日期：2018-10-01
-- =============================================

USE olist;

CREATE TABLE rfm_segments AS
WITH rfm AS (
    SELECT
        customer_unique_id,
        DATEDIFF('2018-10-01',
            MAX(o.order_purchase_timestamp))        AS recency,
        COUNT(DISTINCT o.order_id)                  AS frequency,
        SUM(op.payment_value)                       AS monetary
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_payments op ON o.order_id = op.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY customer_unique_id
),
rfm_scored AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY recency DESC)   AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC)  AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC)   AS m_score
    FROM rfm
)
SELECT *,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 THEN '高价值用户'
        WHEN r_score >= 4 AND f_score < 4  THEN '新用户'
        WHEN r_score < 2 AND f_score >= 4  THEN '流失高价值用户'
        WHEN r_score < 2                   THEN '流失用户'
        ELSE '一般用户'
    END AS segment
FROM rfm_scored;

-- 分层汇总
SELECT segment, COUNT(*) AS user_count
FROM rfm_segments
GROUP BY segment
ORDER BY user_count DESC;
