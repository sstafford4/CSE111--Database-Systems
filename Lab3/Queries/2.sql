.headers on

-- returns the minimum account balance, the maximum account balance, and the total account balance of
-- every item in customer given that the mktsegment type is FURNITURE
select min(c_acctbal) as min_acct_bal, max(c_acctbal) as max_acct_bal, sum(c_acctbal) as tot_acct_bal
from customer
where c_mktsegment = 'FURNITURE';

--output: -982.32, 9889.89, 1265282.7999999996