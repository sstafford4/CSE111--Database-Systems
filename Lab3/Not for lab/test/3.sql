.headers on

SELECT
    c_address,
    c_phone,
    c_acctbal
FROM customer
WHERE c_name='Customer#000000227' LIMIT 1;
