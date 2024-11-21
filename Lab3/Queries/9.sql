.headers on

--COMPLETE

--How many line items ordered by Customer#000000227 were received every month? Print the number
--of ordered line items corresponding to every (year, month) pair from l_receiptdate

-- this takes the count of each l_receiptdate and the year and month of each l_receiptdate
-- that matches the parameters

select strftime('%Y-%m',l_receiptdate) as year_month, COUNT(l_receiptdate) as items
from orders,customer,lineitem
where orders.o_custkey = customer.c_custkey --matches customer keys
and lineitem.l_orderkey = orders.o_orderkey -- matches order keys
and customer.c_name = 'Customer#000000227' --ensures that cust name matches
group by year_month
order by year_month ASC
