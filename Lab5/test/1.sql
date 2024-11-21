.headers on

--How many customers and suppliers are in every nation from ASIA?

-- select customers and suppliers where region = ASIA
select n_name as country, count(distinct c_custkey) as cust_cnt, count(distinct s_suppkey) as supp_cnt
from nation, region, customer, supplier
where n_nationkey = c_nationkey
and n_nationkey = s_nationkey
and n_regionkey = r_regionkey
and r_name = 'ASIA'
group by n_name