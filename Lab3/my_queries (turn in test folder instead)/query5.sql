select l_receiptdate, l_returnflag, l_extendedprice, l_tax
from lineitem
where l_returnflag != 'Y' AND l_receiptdate = '1995-09-22';