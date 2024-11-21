.headers on

--The market share for a given nation within a given region is defined as the fraction of the revenue from
--the line items ordered by customers in the given region that are supplied by suppliers from the given
--nation. The revenue of a line item is defined as l extendedprice*(1-l discount). Determine the
--market share of GERMANY in ASIA in 1995 (l shipdate).

with total_rev as (
select sum(l_extendedprice * (1 - l_discount)) as total
from region, nation, customer, lineitem, orders
where r_name = 'ASIA'
and r_regionkey = n_regionkey
and n_nationkey = c_nationkey
and c_custkey = o_custkey
and o_orderkey = l_orderkey
)

select sum(l.l_extendedprice * (1 - l.l_discount)) / total as GERMANY_in_ASIA_in_1995
from total_rev, region cust_region, nation supp_nation, nation cust_nation, lineitem l, orders o
join  supplier s on s.s_nationkey = supp_nation.n_nationkey
join customer c on c.c_nationkey = cust_nation.n_nationkey
where supp_nation.n_name = 'GERMANY'
and cust_nation.n_regionkey = cust_region.r_regionkey
and cust_region.r_name = 'ASIA'
and l.l_suppkey = s.s_suppkey
and l.l_orderkey = o.o_orderkey
and o.o_custkey = c.c_custkey
and strftime('%Y', l.l_shipdate) = '1995'