.headers on

--What is the maximum account balance for the suppliers in every region? Print only those regions for
--which the maximum balance is larger than 9000.

select r_name as region, max(s_acctbal) as max_bal
from supplier
join nation on s_nationkey = n_nationkey
join region on n_regionkey = r_regionkey
where s_acctbal > 9000
group by r_name 