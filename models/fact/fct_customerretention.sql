/* customer retention */
/*SELECT customer_name, day a, DATE_TRUNC(day,MONTH) as month, COUNT(customer_name) as returning,
GROUP BY customer_name,day
HAVING COUNT(customer_name) >1*/

/*SELECT a.customer_name, a.day, DATE_TRUNC(a.day,MONTH) as month, b.day as next_order_date, date_diff(b.day,a.day,DAY) as day_diff 
FROM sales a JOIN sales b ON a.customer_name=b.customer_name
WHERE b.day<>a.day AND date_diff(b.day,a.day,DAY)<=30 AND date_diff(b.day,a.day,DAY) >=0
GROUP BY b.day,a.customer_name,a.day
ORDER BY a.day ASC*/

with customer_retention as (
    {{ ref('stg_customerretention')}}
)

SELECT * FROM customer_retention
WHERE rank <>1