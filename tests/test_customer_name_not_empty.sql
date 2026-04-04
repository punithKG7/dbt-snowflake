-- Test to ensure customers have meaningful names
select *
from {{ ref('stg_customers') }}
where customer_name is null or trim(customer_name) = ''
