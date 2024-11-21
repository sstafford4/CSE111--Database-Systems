.headers on

SELECT o_totalprice as total_price
FROM
    orders,
    customer,
    nation,
    region
WHERE
    c_custkey = o_custkey
    AND
    strftime('%Y', o_orderdate) = '1995'
    AND
    c_nationkey = n_nationkey
    AND
    n_regionkey = r_regionkey
    AND
    r_name = 'AMERICA';

