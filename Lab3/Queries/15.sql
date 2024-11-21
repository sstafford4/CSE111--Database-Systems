.headers on

--Find the total account balance of all the customers from AMERICA in the FURNITURE market segment.

--gonna need customer, region, nation
select sum(c_acctbal) as tot_acct_bal
from customer
join nation on c_nationkey = n_nationkey
join region on n_regionkey = r_regionkey
where r_name = 'AMERICA' 
and c_mktsegment = 'FURNITURE'
