{{ config(
    materialized='view',
    schema='staging',
    tags=['staging']
) }}

select
    order_id,
    customer_id,
    order_date,
    order_amount,
    tax_amount,
    total_amount,
    order_status,
    created_at,
    updated_at
from {{ source('raw_data', 'orders') }}
where deleted_at is null
