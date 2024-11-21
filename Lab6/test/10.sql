.headers on

--Find the nation(s) having customers that spend the largest amount of money (o totalprice).
--OUTPUT: CANADA--
SELECT n.n_name AS country
FROM customer c
JOIN orders o ON c.c_custkey = o.o_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
GROUP BY n.n_name
HAVING SUM(o.o_totalprice) = (
    SELECT MAX(total_spent)
    FROM (
        SELECT SUM(o2.o_totalprice) AS total_spent
        FROM customer c2
        JOIN orders o2 ON c2.c_custkey = o2.o_custkey
        JOIN nation n2 ON c2.c_nationkey = n2.n_nationkey
        GROUP BY n2.n_name
    ) AS nation_spending
)