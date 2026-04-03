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