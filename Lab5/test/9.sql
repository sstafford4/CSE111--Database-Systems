.headers on

--How many suppliers in every region have more balance in their account than the average account
--balance of their own region?

select r_name as region, count(s_suppkey) as supp_cnt
from supplier
join nation on s_nationkey = n_nationkey
join region on n_regionkey = r_regionkey
where s_acctbal > (select avg(s_acctbal) from supplier
                    join nation on s_nationkey = n_nationkey
                    where n_regionkey = r_regionkey)
group by r_name