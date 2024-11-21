--Find the total price o totalprice of orders made by customers from AMERICA in 1995

select o_totalprice as total_price
from orders, customer, nation, region
where customer.c_custkey = orders.o_custkey
and strftime('%Y',orders.o_orderdate) = '1995'
and customer.c_nationkey = nation.n_nationkey
and nation.n_regionkey = region.r_regionkey
and region.r_name = 'AMERICA'