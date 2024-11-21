.headers on

--For parts whose type contains NICKEL, return the name of the supplier from AFRICA that can supply
--them at maximum cost (ps supplycost), for every part size. Print the supplier name together with
--the part size and the maximum cost.

select s_name as supplier, p_size as part_size, ps_supplycost as max_cost
from supplier
join partsupp on s_suppkey = ps_suppkey
join part as p on ps_partkey = p.p_partkey
join nation on s_nationkey = n_nationkey
join region on n_regionkey = r_regionkey
where r_name = 'AFRICA'
and p_type like '%NICKEL%'
and ps_supplycost = (select max(ps_supplycost) from partsupp ps2
                        join part as p2 on p_partkey = ps_partkey
                        where p_type like '%NICKEL%'
                        and p2.p_size = p.p_size )
group by s_name, p_size