-- #1 How many film recommendation about "astronauts"?
select count(*) 
from film f 
where description like '%stronaut%'

-- #2 how many films have a rating of “R” and a replacement cost between $5 and $15?
select count(*) 
from film f 
where rating = 'R' and (replacement_cost > 5 and replacement_cost < 5)

-- #3 How many payments did each staff member handle? And how much was the total amount processed by each staff member?
select staff_id, count(staff_id) as number_of_payment, sum(amount) as total_payment 
from payment p 
group by staff_id 

-- #4 How many average replacement cost of movies by rating?
select rating, AVG(replacement_cost) as average_replacement_cost
from film f
group by rating 

-- #5 Find out 5 customers who have spent the most amount of money! Get the customer name, email and their spent amount!
select concat(c.first_name,' ', c.last_name) as name, c.email, sum(p.amount) as total_amount
from customer c
inner join payment p 
on c.customer_id = p.customer_id 
group by c.customer_id 
order by total_amount desc 
limit 5

-- #6 How many copies of each movie in each store?
select store_id, film_id, count(film_id) as copies_movies
from inventory i 
group by store_id, film_id 
order by store_id 

-- #7 Find out the customer has at least a total of 40 transaction payments with customer name and email!
select concat(c.first_name,' ', c.last_name) as name, c.email, count(p.amount) as total
from payment p 
inner join customer c 
on p.customer_id = c.customer_id 
group by c.customer_id 
having count(amount) >= 40
order by total desc;
-- or
select concat(c1.first_name,' ', c1.last_name) as name, c1.email, total
from (select c.first_name, c.last_name, c.email, count(p.amount) as total
from customer c
inner join payment p
on c.customer_id = p.customer_id
group by first_name, last_name, email) c1
where total >= 40
order by total desc;