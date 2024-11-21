.headers on

SELECT l_shipdate AS item_cnt
FROM lineitem
WHERE l_shipdate < l_commitdate;
