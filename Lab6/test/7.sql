.headers on

--Find the total quantity (l quantity) of line items shipped per month (l shipdate) in 1997. Hint:
--check function strftime to extract the month/year from a date.

select strftime('%m',l_shipdate) as month, sum(l_quantity) as tot_month
from lineitem
where strftime('%Y', l_shipdate) = '1997'
group by month