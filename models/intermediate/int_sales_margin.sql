WITH purchase_cost_table AS

(SELECT
*, 
quantity * purchase_price AS purchase_cost, 

FROM 
{{ref("stg_raw__sales")}}

LEFT JOIN
{{ref("stg_raw__product")}}
USING (products_id)
)

SELECT
*,
ROUND(revenue - (quantity * purchase_price),2) AS margin,
{{margin_percent(revenue,purchase_cost)}} AS margin_percent,

FROM purchase_cost_table

