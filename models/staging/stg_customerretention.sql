with sales as (
    select * from {{ ref('stg_sales') }}
),

customer_retention as (
    SELECT a.customer_name, a.day, DATE_TRUNC(a.day,MONTH) as month, b.day as next_order_date, date_diff(b.day,a.day,DAY) as day_diff,rank() over (partition by a.customer_name order by b.day asc) as rank 
    FROM sales a JOIN sales b ON a.customer_name=b.customer_name
    WHERE date_diff(b.day,a.day,DAY)<=30 AND date_diff(b.day,a.day,DAY) >=0
    GROUP BY b.day,a.customer_name,a.day
    ORDER BY a.day ASC
)

SELECT * FROM customer_retention