.headers on

--Find how many suppliers supply the least expensive part (p retailprice)

--OUTPUT: 8--
select count(s_suppkey) as supplier_cnt 
from supplier
join partsupp on s_suppkey = ps_suppkey
join part on ps_partkey = p_partkey
where p_retailprice = (select min(p_retailprice)
                        from part)