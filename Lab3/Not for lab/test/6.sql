.headers on

SELECT
    n_name,
    SUM(s_acctbal) as total_acct_bal
FROM
    supplier,
    nation
WHERE
    supplier.s_nationkey = nation.n_nationkey
GROUP BY
    n_nationkey;
