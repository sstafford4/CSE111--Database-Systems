--Find the total number of line items on orders with priority 3-MEDIUM supplied by suppliers from
--ARGENTINA and BRAZIL. Group these line items based on the year of the order from o orderdate.
--Print the year and the count. Check the substr function in SQLite.

select substr(o_orderdate,1,4) as order_year, count(l_quantity) as item_cnt
from lineitem
join orders on o_orderkey = l_orderkey
join supplier on l_suppkey = s_suppkey
join nation on s_nationkey = n_nationkey
where (n_nationkey = 1 or n_nationkey = 2)
and o_orderpriority = '3-MEDIUM'
group by order_year