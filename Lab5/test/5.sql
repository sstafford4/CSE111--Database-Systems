.headers on

--Find the highest value line item(s) (l extendedprice*(1-l discount)) shipped after October 6,
--1994. Print the name of the part corresponding to these line item(s).

select p_name as part
from lineitem
join part on l_partkey = p_partkey
join orders on l_orderkey = o_orderkey
where o_orderdate > '1994-10-06'
and l_extendedprice * (1 - l_discount) = (select max(l_extendedprice * (1 - l_discount)) from lineitem
                                            join orders on o_orderkey = l_orderkey
                                            where o_orderdate > '1994-10-06')
group by p_name