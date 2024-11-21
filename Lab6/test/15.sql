.headers on

--Compute the change in the economic exchange for every country between 1996 and 1998. There should
--be two columns in the output for every country: 1997 and 1998. Hint: use CASE to select the values
--in the result.

WITH items_sold AS (
    -- Items sold by suppliers in a country to foreign customers in both 1996 and 1998
    SELECT
        s_nationkey AS nationkey,
        strftime('%Y', l_shipdate) AS year,
        COUNT(*) AS sold_items
    FROM lineitem
    JOIN orders ON l_orderkey = o_orderkey
    JOIN customer ON o_custkey = c_custkey
    JOIN nation cust_nation ON c_nationkey = cust_nation.n_nationkey
    JOIN supplier ON l_suppkey = s_suppkey
    JOIN nation supp_nation ON s_nationkey = supp_nation.n_nationkey
    WHERE strftime('%Y', l_shipdate) IN ('1997', '1998')
      AND cust_nation.n_nationkey != supp_nation.n_nationkey
    GROUP BY s_nationkey, strftime('%Y', l_shipdate)
),
items_bought AS (
    -- Items bought by customers in a country from foreign suppliers in both 1996 and 1998
    SELECT
        c_nationkey AS nationkey,
        strftime('%Y', l_shipdate) AS year,
        COUNT(*) AS bought_items
    FROM lineitem
    JOIN orders ON l_orderkey = o_orderkey
    JOIN customer ON o_custkey = c_custkey
    JOIN nation cust_nation ON c_nationkey = cust_nation.n_nationkey
    JOIN supplier ON l_suppkey = s_suppkey
    JOIN nation supp_nation ON s_nationkey = supp_nation.n_nationkey
    WHERE strftime('%Y', l_shipdate) IN ('1997', '1998')
      AND cust_nation.n_nationkey != supp_nation.n_nationkey
    GROUP BY c_nationkey, strftime('%Y', l_shipdate)
)
-- Calculate the economic exchange value for each nation for 1996 and 1998
SELECT 
    n_name AS country,
    -- Economic exchange in 1996
    COALESCE(SUM(CASE WHEN items_sold.year = '1997' THEN sold_items ELSE 0 END), 0) -
    COALESCE(SUM(CASE WHEN items_bought.year = '1997' THEN bought_items ELSE 0 END), 0) AS '1997',
    
    -- Economic exchange in 1998
    COALESCE(SUM(CASE WHEN items_sold.year = '1998' THEN sold_items ELSE 0 END), 0) -
    COALESCE(SUM(CASE WHEN items_bought.year = '1998' THEN bought_items ELSE 0 END), 0) AS '1998'
FROM nation
LEFT JOIN items_sold ON nation.n_nationkey = items_sold.nationkey
LEFT JOIN items_bought ON nation.n_nationkey = items_bought.nationkey
GROUP BY n_name
ORDER BY '1997' DESC, '1998' DESC