show tables from sakila;
select * from sakila.film_actor;
select * from sakila.actor;
select * from sakila.film;
select * from sakila.customer;
select first_name,active,
case active
	when 1 then "ACTIVE"
    when 0 then "INACTIVE"
end  from sakila.customer; 

select title, length,
case 
	when length < 60 then "SHORT"
    when length between 60 and 120 then "MEDIUM"
    when length >120 then "large"
end AS size from sakila.film;


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
where email is null or email like '%.org';

-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
select rating, title, rental_rate
from sakila.film
-- where rating ='PG' or rating ='G'
WHERE rating IN ('PG','G')
order by rental_rate DESC;

-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
select length, count(title)
from sakila.film
where title like 'T%'
group by length
having count(title) > 5
order by length desc;

select * from sakila.film where title like 'T%';

-- 12. List all actors who have appeared in more than 10 films.
select film_actor.actor_id, actor.first_name, actor.last_name, count(film_actor.film_id) as film_count
from sakila.actor JOIN sakila.film_actor ON actor.actor_id = film_actor.actor_id
group by  film_actor.actor_id,actor.first_name, actor.last_name
having  count(film_actor.film_id)>10;

select * from sakila.film;
select * from sakila.actor;
select * from sakila.film_actor;

-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
select title, rental_rate, length
from sakila.film
order by rental_rate desc, length desc
limit 5;

-- select title, rental_rate/length 
-- from sakila.film
-- order by rental_rate/length desc
-- limit 5;



-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
select c.first_name, c.last_name, r.customer_id, count(r.rental_id) as number_of_rentals
from sakila.customer c left join sakila.rental r on c.customer_id=r.customer_id
group by c.customer_id,c.first_name, c.last_name
order by count(r.rental_id) desc;

select * from sakila.customer;
select * from sakila.rental;
select * from sakila.film;
select * from sakila.category;
select * from sakila.inventory;

-- 15. List the film titles that have never been rented.
select f.title, i.inventory_id, r.rental_id
from sakila.film f left join sakila.inventory i on f.film_id=i.film_id  left join sakila.rental r  on r.inventory_id = i.inventory_id
where r.rental_id is null;


select * from sakila.customer;
select * from sakila.rental;



-- List all customers who have made at least one payment.

select c.first_name, c.last_name, p.payment_id
from sakila.customer c join sakila.payment p on c.customer_id = p.customer_id
where p.customer_id is not null;


-- List all customers and how many payments they made (including 0).
select c.first_name, c.last_name, count(p.payment_id)
from sakila.customer c left join sakila.payment p on c.customer_id = p.customer_id
group by c.first_name, c.last_name
order by count(p.payment_id) asc;

-- List customers who have never made a payment.
select c.first_name, c.last_name
from sakila.customer c left join sakila.payment p on c.customer_id = p.customer_id
where p.payment_id is null;

select * from sakila.customer;
select * from sakila.rental;
select * from sakila.film;
select * from sakila.film_category;
select * from sakila.category;
select * from sakila.inventory;
select * from sakila.staff;
select * from sakila.store;
select * from sakila.sales_by_store;



-- 1. List all customers along with the films they have rented.
select c.customer_id, c.first_name, c.last_name, f.title
from sakila.rental r join sakila.customer c on r.customer_id = c.customer_id join sakila.inventory i on r.inventory_id = i.inventory_id join sakila.film f on i.film_id = f.film_id
;

-- 2. List all customers and show their rental count, including those who haven't rented any films.
select c.customer_id, c.first_name,c.last_name,count(r.rental_id) as rental_count
from sakila.customer c left join sakila.rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name,c.last_name
order by count(r.rental_id) asc;

-- 3. Show all films along with their category. Include films that don't have a category assigned.
select f.film_id, f.title, c.name as category
from  sakila.film f left join sakila.film_category fc on f.film_id = fc.film_id left join sakila.category c on fc.category_id = c.category_id ;


-- 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
select c.email as customer_mail, s.email as staff_mail
from sakila.customer c left join sakila.staff s on c.email=s.email
union
select c.email as customer_mail, s.email as staff_mail
from sakila.customer c right join sakila.staff s on c.email=s.email;



-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR".
select a.first_name, a.last_name
from sakila.film_actor fa  join sakila.film f on f.film_id = fa.film_id join sakila.actor a on fa.actor_id=a.actor_id
where f.title='ACADEMY DINOSAUR';

-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.
select st.store_id, count(sf.staff_id) 
from sakila.store st left join sakila.staff  sf on st.store_id = sf.store_id
group by st.store_id;


-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.
select c.first_name, c.last_name, count(r.rental_id) as rental_count
from sakila.customer c join sakila.rental r on c.customer_id = r.customer_id
group by c.first_name, c.last_name
having count(r.rental_id) >5
order by count(r.rental_id) desc;





