-- What are the Top 25 schools (.edu domains)?

SELECT email_domain, COUNT(*) AS users
FROM users
GROUP BY email_domain
ORDER BY users DESC
LIMIT 25;

-- How many .edu learners are located in New York?

SELECT city, COUNT(*) AS users
FROM users
WHERE city = "New York"
GROUP BY city;

-- How many of these Codecademy learners are using the mobile app?

SELECT mobile_app, COUNT(*) AS users
FROM users
WHERE mobile_app = "mobile-user"
GROUP BY mobile_app;

-- query for the sign up counts for each hour

SELECT DATE_FORMAT(sign_up_at, "%H") AS sign_up_hour, COUNT(*) AS users
FROM users
GROUP BY sign_up_hour
ORDER BY sign_up_hour;

-- Do different schools (.edu domains) prefer different courses? 

WITH join_table 
AS (SELECT email_domain, learn_cpp, learn_sql, learn_html, learn_javascript, learn_java
FROM users u
JOIN progress p
ON u.user_id = p.user_id)
SELECT email_domain, 
COUNT(CASE WHEN learn_cpp IN ('completed', 'started') THEN 1 END) AS 'cpp', 
COUNT(CASE WHEN learn_sql IN ('completed', 'started') THEN 1 END) AS 'sql', 
COUNT(CASE WHEN learn_html IN ('completed', 'started') THEN 1 END) AS 'html',
COUNT(CASE WHEN learn_javascript IN ('completed', 'started') THEN 1 END) AS 'javascript',
COUNT(CASE WHEN learn_java IN ('completed', 'started') THEN 1 END) AS 'java'
FROM join_table
GROUP BY email_domain
ORDER BY COUNT(email_domain) DESC;

-- MySQL 5 compatible version

-- SELECT email_domain, 
-- COUNT(CASE WHEN learn_cpp IN ('completed', 'started') THEN 1 END) AS 'cpp', 
-- COUNT(CASE WHEN learn_sql IN ('completed', 'started') THEN 1 END) AS 'sql', 
-- COUNT(CASE WHEN learn_html IN ('completed', 'started') THEN 1 END) AS 'html',
-- COUNT(CASE WHEN learn_javascript IN ('completed', 'started') THEN 1 END) AS 'javascript',
-- COUNT(CASE WHEN learn_java IN ('completed', 'started') THEN 1 END) AS 'java'
-- FROM progress
-- JOIN users ON progress.user_id = users.user_id
-- GROUP BY email_domain
-- ORDER BY COUNT(email_domain) DESC;


-- What courses are the New Yorkers and Chicago students taking?

WITH join_table AS 
(SELECT city, learn_cpp, learn_sql, learn_html, learn_javascript, learn_java
FROM users u
JOIN progress p
ON u.user_id = p.user_id)
SELECT city, 
COUNT(CASE WHEN learn_cpp IN ('completed', 'started') THEN 1 END) AS 'cpp', 
COUNT(CASE WHEN learn_sql IN ('completed', 'started') THEN 1 END) AS 'sql', 
COUNT(CASE WHEN learn_html IN ('completed', 'started') THEN 1 END) AS 'html',
COUNT(CASE WHEN learn_javascript IN ('completed', 'started') THEN 1 END) AS 'javascript',
COUNT(CASE WHEN learn_java IN ('completed', 'started') THEN 1 END) AS 'java'
FROM join_table
WHERE city IN ("New York", "Chicago")
GROUP BY city;

-- MySQL 5 compatible version

-- SELECT city, 
-- COUNT(CASE WHEN learn_cpp IN ('completed', 'started') THEN 1 END) AS 'cpp', 
-- COUNT(CASE WHEN learn_sql IN ('completed', 'started') THEN 1 END) AS 'sql', 
-- COUNT(CASE WHEN learn_html IN ('completed', 'started') THEN 1 END) AS 'html',
-- COUNT(CASE WHEN learn_javascript IN ('completed', 'started') THEN 1 END) AS 'javascript',
-- COUNT(CASE WHEN learn_java IN ('completed', 'started') THEN 1 END) AS 'java'
-- FROM progress
-- JOIN users ON progress.user_id = users.user_id
-- WHERE city IN ("New York", "Chicago")
-- GROUP BY city;
