.headers on

--Find the supplier-customer pair(s) with the most expensive (o totalprice) order(s) completed (i.e.,
--value of o orderstatus is F). Print the supplier name, the customer name, and the total price.

select s_name as supplier, c_name as customer, o_totalprice as price
from orders
join customer on o_custkey = c_custkey
join lineitem on o_orderkey = l_orderkey
join supplier on l_suppkey = s_suppkey
where o_orderstatus = 'F'
and o_totalprice = (select max(o_totalprice)
                    from orders
                    where o_orderstatus = 'F')
