{{ config(
    materialized='view',
    schema='staging',
    tags=['staging']
) }}

select
    customer_id,
    customer_name,
    email,
    phone,
    address,
    city,
    state,
    zip_code,
    country,
    created_at,
    updated_at
from {{ source('raw_data', 'customers') }}
where deleted_at is null
