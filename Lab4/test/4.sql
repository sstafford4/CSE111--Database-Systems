.headers on

--How many parts in a %CAN% container does every supplier from RUSSIA offer? Print the name of the
--supplier and the number of parts

select s_name as supplier, count(p_partkey) as cnt
from supplier, partsupp
join part on ps_partkey = p_partkey
join nation on s_nationkey = n_nationkey
where s_suppkey = ps_suppkey
and p_container like '%CAN%'
and n_nationkey = 22
group by s_name