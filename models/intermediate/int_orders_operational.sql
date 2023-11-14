SELECT

orders_id,
date_date,
revenue,
quantity,
purchase_cost,
margin,
ROUND((margin + shipping_fee - log_cost - ship_cost),2) AS operational_margin,

 FROM {{ref("int_orders_margin")}}
LEFT JOIN {{ref("stg_raw__ship")}}
USING(orders_id)
ORDER BY orders_id DESC, date_date DESC