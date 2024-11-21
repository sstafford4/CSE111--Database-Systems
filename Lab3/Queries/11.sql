.headers on

-- idk if this is correct. I think that everything should be right, but i am unsure
--current output: 9111
select count(o_orderpriority) as order_cnt
from orders
join customer on c_custkey = o_custkey
join nation on c_nationkey = n_nationkey

where strftime('%Y',o_orderdate)='1993' or strftime('%Y',o_orderdate)='1994' or strftime('%Y',o_orderdate)='1995' or strftime('%Y',o_orderdate)='1996' or strftime('%Y',o_orderdate)='1997' 
and n_name = 19
and o_orderpriority = '1-URGENT'
