.headers on

--Find how many suppliers have less than 50 distinct orders from customers in EGYPT and JORDAN
--together.

-- Output: 37--
SELECT 
    COUNT(s_name) AS supplier_cnt
FROM 
    (SELECT
        s_name,
        COUNT(DISTINCT o_orderkey) as num_orders
    FROM
        supplier,
        customer,
        nation,
        lineitem,
        orders
    WHERE
        c_nationkey = n_nationkey
        AND
        n_name IN ('EGYPT', 'JORDAN')
        AND
        o_orderkey = l_orderkey
        AND
        c_custkey = o_custkey
        AND
        l_suppkey = s_suppkey
    GROUP BY
        s_name
    HAVING
        num_orders < 50);
