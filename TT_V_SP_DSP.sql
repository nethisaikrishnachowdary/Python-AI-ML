-- Temporary tables are tables that exist only for the current database session (connection). They are useful when you need to store intermediate results temporarily without creating a permanent table in the database.
-- Key Features of Temporary Tables
-- Temporary storage → Data exists only during the session.
-- Automatically removed → When the session ends, the table is deleted.
-- Session-specific → Other users cannot access your temporary table.
-- Improves complex query readability → Break large queries into smaller steps.
-- Useful for reports, calculations, filtering large datasets, etc.

-- Customers who made more than 5 payments (Sakila)
CREATE TEMPORARY TABLE FREQUENT_CUSTOMERS AS
SELECT CUSTOMER_ID, COUNT(PAYMENT_ID)
FROM payment
GROUP BY CUSTOMER_ID
HAVING COUNT(PAYMENT_ID) > 5;

SELECT * FROM SAKILA.FREQUENT_CUSTOMERS;

-- Views in SQL are virtual tables created from a SELECT query. Unlike temporary tables, views do not store data physically (except materialized views in some databases). A view simply stores the SQL query, and whenever you query the view, SQL runs that stored query.

-- Key Features of Views
-- Virtual table → Created from one or more tables.
-- No duplicate data storage → Uses existing table data.
-- Improves security → Show only required columns.
-- Simplifies complex queries → Save long joins and calculations.
-- Reusable → Write once, use many times.

-- customer total spending 
create view total_spending as
select customer_id, sum(amount) as total
from payment
group by customer_id
order by sum(amount) desc;

select * from total_spending;

-- update in view
-- update total_spending
-- set total = 300
-- where customer_id=526;

-- syntax
-- GRANT privileges
-- ON object_name
-- TO 'username'@'host';

-- REVOKE privileges
-- ON object_name
-- FROM 'username'@'host';



-- Stored Procedures are precompiled SQL code blocks stored in the database that you can execute whenever needed. Instead of writing the same SQL queries repeatedly, you store them once and call them using their name.

-- They are useful for:

-- Reusing SQL logic
-- Reducing repeated code
-- Improving performance (precompiled)
-- Security (users can execute procedures without direct table access)
-- Handling complex business logic
-- Syntax
-- DELIMITER //

-- CREATE PROCEDURE procedure_name()
-- BEGIN
--     SQL statements;
-- END //

-- DELIMITER ;

-- CALL procedure_name();


-- total payment done by customer
DELIMITER //
create procedure total_amount(in id int)
BEGIN 
select customer_id,sum(amount) as total_amount
from payment
where customer_id = id
group by customer_id;
END //
DELIMITER ;

CALL total_amount(526);

-- Dynamic Stored Procedure means a stored procedure that builds and executes SQL statements dynamically at runtime. Instead of writing fixed SQL queries, you create SQL as a string and execute it.

-- In MySQL (Sakila database uses MySQL), we use:

-- PREPARE → Prepare SQL statement
-- EXECUTE → Run SQL statement
-- DEALLOCATE PREPARE → Remove prepared statement
-- Syntax
-- DELIMITER //

-- CREATE PROCEDURE procedure_name(IN parameter datatype)
-- BEGIN
--     SET @sql_query = CONCAT('SQL statement');

--     PREPARE stmt FROM @sql_query;

--     EXECUTE stmt;

--     DEALLOCATE PREPARE stmt;
-- END //

-- DELIMITER ;


