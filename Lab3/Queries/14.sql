.headers on

--Find the number of orders having status F. Group these orders based on the region of the customer
--who posted the order. Print the region name and the number of status F orders.

select r_name, count(o_orderkey) as order_cnt
from orders
join customer on o_custkey = c_custkey
join nation on c_nationkey = n_nationkey
join region on n_regionkey = r_regionkey
where o_orderstatus = 'F'
group by r_name;
