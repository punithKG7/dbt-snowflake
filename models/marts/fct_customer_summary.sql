{{ config(
    materialized='table',
    schema='marts',
    tags=['marts', 'core']
) }}

select
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    c.city,
    c.state,
    count(distinct o.order_id) as total_orders,
    sum(o.total_amount) as lifetime_value,
    min(o.order_date) as first_order_date,
    max(o.order_date) as last_order_date,
    avg(o.total_amount) as avg_order_value
from {{ ref('stg_customers') }} c
left join {{ ref('stg_orders') }} o
    on c.customer_id = o.customer_id
    and o.order_status = 'completed'
group by
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    c.city,
    c.state
