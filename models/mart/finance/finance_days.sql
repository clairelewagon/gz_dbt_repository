

SELECT
date_date,
COUNT(orders_id) AS nb_transactions,
ROUND(SUM(revenue),0) AS revenue,
ROUND(SUM(revenue) / COUNT(orders_id),1) AS average_basket,
ROUND(SUM(margin),0) AS margin,
ROUND(SUM(operational_margin),0) AS operational_margin,

 FROM {{ref("int_orders_operational")}}

 GROUP BY 1
 ORDER BY 1 DESC