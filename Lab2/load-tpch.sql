--going to first set the output mode to csv
.mode "csv"
--now going to set the seperator based on what I saw in each of the .tbl files
.separator "|" 
--in this case, the seperator is |

--for importing, used this tutorial: https://www.sqlitetutorial.net/sqlite-import-csv/
--bc we have specific .tbl files, we load each table with the data from those files.
--with these statements, we're pretty much saying "from the data folder, import the data from [blank].tbl as [blank]" 
.import data/customer.tbl customer 
.import data/lineitem.tbl lineitem
.import data/nation.tbl nation
.import data/orders.tbl orders
.import data/part.tbl part 
.import data/partsupp.tbl partsupp
.import data/region.tbl region
.import data/supplier.tbl supplier