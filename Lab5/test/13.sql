.headers on

--For any two regions, find the gross discounted revenue (l extendedprice*(1-l discount)) derived
--from line items in which parts are shipped from a supplier in the first region to a customer in the
--second region in 1996 and 1997. List the supplier region, the customer region, the year (l shipdate),
--and the revenue from shipments that took place in that year.

select supp_region.r_name as supp_region, cust_region.r_name as cust_region, strftime('%Y', l.l_shipdate) as year, 
    sum(l.l_extendedprice * (1 - l.l_discount)) as revenue
from lineitem l
join orders o on l.l_orderkey = o.o_orderkey
join supplier s on l.l_suppkey = s.s_suppkey
join nation supp_nation on s.s_nationkey = supp_nation.n_nationkey
join region supp_region on supp_nation.n_regionkey = supp_region.r_regionkey
join customer c on o.o_custkey = c.c_custkey
join nation cust_nation on c.c_nationkey = cust_nation.n_nationkey
join region cust_region on cust_nation.n_regionkey = cust_region.r_regionkey
where strftime('%Y', l.l_shipdate) in ('1996', '1997')
group by supp_region.r_name, cust_region.r_name, year