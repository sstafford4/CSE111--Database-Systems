.headers on

--nations and customers that made orders in december 1994
--print every nation only once and have them in alphabetical order

select n_name
from nation, customer, orders
where customer.c_nationkey = nation.n_nationkey
--only want orders from dec 1994, therefore, the line should look something like this:
and strftime('%Y-%m',orders.o_orderdate) = '1994-12' --strftime seperates the dateline features
--and strftime('%m', orders.o_orderdate) = '12' -- must use lowercase m for it to work with months
group by n_nationkey
order by n_name ASC --prints in ascending alphbetical order