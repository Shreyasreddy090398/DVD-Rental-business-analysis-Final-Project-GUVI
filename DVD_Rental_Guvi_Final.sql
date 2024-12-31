CREATE TABLE final_table AS
SELECT DISTINCT ON (p.payment_id) 
    
    p.payment_id,
    p.amount AS payment_amount,
    p.payment_date,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_full_name,
    a.address_id,
    a.district,
    ci.city,
    co.country,
    st.store_id,
    st.manager_staff_id,
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_full_name,
    r.rental_id,
    r.rental_date,
    r.return_date,
    ROUND(EXTRACT(EPOCH FROM (r.return_date - r.rental_date)) / 86400) AS rental_duration, 
    f.film_id,
    f.title AS film_title,
    f.release_year,
    f.rental_rate,
    f.length AS film_length,
    l.name AS language_name,
    cat.name AS category_name,    
    ac.actor_id,
    CONCAT(ac.first_name, ' ', ac.last_name) AS actor_full_name

FROM payment p
-- Joining rentals and customers
JOIN rental r ON p.rental_id = r.rental_id
JOIN customer c ON r.customer_id = c.customer_id

-- Joining customer addresses and location details
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id

-- Joining store and staff details
JOIN store st ON c.store_id = st.store_id
JOIN staff s ON r.staff_id = s.staff_id

-- Joining inventory and film details
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN language l ON f.language_id = l.language_id

-- Joining film categories
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id

-- Joining film actors
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor ac ON fa.actor_id = ac.actor_id;

select * from store
