.headers on

--How many distinct orders are between customers with negative account balance and suppliers with
--positive account balance?

select count(distinct o_orderkey) as order_cnt
from orders
join customer on o_custkey = c_custkey
join lineitem on o_orderkey = l_orderkey
join supplier on l_suppkey = s_suppkey
where c_acctbal < 0
and s_acctbal > 0