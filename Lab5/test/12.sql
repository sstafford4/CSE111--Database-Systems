.headers on

--Count the number of orders made in 1995 in which at least one line item was received (l receiptdate)
--by a customer later than its commit date (l commitdate). List the count of such orders for every order
--priority.

select o_orderpriority as priority, count(distinct o_orderkey) as order_cnt
from orders
join lineitem on o_orderkey = l_orderkey
where strftime('%Y', o_orderdate) = '1995'
and l_receiptdate > l_commitdate
group by o_orderpriority