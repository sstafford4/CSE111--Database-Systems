.headers on

--Find the nation(s) with the largest number of customers

--OUTPUT: Iran, Morrocco

SELECT n_name AS country
FROM customer
JOIN nation ON c_nationkey = n_nationkey
GROUP BY n_name
HAVING COUNT(c_custkey) = (
    SELECT MAX(customer_count)
    FROM (
        SELECT COUNT(c_custkey) AS customer_count
        FROM customer
        JOIN nation ON c_nationkey = n_nationkey
        GROUP BY n_name
    ) AS subquery
)
