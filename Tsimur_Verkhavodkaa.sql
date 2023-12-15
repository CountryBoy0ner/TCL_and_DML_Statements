--1
INSERT INTO film (title, rental_rate, rental_duration, language_id)
VALUES ('The Terminator', 4.99, 2, 1);


--2
INSERT INTO actor (actor_id, first_name, last_name)
VALUES
  (1001, 'Arnold', 'Schwarzenegger'),
  (1002, 'Michael', 'Biehn'),
  (1003, 'Linda', 'Hamilton');

INSERT INTO film_actor (actor_id, film_id)
VALUES
  (1001, 1002), 
  (1002, 1002), 
  (1003, 1002); 
  
--3  
select * from inventory

INSERT INTO film (film_id, title, rental_rate, rental_duration, language_id)
VALUES
  (1003, 'The Terminator two', 4.99, 2, 1),
  (1004, 'The Terminator three', 4.99, 2, 1),
  (1005, 'The Terminator four', 4.99, 2, 1);
INSERT INTO inventory (film_id, store_id)
VALUES
  (1003, 1),
  (1004, 1),
  (1005, 1);

--Update
--1
UPDATE film
SET
  rental_duration = 3,
  rental_rate = 9.99
WHERE
  film_id IN (1003, 1004, 1005);
--2
WITH CustomerToUpdate AS (
  SELECT
    c.customer_id
  FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON c.customer_id = p.customer_id
  GROUP BY
    c.customer_id
  HAVING
    COUNT(DISTINCT r.rental_id) >= 10
    AND COUNT(DISTINCT p.payment_id) >= 10
  LIMIT 1
)

UPDATE customer
SET
  first_name = 'Tsimur',
  last_name = 'Verkhavodka',
  email = 'email@example.com',
  address_id = (SELECT address_id FROM address ORDER BY random() LIMIT 1)
WHERE
  customer_id IN (SELECT customer_id FROM CustomerToUpdate);
--3
WITH CustomerToUpdate AS (
  SELECT
    c.customer_id
  FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON c.customer_id = p.customer_id
  GROUP BY
    c.customer_id
  HAVING
    COUNT(DISTINCT r.rental_id) >= 10
    AND COUNT(DISTINCT p.payment_id) >= 10
  LIMIT 1
)

UPDATE customer
SET
  create_date = current_date
WHERE
  customer_id IN (SELECT customer_id FROM CustomerToUpdate);
  
--Delete
--1
DELETE FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1002);


DELETE FROM inventory
WHERE film_id = 1002;

--2
DELETE FROM payment WHERE customer_id = 1;
DELETE FROM rental WHERE customer_id = 1;

