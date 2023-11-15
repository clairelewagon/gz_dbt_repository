SELECT 
    *,
    -- mois achat
    EXTRACT (MONTH FROM date_purchase) AS month_purchase,
    -- statut
    CASE
        WHEN date_cancelled IS NOT NULL THEN 'Cancelled'
        WHEN date_shipping IS NULL THEN 'In Progress'
        WHEN date_delivery IS NULL THEN 'In Transit'
        WHEN date_delivery IS NOT NULL THEN 'Delivered'
        ELSE NULL
    END AS status,
    -- calcul des délais
    DATE_DIFF(date_shipping,date_purchase, DAY) AS expedition_time,
    DATE_DIFF(date_delivery,date_shipping, DAY) AS transport_time,
    DATE_DIFF(date_delivery,date_purchase, DAY) AS delivery_time,
    -- 
    
    FROM {{ref("stg_raw_circle__cc_parcel")}}
