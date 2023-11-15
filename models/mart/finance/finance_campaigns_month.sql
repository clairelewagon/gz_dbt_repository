SELECT
DATE_TRUNC(date_date, MONTH) AS month_date,
SUM(revenue) AS revenue,
SUM(margin) AS margin,
SUM(operational_margin) AS operational_margin,
ROUND(AVG(average_basket),1) AS average_basket,
SUM(ads_cost) AS ads_cost,
SUM(ads_margin) AS ads_margin,
FROM {{ref("finance_campaigns_day")}}
GROUP BY month_date