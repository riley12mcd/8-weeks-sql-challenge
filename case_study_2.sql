A. Pizza Metrics
1. How many pizzas were ordered?

SELECT COUNT(pizza_id) AS total_pizzas 
FROM customer_orders;  
  
2. How many unique customer orders were made?

SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM customer_orders;
  
3. How many successful orders were delivered by each runner?

-- Filters out cancellations accounting for three data inconsistencies:
-- actual NULL, empty string '', and the text string 'null'
SELECT runner_id, COUNT(order_id) AS successful_orders
FROM runner_orders
WHERE cancellation IN ('', 'null') OR cancellation IS NULL
GROUP BY runner_id
ORDER BY runner_id;
  
4. How many of each type of pizza was delivered?

SELECT pizza_id, COUNT(pizza_id) AS total_pizzas
FROM customer_orders AS co
JOIN runner_orders AS ro
    ON co.order_id = ro.order_id
WHERE cancellation IN ('', 'null') OR cancellation IS NULL
GROUP BY pizza_id
ORDER BY pizza_id;
  
5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT co.customer_id, pn.pizza_name, COUNT(co.pizza_id) AS pizzas_ordered
FROM customer_orders co
JOIN pizza_names pn
    ON co.pizza_id = pn.pizza_id
GROUP BY co.customer_id, pn.pizza_name
ORDER BY co.customer_id, pn.pizza_name;
  
6. What was the maximum number of pizzas delivered in a single order?


  
7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8. How many pizzas were delivered that had both exclusions and extras?
9. What was the total volume of pizzas ordered for each hour of the day?
10. What was the volume of orders for each day of the week?

---

B. Runner and Customer Experience
1. How many runners signed up for each 1 week period?
2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
4. What was the average distance travelled for each customer?
5. What was the difference between the longest and shortest delivery times for all orders?
6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
7. What is the successful delivery percentage for each runner?

---

C. Ingredient Optimisation
1. What are the standard ingredients for each pizza?
2. What was the most commonly added extra?
3. What was the most common exclusion?
4. Generate an order item for each record in the `customer_orders` table in the format of one of the following:
   - `Meat Lovers`
   - `Meat Lovers - Exclude Beef`
   - `Meat Lovers - Extra Bacon`
   - `Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers`
5. Generate an alphabetically ordered comma separated ingredient list for each pizza order and add a `2x` in front of any relevant ingredients
6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

---

D. Pricing and Ratings
1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 with no charges for changes — how much money has Pizza Runner made so far if there are no delivery fees?
2. What if there was an additional $1 charge for any pizza extras? Add cheese is $1 extra.
3. Design an additional ratings table schema and insert data for ratings between 1 to 5 for each successful customer order.
4. Using your newly generated table — join all information together for successful deliveries showing: `customer_id`, `order_id`, `runner_id`, `rating`, `order_time`, `pickup_time`, time between order and pickup, delivery duration, average speed, total number of pizzas.
5. If a Meat Lovers pizza was $12 and Vegetarian $10 with no cost for extras and each runner is paid $0.30 per kilometre — how much money does Pizza Runner have left over after deliveries?
