with 
source as (
    select * from {{ source('raw', 'cc_parcel') }}
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
    date_purchase,
    date_shipping,
    date_delivery,
    date_cancelled,
    from clean_date_table
)

select * from renamed
