.headers on

 SELECT 
    MIN(c_acctbal) as min_acct_bal,
    MAX(c_acctbal) as max_acct_bal, 
    SUM(DISTINCT c_acctbal) as tot_acct_bal  
FROM customer 
WHERE c_mktsegment='FURNITURE'
