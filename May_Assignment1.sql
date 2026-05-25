
-- 1. Get all customers whose first name starts with 'J' and who are active.
select first_name 
from customer
WHERE first_name like 'J%'
AND active=1;

select * from film;

-- 2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.
select title 
from film
where title like '%action%' or description like'%war%';
-- 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
select customer_id, first_name, last_name 
from customer
where last_name != 'smith' and first_name like '%a';

-- 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
select title, rental_rate, replacement_cost
from film
where rental_rate > 3.0 and replacement_cost is not null;

-- 5. Count how many customers exist in each store who have active status = 1.
select store_id, count(customer_id)
from customer
where active=1
group by store_id;

-- 6. Show distinct film ratings available in the film table.
select rating
from film
group by rating;
-- or
select distinct rating from film;

-- 7. Find the number of films for each rental duration where the average length is more than 100 minutes.
select rental_duration, count(film_id), avg(length)
from film
group by rental_duration
having avg(length) > 0;


-- 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
select payment_date,sum(amount),count(payment_id)
from payment
group by payment_date
having count(payment_id) >100;

-- 9. Find customers whose email address is null or ends with '.org'.
select email from customer
where  email like '%.org' or email is null;

-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
select title, rating, rental_rate
from film 
where rating = 'pg' or 'g'
order by rental_rate desc;

-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
select length, count(film_id)
from film
where title like 'T%'
group by length
having count(film_id) > 5;

-- 12. List all actors who have appeared in more than 10 films.
select a.actor_id,count(film_id), first_name,last_name
from film_actor as fa join actor as a on fa.actor_id= a.actor_id
group by a.actor_id,first_name,last_name
having count(film_id)>10;

-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
select film_id,rental_rate,length
from film
order by rental_rate desc, length desc limit 5;


-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
select c.customer_id, first_name, last_name,count(rental_id)
from customer as c join rental as r on c.customer_id = r.customer_id
group by c.customer_id,first_name,last_name
order by count(rental_id) desc;

-- 15. List the film titles that have never been rented.
select f.title
from film as f join inventory as i on f.film_id = i.film_id left join rental as r on i.inventory_id=r.inventory_id
where r.rental_id is null;
