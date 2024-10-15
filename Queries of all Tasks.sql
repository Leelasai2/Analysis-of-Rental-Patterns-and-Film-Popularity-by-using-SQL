use mavenmovies;


select  * from rental ;

/* Task 1 
--- Analyze the monthly rental trends over the available data period --- */
SELECT
    EXTRACT(YEAR FROM rental_date) AS year,
    EXTRACT(MONTH FROM rental_date) AS month,
    AVG(amount) AS avg_rental_price,
    min(amount) as min_rental_amount,
    max(amount) as max_rental_amount,
    COUNT(*) as rental_count
    from rental r 
    join payment p
    on r.rental_id = p.rental_id
GROUP BY
    year, month
ORDER BY
    year, month;


/* Task 2 
--- Determine the peak rental hours in a day based on rental transactions --- */

SELECT
r.rental_id,
extract(HOUR FROM rental_date) as peak_rental_hour,
sum(p.amount) as Rental_transaction,
count(*) as Rental_count 
from rental r 
join payment p 
on r.rental_id = p.rental_id 
group by
peak_rental_hour
order by 
rental_transaction desc
limit 1 ;
 
 
 
 /* Task 3 
---Identify the top 10 most rented films --- */

SELECT	f.film_id as film_id, f.title as film_title,
count(*) as Rental_count
from film f 
join inventory i 
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id 
group by f.title
order by Rental_count desc
limit 10 ;



 /* Task 4
---Determine which film categories have the highest number of rentals --- */

select c.name as film_category, 
Sum(p.amount)as total_sales
from payment p 
join rental r 
on p.rental_id = r.rental_id
join inventory i 
on r.inventory_id = i.inventory_id
join film_category fc 
on i.film_id = fc.film_id 
join category c 
on fc.category_id = c.category_id
group by c.name
order by total_sales desc
limit 1;

/* OR */

select * from sales_by_film_category 
limit 1;


 /* Task 5
 ---Identify which store generates the highest rental revenue --- */
 
 select * from sales_by_store 
 limit 1;
 
  /* Task 6
 ---Determine the distribution of rentals by staff members to assess performance--- */

 SELECT
    s.staff_id,
    concat(first_name,' ',last_name) as'name',
    COUNT(r.rental_id) AS rental_count,
    a.address, c.city,co.country
FROM
    rental r
JOIN
    staff s ON r.staff_id = s.staff_id
JOIN  address a
on s.address_id = a.address_id 
JOIN  city c
on a.city_id = c.city_id
JOIN country co 
on c.country_id = co.country_id     
GROUP BY
    s.staff_id, name
ORDER BY
    rental_count DESC;
