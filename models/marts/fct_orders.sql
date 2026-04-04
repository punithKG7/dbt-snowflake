{{ config(
    materialized='table',
    schema='marts',
    tags=['marts', 'core']
) }}

select
    o.order_id,
    o.customer_id,
    c.customer_name,
    o.order_date,
    o.order_amount,
    o.tax_amount,
    o.total_amount,
    o.order_status,
    c.city,
    c.state,
    c.country
from {{ ref('stg_orders') }} o
left join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id
