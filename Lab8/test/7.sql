.eqp on
.headers on

select sum(o_totalprice) as total_price
from orders, customer, nation, region
where o_custkey=c_custkey and
    c_nationkey=n_nationkey and
    r_regionkey=n_regionkey and
    r_name='AMERICA' and
    o_orderdate>='1995-01-01' and o_orderdate<='1995-12-31';
