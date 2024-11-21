.headers on

--Find the number of line items that have l shipdate smaller than l commitdate.
select count(l_quantity) as itm_cnt
from lineitem 
where l_shipdate < l_commitdate