.headers on

--Count the number of distinct suppliers that supply parts whose type contains BRUSHED and have size
--equal to any of 10, 20, 30, or 40

select count(distinct s_suppkey) as supp_cnt
from supplier
join partsupp on s_suppkey = ps_suppkey
join part on ps_partkey = p_partkey
where p_type like '%BRUSHED%'
and (p_size = 10 or p_size = 20 or p_size = 30 or p_size = 40)

-- this should be correct