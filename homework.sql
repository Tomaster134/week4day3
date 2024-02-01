-- Week 5 - Wednesday
-- Questions
-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';
--A) Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, and Ian Still are all customers that live in Texas
---------------------------------------------------------------------------------------


-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99;
--A) The above query returns the requested data.
---------------------------------------------------------------------------------------

-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

--Individual payments over $175
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id, amount
    FROM payment
    WHERE amount > 175
);

--Lifetime paid over $175
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY payment.customer_id
    HAVING SUM(amount) > 175
);

--A) The way the question is worded indicates individual payments over $175. Which would be no customers. If you're looking for customers who've paid more than $175 over their account lifetime, then those customers are Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Peter Menard, Tommy Collazo, and Karl Seal.
---------------------------------------------------------------------------------------


-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name
FROM customer
JOIN address
on customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';
--A) Kevin Schuler is the only customer that lives in Nepal.
---------------------------------------------------------------------------------------


-- 5. Which staff member had the most transactions?
SELECT COUNT(payment_id), staff_id
FROM payment
GROUP BY staff_id
ORDER BY COUNT(payment_id);
--A) The staff member with staff_id '2' had the highest number of monetary transactions, with 7304.
---------------------------------------------------------------------------------------


-- 6. How many movies of each rating are there?
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC;
--A) PG-13 = 223, NC-17 = 210, R = 195, PG = 194, G = 178
---------------------------------------------------------------------------------------


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(amount) = 1
);
--A) The above code will return a list of customers who have only ever made one payment and that one payment is above $6.99
---------------------------------------------------------------------------------------


-- 8. How many free rentals did our stores give away?
SELECT COUNT(*)
FROM rental
RIGHT JOIN payment
ON rental.rental_id = payment.rental_id
WHERE amount = 0 OR amount = NULL
--A) There were 24 rentals that were given away for free.