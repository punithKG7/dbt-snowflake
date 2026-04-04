-- Test to ensure order amounts are positive
select *
from {{ ref('stg_orders') }}
where order_amount < 0 or total_amount < 0
