with 
source as (
    select * from {{ source('raw_circle', 'cc_parcel') }}
),

renamed as (
    SELECT
    parcel_id,
    parcel_tracking,
    transporter,
    priority,
    PARSE_DATE('%b %d, %Y',Date_purCHase) AS date_purchase,
    PARSE_DATE('%b %d, %Y',Date_sHIpping) AS date_shipping,
    PARSE_DATE('%b %d, %Y',DATE_delivery) AS date_delivery,
    PARSE_DATE('%b %d, %Y',datecancelled) AS date_cancelled
    FROM source)


select * from renamed
