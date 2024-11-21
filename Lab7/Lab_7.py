import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")

    sql = """
            create table if not exists warehouse (
                w_warehousekey decimal(9,0) not null,
                w_name char(100) not null,
                w_capacity decimal(6,0) not null,
                w_suppkey decimal(9,0) not null,
                w_nationkey decimal(2,0) not null
            )
        """ #""" denotes multi line strings
    _conn.cursor().execute(sql) #executes the sql code
    _conn.commit() #commits it to the db

    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")

    sql = "drop table if exists warehouse"
    _conn.cursor().execute(sql)
    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")

    warr_dict = {
        "w_warehousekey":  1,
        "w_name": "",
        "w_capacity":1,
        "w_suppkey": 1,
        "w_nationkey": 1,
    }

    warr_id = 1
    supp_id = 1
    arr = []

    sql = "select s_name from supplier"
    cur = _conn.cursor()
    cur.execute(sql)
    rows = cur.fetchall()


    for row in rows:
        sql_1 = f""" select n_name, count(l_linenumber) as line_cnt, n_nationkey
                        from supplier, lineitem, customer, orders, nation
                        where c_nationkey = n_nationkey
                        and c_custkey = o_custkey
                        and o_orderkey = l_orderkey
                        and s_suppkey = l_suppkey
                        and s_name = '{row[0]}'
                        group by n_name
                        order by line_cnt desc, n_name asc
                        limit 3
                        """
        sql_2 = f"""
                select part_cnt * 3 as total
                from (select n_name, s_name, sum(p_size) as part_cnt
                        from part, supplier, customer, nation, lineitem, orders
                        where c_nationkey = n_nationkey
                        and c_custkey = o_custkey
                        and o_orderkey = l_orderkey
                        and s_suppkey = l_suppkey
                        and p_partkey = l_partkey
                        and s_name = '{row[0]}'
                        group by n_name, s_name
                        order by part_cnt desc
                        limit 1)
                """
        cur.execute(sql_1)
        rows2 = cur.fetchall()

        cur.execute(sql_2)
        rows3 = cur.fetchall()

        for row2 in rows2:
            arr.append(warr_dict.copy())
            arr[warr_id - 1]["w_warehousekey"] = warr_id
            arr[warr_id - 1]["w_suppkey"] = supp_id
            arr[warr_id - 1]["w_name"] = row[0] + "___" + row2[0]
            arr[warr_id - 1]["w_nationkey"] = row2[2]
            arr[warr_id - 1]["w_capacity"] = rows3[0][0]
            print(arr[warr_id - 1])
            warr_id += 1
        supp_id += 1
    for row in arr:
        sql = "insert into warehouse values(?,?,?,?,?)"
        cur.execute(sql, (list(row.values())))
    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    try:
        output = open('output/1.out', 'w')

        header = "{:>10} {:<40} {:>10} {:>10} {:>10}"
        output.write((header.format("wId", "wName", "wCap", "sId", "nId")) + '\n')

        sql = """
                select 
                    w_warehousekey as wId,
                    w_name as wName, 
                    w_capacity as wCap,
                    w_suppkey  as sID, 
                    w_nationkey as nId
                from warehouse
                """
        
        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print (row)
            output.write((header.format(row[0], row[1], row[2], row[3], row[4])) + "\n")
        output.close()

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        output = open("output/2.out", "w")

        header = "{:<40} {:>10} {:>10}"
        output.write((header.format("nation", "numW", "totCap")) + "\n")

        sql = """
            SELECT
                n_name,
                COUNT(w_warehousekey) AS numW,
                SUM(w_capacity) AS totCap
            FROM
                warehouse,
                nation
            WHERE
                w_nationkey = n_nationkey
            GROUP BY
                n_name
            ORDER BY
                COUNT(w_warehousekey) DESC,
                n_name ASC
        """

        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0], row[1], row[2])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


#Q3 still not passing the test. idk how to get the desired result
def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        input = open("input/3.in", "r")
        nation = input.readline().strip()
        input.close()

        output = open("output/3.out", "w")

        header = "{:<20} {:<20} {:<40}"
        output.write((header.format("supplier", "nation", "warehouse")) + "\n")

        sql = f"""
            SELECT
                s_name AS supplier,
                n1.n_name AS nation,
                w_name AS warehouse
            FROM
                supplier
            JOIN
                warehouse ON s_suppkey = w_suppkey
            JOIN
                nation AS n1 ON s_nationkey = n1.n_nationkey
            JOIN
                nation AS n2 ON w_nationkey = n2.n_nationkey
            WHERE
                n2.n_name = ?
            ORDER BY
                s_name ASC
        """


        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0], row[1], row[2])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")



def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        input = open("input/4.in", "r")
        region = input.readline().strip()
        cap = input.readline().strip()
        input.close()

        output = open("output/4.out", "w")

        header = "{:<40} {:>10}"
        output.write((header.format("warehouse", "capacity")) + "\n")

        sql = f"""
        SELECT
            w_name,
            MIN(w_capacity) as capacity
        FROM
            warehouse
        WHERE
            w_nationkey in (SELECT n_nationkey FROM nation WHERE n_regionkey in (SELECT r_regionkey FROM region WHERE r_name = '{region}'))
            AND w_capacity > ?
        GROUP BY w_name
        ORDER BY capacity DESC
        """
        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0], row[1])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        input = open("input/5.in", "r")
        nation = input.readline().strip()
        input.close()

        output = open("output/5.out", "w")

        header = "{:<20} {:>20}"
        output.write((header.format("region", "capacity")) + "\n")
        sql = f"""
            SELECT
                r_name,
                COALESCE(totCap, 0) AS totCap
            FROM
                region
            LEFT JOIN (
                SELECT
                    r_name as name,
                    SUM(w_capacity) as totCap
                FROM
                    supplier,
                    nation as n1,
                    nation as n2,
                    region,
                    warehouse
                WHERE
                    w_nationkey = n1.n_nationkey
                    AND n1.n_regionkey = r_regionkey
                    AND n2.n_name = ?
                    AND s_nationkey = n2.n_nationkey
                    AND s_suppkey = w_suppkey
                GROUP BY r_name
            ) AS rTotCap ON r_name = name
            GROUP BY r_name
        """

        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0], row[1])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
