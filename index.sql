-- Indexes in databases are used to make data retrieval faster.
-- Think of an index like the index section in a textbook — instead of reading every page, the database can quickly locate the needed data.
-- Without an index, the database performs a full table scan
-- Indexes improve:
-- SELECT
-- WHERE
-- JOIN
-- ORDER BY
-- GROUP BY
-- performance.
-- Indexes also have costs:
-- Extra storage space
-- Slower INSERT, UPDATE, DELETE
-- because indexes must also be updated.

-- So we usually create indexes on frequently searched columns.
-- Syntax to Create an Index
-- CREATE INDEX idx_customer_lastname
-- ON customer(last_name);

-- SHOW INDEX FROM customer;
-- DROP INDEX idx_customer_lastname
-- ON customer;

-- Clustered Index
-- A clustered index stores the actual table data in sorted order based on the indexed column.
-- Meaning: The rows themselves are physically arranged according to the index.
-- A table can have only ONE clustered index.
-- The PRIMARY KEY is automatically the clustered index.
-- Example:
-- CREATE TABLE student (
--     student_id INT PRIMARY KEY,
--     name VARCHAR(50),
--     marks INT
-- );
-- Here:
-- student_id = clustered index
-- Data is physically stored ordered by student_id.

-- Non-Clustered Index
-- A non-clustered index is separate from the actual table data.
-- It stores:indexed column values
-- pointers to actual rows
-- The table data itself is NOT reordered.
-- You can create many non-clustered indexes.
-- example:
-- CREATE INDEX idx_name
-- ON student(name);


÷