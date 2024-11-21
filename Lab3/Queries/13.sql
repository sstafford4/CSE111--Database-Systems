.headers on

--Find the number of suppliers that provided a discount of 10% for one of their line items. For every
--such supplier, print its name and the number of such discounted line items.
select distinct s_name, count(l_quantity) as discounted_items -- takes in s_name and the count of lineitem quantities 
from supplier, lineitem
where l_suppkey = s_suppkey -- for items where the suppkey matches
and l_discount = 0.1 -- and where the discount is 10%
group by s_name -- then groups them by the name of the supplier
