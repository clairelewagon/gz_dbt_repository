with 
source as (
    select * from {{ source('raw_circle', 'cc_parcel') }}
),

clean_date_table as (
    SELECT
    parcel_id,
    parcel_tracking,
    transporter,
    priority,
    PARSE_DATE('%b %d, %Y',Date_purCHase) AS date_purchase,
    PARSE_DATE('%b %d, %Y',Date_sHIpping) AS date_shipping,
    PARSE_DATE('%b %d, %Y',DATE_delivery) AS date_delivery,
    PARSE_DATE('%b %d, %Y',datecancelled) AS date_cancelled,
    FROM source),

renamed as (
    select
    parcel_id,
    parcel_tracking,
    transporter,
    priority,
    --date clean sous le bon format
    date_purchase,
    date_shipping,
    date_delivery,
    date_cancelled,
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
    
    from clean_date_table
)

select * from renamed
