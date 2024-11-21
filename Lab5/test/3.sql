.headers on

--How many customers from every region have placed at least one order and have more than the average
--account balance?

select r_name as region, count(distinct c_custkey) as cust_cnt
from customer
join nation on c_nationkey = n_nationkey
join orders on o_custkey = c_custkey
join region on n_regionkey = r_regionkey
where c_acctbal > (select avg(c_acctbal) from customer)
group by r_name

-- this should be correct