.headers on

--Based on the available quantity of items, who is the manufacturer p mfgr of the most popular item
--(the more popular an item is, the less available it is in ps availqty) from Supplier#000000084?

select p_mfgr as manufacturer
from part
join partsupp on p_partkey = ps_partkey
join supplier on ps_suppkey = s_suppkey
where s_name = 'Supplier#000000084'
and ps_availqty = (select min(ps_availqty) from partsupp
                    where ps_suppkey = s_suppkey)
