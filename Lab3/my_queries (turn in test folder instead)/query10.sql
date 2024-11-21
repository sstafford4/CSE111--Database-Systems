--Find the name of the suppliers from ASIA who have more than $5,000 on account balance. Print the
--supplier name and their account balance

--this should be correct

select s_name, s_acctbal
from supplier, nation, region
where s_nationkey = n_nationkey
and n_regionkey = r_regionkey
and n_regionkey = '2'
and s_acctbal > 5000
group by s_name

--there are better ways for me to do this but its fine for now