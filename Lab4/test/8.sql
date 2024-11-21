.headers on

--How many different order clerks did the suppliers in IRAQ work with?

select count(distinct o_clerk) as clerks
from supplier
join nation on s_nationkey = n_nationkey
join customer on s_nationkey = c_nationkey
join orders on c_custkey = o_custkey
where n_name = 'IRAQ'
group by n_name