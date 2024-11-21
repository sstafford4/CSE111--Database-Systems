.headers on

--Find how many distinct customers have at least one order supplied exclusively by suppliers from
--AFRICA.

select count(distinct c_custkey) as customer_cnt
from customer
join orders on c_custkey = o_custkey
join lineitem on o_orderkey = l_orderkey
join supplier on l_suppkey = s_suppkey
join nation on s_nationkey = n_nationkey
join region on n_regionkey = r_regionkey
where r_name = 'AFRICA'
and o_orderkey not in (select l_orderkey
                        from lineitem
                        join supplier on l_suppkey = s_suppkey
                        join nation on s_nationkey = n_nationkey
                        join region on r_regionkey = n_regionkey
                        where r_name != 'AFRICA')
