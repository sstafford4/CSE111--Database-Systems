.headers on

--How many orders are posted by customers in every country in MIDDLE EAST?
select n_name as country, count(o_orderkey) as cnt
from orders, customer, nation
join region on n_regionkey = r_regionkey
where o_custkey = c_custkey
and c_nationkey = n_nationkey
and r_name = 'MIDDLE EAST'
group by n_name