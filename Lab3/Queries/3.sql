.headers on

-- returns the address, phone number, and account balance of the customer given their name is customer#000000227

SELECT c_address, c_phone, c_acctbal
FROM customer
WHERE c_name = 'Customer#000000227';