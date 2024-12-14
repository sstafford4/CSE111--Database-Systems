.headers on


-- CORRECT
CREATE TRIGGER t3 AFTER UPDATE ON customer
FOR EACH ROW
BEGIN
    UPDATE customer
    SET c_comment = 'Positive balance'
    WHERE c_acctbal > 0;
end;


UPDATE customer
SET c_acctbal = 100
WHERE
	c_nationkey IN (SELECT n_nationkey
					FROM nation
					WHERE n_name = 'MOZAMBIQUE');


SELECT COUNT(c_custkey) AS customer_cnt
FROM customer,nation,region
WHERE c_nationkey = n_nationkey
AND n_regionkey = r_regionkey
AND r_name = 'AFRICA'
AND c_acctbal < 0;