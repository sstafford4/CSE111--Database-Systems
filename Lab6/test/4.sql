.headers on

--Find the nation(s) with the least developed industry, i.e., selling items totaling the smallest amount of
--money (l extendedprice) in 1994 (l shipdate)

SELECT n.n_name AS country
FROM lineitem l
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE strftime('%Y', l.l_shipdate) = '1994'
GROUP BY n.n_name
HAVING SUM(l.l_extendedprice) = (
    SELECT MIN(total_sales)
    FROM (
        SELECT SUM(l2.l_extendedprice) AS total_sales
        FROM lineitem l2
        JOIN supplier s2 ON l2.l_suppkey = s2.s_suppkey
        JOIN nation n2 ON s2.s_nationkey = n2.n_nationkey
        WHERE strftime('%Y', l2.l_shipdate) = '1994'
        GROUP BY n2.n_name
    ) AS sales_summary
)