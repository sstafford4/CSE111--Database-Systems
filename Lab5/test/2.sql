.headers on

--For every order priority, count the number of line items ordered in 1998 and received (l receiptdate)
--earlier than the commit date (l commitdate)

select o_orderpriority as priority, count(l_orderkey) as item_cnt
from orders
join lineitem on o_orderkey = l_orderkey
where strftime('%Y', o_orderdate) = '1998'
and l_receiptdate < l_commitdate
group by o_orderpriority