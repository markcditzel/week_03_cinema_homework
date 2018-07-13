

--Drop tables order is tickets (child); customers; films
--NB that ; ends each line

DROP TABLE tickets; --IF EXISTS;
-- the IF EXISTS prevents trying to drop a table that does not exist
DROP TABLE customers; --IF EXISTS;
DROP TABLE films; --IF EXISTS;

--Create tables order is films; customers; tickets (child)

CREATE TABLE films (
  -- NB that each block opens with ( and ends with a ) followed by ;
  -- NB lines within a block end in a comma
  f_id SERIAL4 PRIMARY KEY,
  film_title VARCHAR(255),
  film_price INT4 -- last entry does not require a comma
);


CREATE TABLE customers (
  c_id SERIAL4 PRIMARY KEY,
  cust_name VARCHAR(255),
  cust_funds INT4
);


CREATE TABLE tickets (
  t_id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(c_id) ON DELETE CASCADE,
  -- notation for SQL means you state the table_name(column_name)
  -- these lines esatblish the links between PK and FK keys
  -- customer_id is the FK for customer(id)
  film_id INT4 REFERENCES films(f_id) ON DELETE CASCADE
  -- film_id is the FK for the film(id)
);
