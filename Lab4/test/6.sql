.headers on

--How many unique parts produced by every supplier in ARGENTINA are ordered at every priority? Print
--the supplier name, the order priority, and the number of parts.

select s_name as supplier, o_orderpriority as priority, count(distinct p_partkey) as parts
from supplier, orders
join nation on s_nationkey = n_nationkey
join partsupp on s_suppkey = ps_suppkey
join part on ps_partkey = p_partkey
where n_name = 'ARGENTINA'
group by s_name, o_orderpriority
