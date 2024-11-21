.headers on

--in 1996 (l shipdate) by suppliers who did not supply any line item with an extended price less than
--1800 in 1998?

select sum(ps_supplycost) as total_supply_cost
from partsupp
join part on ps_partkey = p_partkey
join lineitem on ps_partkey = l_partkey
join supplier on ps_suppkey = s_suppkey
where p_retailprice < 1500
and strftime('%Y', l_shipdate) = '1996'
and s_name not in (select l_suppkey from lineitem
               join supplier on s_suppkey = l_suppkey
               where strftime('%Y', l_shipdate) = '1998'
               and l_extendedprice < 1800)