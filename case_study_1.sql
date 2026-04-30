-- 1. What is the total amount each customer spent at the restaurant?

SELECT s.customer_id, SUM(m.price) AS total_spent
FROM sales s
JOIN menu m
    ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id ASC
;

-- 2. How many days has each customer visited the restaurant?

SELECT customer_id, COUNT(DISTINCT order_date) AS days_visited
FROM sales 
GROUP BY customer_id
;

-- 3. What was the first item from the menu purchased by each customer?

-- Uses a CTE to find the earliest order date per customer
-- then joins back to sales and menu tables to retrieve the product
-- ordered on their first visit.
-- Returns all items ordered on the customer's first visit date as the data contains no timestamp to determine order sequence.

WITH first_visit AS (
	SELECT s.customer_id, MIN(s.order_date) AS min_date
	FROM sales s
	GROUP BY s.customer_id)

SELECT s.customer_id, m.product_name AS first_dish
FROM first_visit v
JOIN sales s
	ON v.customer_id = s.customer_id
    AND s.order_date = v.min_date
JOIN menu m
    ON s.product_id = m.product_id
ORDER BY s.customer_id
;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

-- Most purchased item along with number of times ordered.

SELECT m.product_name, COUNT(s.product_id) AS times_ordered
FROM sales s
JOIN menu m
    ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY times_ordered DESC
LIMIT 1;

-- 5. Which item was the most popular for each customer?

-- CTE counts when each customer ordered each product.
-- RANK() window function ranks products per customer by order count descending.
-- Outer query filters to rank 1 to return only the most ordered item per customer.
-- Customer B ordered ramen, sushi and curry equally, therefor his result will have all 3 dishes listed.

WITH times_ordered AS (
    SELECT COUNT(s.product_id) AS product_count,
           m.product_name,
           s.customer_id,
           RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(s.product_id) DESC) AS rank
    FROM sales s
    JOIN menu m
        ON s.product_id = m.product_id
    GROUP BY s.customer_id, m.product_id, m.product_name
)
SELECT product_name, customer_id
FROM times_ordered
WHERE rank = 1
ORDER BY customer_id;

-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
