.headers on

--List the minimum total price of an order between any two regions, i.e., the suppliers are from one
--region and the customers are from the other region.

select supp_region.r_name as supp_region, cust_region.r_name as cust_region, min(distinct o.o_totalprice) as min_price
from orders o
join customer c on o.o_custkey = c.c_custkey
join nation cust_nation on c.c_nationkey = cust_nation.n_nationkey
join region cust_region on cust_nation.n_regionkey = cust_region.r_regionkey
join supplier s on o.o_custkey = s.s_suppkey
join nation supp_nation on s.s_nationkey = supp_nation.n_nationkey
join region supp_region on supp_nation.n_regionkey = supp_region.r_regionkey
where cust_nation.n_regionkey != supp_nation.n_regionkey
group by supp_region.r_name, cust_region.r_name

--This one is messy asf