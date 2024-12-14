.headers on

-- CORRECT

CREATE TRIGGER t1 BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderdate = DATE('2023-12-01')
    WHERE o_orderkey = NEW.o_orderkey;
END;

INSERT INTO orders
SELECT *
FROM orders
WHERE o_orderdate BETWEEN '1995-12-01' AND '1995-12-31';

SELECT
    COUNT(o_orderkey) AS orders_cnt
FROM
    orders
WHERE
    o_orderdate LIKE '%2023%';