--Find the number of line items that have l shipdate smaller than l commitdate.

-- i still dont think this is giving me the correct number

select count(l_quantity) as itm_cnt
from lineitem 
where l_shipdate < l_commitdate