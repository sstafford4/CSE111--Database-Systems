.headers on

--Find the minimum and maximum discount for every part having MEDIUM or TIN in its type

select p_type as part_type, min(l_discount) as min_discount, max(l_discount) as max_discount
from lineitem 
join part on l_partkey = p_partkey
where (p_type like '%MEDIUM%' or p_type like '%TIN%')
group by p_type 