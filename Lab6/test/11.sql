.headers on

--find the region where customers spend the largest amount of money (l extendedprice) buying items
--from suppliers in the same region.
--OUTPUT: Asia -- 

SELECT r.r_name AS region
FROM customer c
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
JOIN orders o ON c.c_custkey = o.o_custkey
JOIN lineitem l ON o.o_orderkey = l.l_orderkey
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN nation sn ON s.s_nationkey = sn.n_nationkey
JOIN region sr ON sn.n_regionkey = sr.r_regionkey
WHERE r.r_regionkey = sr.r_regionkey -- Ensure customer and supplier are in the same region
GROUP BY r.r_name
ORDER BY SUM(l.l_extendedprice) DESC
LIMIT 1;