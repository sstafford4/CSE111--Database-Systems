.headers on

--How many orders do customers in every nation in ASIA have in every status? Print the nation name,
--the order status, and the count.

select n_name as country, o_orderstatus as status, count(o_orderkey) as orders
from nation, orders
join customer on o_custkey = c_custkey
join region on n_regionkey = r_regionkey
where c_nationkey = n_nationkey 
and r_name = 'ASIA'
group by n_name, o_orderstatus
