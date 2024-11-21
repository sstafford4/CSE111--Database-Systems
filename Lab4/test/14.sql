.headers on

--How many line items are supplied by suppliers in EUROPE for orders made by customers in INDIA?

select count(l_quantity) as items
from lineitem l
join supplier s on l.l_suppkey = s.s_suppkey
join nation supp_nation on s.s_nationkey = supp_nation.n_nationkey
join orders o on l.l_orderkey = o.o_orderkey
join customer c on o.o_custkey = c.c_custkey
join nation cust_nation on c.c_nationkey = cust_nation.n_nationkey
join region supp_region on supp_nation.n_regionkey = supp_region.r_regionkey
where supp_region.r_regionkey = 3
and cust_nation.n_name = 'INDIA'
group by supp_region.r_name