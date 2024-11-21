.headers on

--How many customers are not from AMERICA or EUROPE?

select count(c_custkey) as cust_cnt
from customer 
join nation on c_nationkey = n_nationkey
join region on n_regionkey = r_regionkey
where not(r_name = 'AMERICA' or r_name = 'EUROPE')