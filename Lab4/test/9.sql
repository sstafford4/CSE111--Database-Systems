.headers on

-- Find the number of distinct orders completed in 1994 by the suppliers in every nation in AMERICA. An
--order status of F stands for complete. Print only those nations for which the number of orders is larger
--than 250.

select n_name as country, count(distinct o_orderkey) as cnt
from nation
join supplier on n_nationkey = s_nationkey
join region on n_regionkey = r_regionkey
join customer on c_nationkey = n_nationkey
join orders on o_custkey = c_custkey
where r_name = 'AMERICA'
and o_orderstatus = 'F'
and strftime('%Y',o_orderdate) = '1994'
group by n_name
having count(o_orderkey) > 250

