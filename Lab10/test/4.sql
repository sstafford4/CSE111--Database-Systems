.headers on

--INCORRECT
-- returns 178

CREATE TRIGGER t4 AFTER UPDATE ON lineitem
FOR EACH ROW
begin
    UPDATE orders
    SET o_orderpriority = 'HIGH'
    WHERE o_orderkey IN (SELECT DISTINCT l_orderkey
            FROM lineitem
            WHERE l_orderkey = OLD.l_orderkey);
end;

CREATE TRIGGER t42 AFTER DELETE ON lineitem
FOR EACH ROW
begin
    UPDATE orders
    SET o_orderpriority = 'HIGH'
    WHERE o_orderkey IN (SELECT DISTINCT l_orderkey
            FROM lineitem
            WHERE l_orderkey = OLD.l_orderkey);
end;

delete from lineitem
where l_orderkey in (select l_orderkey
                        from lineitem l 
                        join orders o on l.l_orderkey = o.o_orderkey
                        where o.o_orderdate between '1995-12-01' and '1995-12-31'
                        )

SELECT
	COUNT(o_orderkey) AS orders_cnt
FROM
	orders
WHERE
	o_orderdate BETWEEN '1995-09-01' AND '1995-12-31'
	AND
	o_orderpriority = 'HIGH';