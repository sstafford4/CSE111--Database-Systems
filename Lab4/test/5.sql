.headers on

--Find the number of suppliers from each of JAPAN and CHINA

select n_name as country , count(s_nationkey) as cnt
from supplier, nation
where (n_name = 'JAPAN' or n_name = 'CHINA')
and s_nationkey = n_nationkey
group by n_name 