.headers on

--Find how many parts are supplied by exactly one supplier from UNITED STATES

--OUTPUT: 574--
SELECT COUNT(DISTINCT p.p_partkey) AS part_cnt
FROM part p
JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE n.n_name = 'UNITED STATES'
HAVING COUNT(DISTINCT s.s_suppkey) = 1
