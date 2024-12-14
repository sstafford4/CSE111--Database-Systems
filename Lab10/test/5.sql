.headers on 

--CORRECT

CREATE TRIGGER t5 AFTER DELETE ON part
FOR EACH ROW
BEGIN
	DELETE FROM partsupp WHERE ps_partkey = old.p_partkey;
	DELETE FROM lineitem WHERE l_partkey = old.p_partkey;
END;

DELETE FROM part
WHERE p_partkey IN (
    SELECT p_partkey
    FROM part
    JOIN partsupp ON part.p_partkey = partsupp.ps_partkey
    JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
    JOIN nation ON supplier.s_nationkey = nation.n_nationkey
    WHERE nation.n_name IN ('KENYA', 'MOROCCO')
);

SELECT
        n_name AS country,
        COUNT(ps_partkey) as parts_cnt
FROM part,nation,region,supplier, partsupp
WHERE s_suppkey = ps_suppkey
AND ps_partkey = p_partkey
AND s_nationkey = n_nationkey
AND n_regionkey = r_regionkey
AND r_name = 'AFRICA'
GROUP BY n_name
ORDER BY n_name;