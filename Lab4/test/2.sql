.headers on

--Find the number of orders posted by every customer from MOZAMBIQUE in 1997
select c_name as customer, count(o_orderkey) as cnt
from customer, orders
join nation on c_nationkey = n_nationkey
where n_name = 'MOZAMBIQUE'
and strftime('%Y', o_orderdate) = '1997'
and c_custkey = o_custkey
group by c_name
