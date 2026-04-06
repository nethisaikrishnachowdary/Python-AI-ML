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