-- 1. Get all customers whose first name starts with 'J' and who are active.

select first_name, active
from sakila.customer
where first_name like 'j%' and active =1;

-- 2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.
select title, description
from sakila.film
where title like '%ACTION%' or description like '%WAR%';

-- 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
select first_name, last_name
from sakila.customer
where last_name != 'SMITH' and first_name like '%a';

-- 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
select title, rental_rate, replacement_cost
from sakila.film
where rental_rate > 3.0 and replacement_cost is not null;

-- 5. Count how many customers exist in each store who have active status = 1.
select store_id, count(customer_id) as active_customers
from sakila.customer
where active=1
group by store_id;

-- 6. Show distinct film ratings available in the film table.
select distinct rating from sakila.film;

-- 7. Find the number of films for each rental duration where the average length is more than 100 minutes.
select rental_duration, count(title) as title_count,avg(length) as average_length
from sakila.film
group by rental_duration
having avg(length)>100;

-- 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
select DATE(payment_date), sum(amount), count(payment_date)
from sakila.payment
group by DATE(payment_date)
having count(payment_date)>100;

-- 9. Find customers whose email address is null or ends with '.org'.
select customer_id, email
from sakila.customer
where email is null or email like '%org';

-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
select rating, title, rental_rate
from sakila.film
-- where rating ='PG' or rating ='G'
WHERE rating IN ('PG','G')
order by rental_rate DESC;

-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
select length, count(title) as title_count
from sakila.film
where title like 'T%'
group by length
having count(title) > 5
order by length desc; -- this for ordering the result by length in descending order, you can remove it if you don't want to order the result.

-- 12. List all actors who have appeared in more than 10 films.
select film_actor.actor_id, actor.first_name, actor.last_name, count(film_actor.film_id) as film_count
from sakila.actor JOIN sakila.film_actor ON actor.actor_id = film_actor.actor_id
group by  film_actor.actor_id,actor.first_name, actor.last_name
having  count(film_actor.film_id)>10;

-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
select title, rental_rate, length
from sakila.film
order by rental_rate desc, length desc
limit 5;

-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
select c.first_name, c.last_name, r.customer_id, count(r.rental_id) as number_of_rentals
from sakila.customer c left join sakila.rental r on c.customer_id=r.customer_id
group by c.customer_id,c.first_name, c.last_name
order by count(r.rental_id) desc;

-- 15. List the film titles that have never been rented.
select f.title, i.inventory_id, r.rental_id
from sakila.film f left join sakila.inventory i on f.film_id=i.film_id  left join sakila.rental r  on r.inventory_id = i.inventory_id
where r.rental_id is null;
