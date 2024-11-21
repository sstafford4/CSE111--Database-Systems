.headers on

--Find the number of customers who had at most three orders in November 1995 (o orderdate)

--OUTPUT: 174--
select count(distinct c_custkey) as customer_cnt
from customer
join orders on c_custkey = o_custkey
where strftime('%Y-%m', o_orderdate) = '1995-11'
having count(distinct o_orderkey) = 3
