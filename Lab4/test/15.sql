.headers on

--Find the supplier with the largest account balance in every region. Print the region name, the supplier
--name, and the account balance.

select r_name as region, s_name as supplier, max(s_acctbal) as acct_bal
from supplier, nation, region
where s_nationkey = n_nationkey
and n_regionkey = r_regionkey
group by r_name