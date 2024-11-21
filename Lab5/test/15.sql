.headers on

--For the line items ordered in February 1996 (o orderdate), find the largest discount that is smaller
--than the average discount among all the orders.

select l_discount as max_small_disc
from lineitem
join orders on l_orderkey = o_orderkey
where strftime('%Y', o_orderdate) = '1996'
and strftime('%m', o_orderdate) = '02'
and l_discount < (select avg(l_discount) from lineitem)
order by l_discount desc
limit 1