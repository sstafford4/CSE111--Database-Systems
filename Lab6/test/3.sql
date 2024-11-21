.headers on

--Find the distinct parts (p name) ordered by customers from ASIA that are supplied by exactly 3 suppliers
--from AFRICA

select distinct p.p_name as part
from customer c
join nation n on c.c_nationkey = n.n_nationkey
join region r on n.n_regionkey = r.r_regionkey
join orders o on c.c_custkey = o.o_custkey
join lineitem l on o.o_orderkey = l.l_orderkey
join part p on l.l_partkey = p.p_partkey
join supplier s on l.l_suppkey = s.s_suppkey
join nation s_n on s.s_nationkey = s_n.n_nationkey
join region s_r on s_n.n_regionkey = s_r.r_regionkey
where r.r_name = 'ASIA'
and s_r.r_name = 'AFRICA'
group by p.p_partkey, p.p_name
having count(distinct s.s_suppkey) = 3;