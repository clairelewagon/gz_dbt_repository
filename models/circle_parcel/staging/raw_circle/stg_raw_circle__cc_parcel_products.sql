with 

source as (

    select * from {{ source('raw_circle', 'cc_parcel_products') }}

),

renamed as (

    select
        parcel_id,
        model_mame,
        quantity AS qty,

    from source

)

select * from renamed
