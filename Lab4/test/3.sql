.headers on

--Find the total price paid on orders by every customer from GERMANY in 1992. Print the customer name
--and the total price.

select c_name as customer,sum(o_totalprice) as total_price
from customer, orders
join nation on c_nationkey = n_nationkey
where n_nationkey = 7 
and o_custkey = c_custkey
and strftime('%Y', o_orderdate) = '1992'
group by c_name