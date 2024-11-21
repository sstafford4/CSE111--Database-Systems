--Find the total account balance of the suppliers from every nation. Print the nation name and the total
--account balance

select n_name, sum(s_acctbal) as total_acct_bal
from supplier, nation
where supplier.s_nationkey = nation.n_nationkey
group by n_nationkey;