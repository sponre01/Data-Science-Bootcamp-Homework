USE sakila;

-- 1a. Display the first and last names of all actors from the table actor
SELECT first_name, last_name 
FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
SELECT Concat(first_name, " ",last_name) 
AS Actor_Name
FROM actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name 
FROM actor 
WHERE first_name = "Joe";

-- 2b. Find all actors whose last name contain the letters GEN:
SELECT actor_id, first_name, last_name 
FROM actor 
WHERE last_name like '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT actor_id, first_name, last_name 
FROM actor 
WHERE last_name like '%LI%'
ORDER BY last_name, first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country 
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, 
-- so create a column in the table actor named description and use the data type BLOB 
-- (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
ALTER TABLE actor
ADD description BLOB(100);
SELECT *
FROM actor;

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE actor
DROP COLUMN description;
SELECT *
FROM actor;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name 'Last_Name', COUNT(0) 'Total_Actors'
FROM actor
GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, 
-- but only for names that are shared by at least two actors
SELECT last_name 'Last_Name', COUNT(0) 'Total_Actors'
FROM actor
GROUP BY last_name
HAVING COUNT(0) > 1;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE 
    actor
SET 
    first_name = "HARPO"
WHERE
    first_name = "GROUCHO" and last_name = "WILLIAMS";

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! 
-- In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
UPDATE 
    actor
SET 
    first_name = "GROUCH"
WHERE
    first_name = "HARPO";

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
CREATE TABLE address_recreate(
	`address_id` SMALLINT(5) UNSIGNED NOT NULL,
    `address` VARCHAR(50) NOT NULL,
	`address_2` VARCHAR(50) NULL DEFAULT NULL,
	`district` VARCHAR(20) NOT NULL,
	`city_id` SMALLINT(5) UNSIGNED NOT NULL,
	`postal_code` VARCHAR(10) NULL DEFAULT NULL,
	`phone` VARCHAR(20) NOT NULL,
	`location` GEOMETRY NOT NULL,
	`last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(`address_id`)
);

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON
staff.address_id=address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT staff.first_name, staff.last_name, SUM(payment.amount)
FROM staff
JOIN payment ON
staff.staff_id=payment.staff_id;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT film.title, COUNT(film_actor.actor_id) 'number_of_actors'
FROM film_actor
INNER JOIN film
ON film.film_id = film_actor.film_id
GROUP BY film.film_id
;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(inventory_id)
FROM inventory
WHERE film_id in
(
	SELECT film_id
	FROM film
	WHERE title = "Hunchback Impossible"
);

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name:
SELECT customer.customer_id, customer.last_name, customer.first_name, SUM(payment.amount) 'total_paid'
FROM customer
JOIN payment ON
payment.customer_id=customer.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with 
-- the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q 
-- whose language is English.
	SELECT title
	FROM film
	WHERE title like 'Q%' or title like 'K%' and language_id in
		(
		SELECT language_id
		FROM language
		WHERE name = "English"
);

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT Concat(first_name, " ",last_name) 'Actor_Name'
FROM actor
WHERE actor_id in
	(
	SELECT actor_id
	FROM film_actor
	WHERE film_id in
		(
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
));

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all 
-- Canadian customers. Use joins to retrieve this information.
SELECT customer.first_name, customer.last_name, customer.email
FROM country
JOIN city ON
country.country_id = city.country_id
JOIN address ON
city.city_id = address.city_id
JOIN customer ON
address.address_id = customer.address_id
WHERE country = "Canada"
;

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT title 
FROM film
WHERE film_id in
	(SELECT film_id 
	FROM film_category
	WHERE category_id in
		(SELECT category_id 
		FROM category
		WHERE name = "Family"
));

-- 7e. Display the most frequently rented movies in descending order.
SELECT film.title, COUNT(inventory.film_id) 'total rentals'
FROM rental
JOIN inventory ON
rental.inventory_id = inventory.inventory_id
JOIN film ON
film.film_id = inventory.film_id
GROUP BY film.film_id
ORDER BY COUNT(0) DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, SUM(payment.amount) 'total business ($)'
FROM payment
JOIN staff ON
payment.staff_id = staff.staff_id
JOIN store ON
staff.store_id = store.store_id
GROUP BY store.store_id;

-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON
store.address_id = address.address_id
JOIN city ON
city.city_id = address.city_id
JOIN country ON
country.country_id = city.country_id;

-- 7h. List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT category.name 'Genre', SUM(payment.amount) 'Gross Revenue'
FROM category
JOIN film_category ON
film_category.category_id= category.category_id
JOIN inventory ON
inventory.film_id = film_category.film_id
JOIN rental ON
inventory.inventory_id = rental.inventory_id
JOIN payment ON
rental.rental_id=payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;


-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
-- Use the solution from the problem above to create a view.
CREATE VIEW `top_five_genres` AS 
SELECT category.name 'Genre', SUM(payment.amount) 'Gross Revenue'
FROM category
JOIN film_category ON
film_category.category_id= category.category_id
JOIN inventory ON
inventory.film_id = film_category.film_id
JOIN rental ON
inventory.inventory_id = rental.inventory_id
JOIN payment ON
rental.rental_id=payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

-- 8b. How would you display the view that you created in 8a?
SELECT * 
FROM top_five_genres;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW top_five_genres;
