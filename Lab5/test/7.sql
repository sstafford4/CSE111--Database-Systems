.headers on

--Print the name of the parts supplied by suppliers from ARGENTINA that have total value in the top
--10% total values across all the supplied parts. The total value is ps supplycost*ps availqty. Hint:
--Use the LIMIT keyword with a SELECT subquery

with top_value_parts as (
    select p_name as part, (ps_supplycost * ps_availqty) as total_value
    from part
    join partsupp on p_partkey = ps_partkey
    join supplier on ps_suppkey = s_suppkey
    join nation on s_nationkey = n_nationkey
    where n_name = 'ARGENTINA'
    order by total_value desc
)
select part
from top_value_parts
limit (select count(*) * 0.1 from top_value_parts)
