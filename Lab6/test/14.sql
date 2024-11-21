.headers on

--Compute, for every country, the value of economic exchange, i.e., the difference between the number
--of items from suppliers in that country sold to customers in other countries and the number of items
--bought by local customers from foreign suppliers in 1997 (l shipdate)


WITH items_sold AS (
    -- Items shipped from suppliers in a country to foreign customers
    SELECT
        s_nationkey AS nationkey,
        COUNT(*) AS sold_items
    FROM lineitem
    JOIN orders ON l_orderkey = o_orderkey
    JOIN customer ON o_custkey = c_custkey
    JOIN nation cust_nation ON c_nationkey = cust_nation.n_nationkey
    JOIN supplier ON l_suppkey = s_suppkey
    JOIN nation supp_nation ON s_nationkey = supp_nation.n_nationkey
    WHERE strftime('%Y', l_shipdate) = '1997'
      AND cust_nation.n_nationkey != supp_nation.n_nationkey
    GROUP BY s_nationkey
),
items_bought AS (
    -- Items bought by customers from foreign suppliers
    SELECT
        c_nationkey AS nationkey,
        COUNT(*) AS bought_items
    FROM lineitem
    JOIN orders ON l_orderkey = o_orderkey
    JOIN customer ON o_custkey = c_custkey
    JOIN nation cust_nation ON c_nationkey = cust_nation.n_nationkey
    JOIN supplier ON l_suppkey = s_suppkey
    JOIN nation supp_nation ON s_nationkey = supp_nation.n_nationkey
    WHERE strftime('%Y', l_shipdate) = '1997'
      AND cust_nation.n_nationkey != supp_nation.n_nationkey
    GROUP BY c_nationkey
)
-- Calculate the economic exchange value for each nation
SELECT 
    n_name AS country,
    COALESCE(sold_items, 0) - COALESCE(bought_items, 0) AS economic_exchange
FROM nation
LEFT JOIN items_sold ON nation.n_nationkey = items_sold.nationkey
LEFT JOIN items_bought ON nation.n_nationkey = items_bought.nationkey
ORDER BY economic_exchange DESC;