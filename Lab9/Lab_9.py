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


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")
    cur = _conn.cursor()

    sql = "DROP VIEW IF EXISTS V1"

    cur.execute(sql)

    sql = """CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS
    SELECT
        c_custkey,
        c_name,
        c_address,
        c_phone,
        c_acctbal,
        c_mktsegment,
        c_comment,
        n_name as c_nation,
        r_name as c_region
    FROM
        customer,
        nation,
        region
    WHERE
        c_nationkey = n_nationkey
        AND n_regionkey = r_regionkey
    """
    cur.execute(sql)

    sql = "SELECT * FROM V1"
    cur.execute(sql)
    rows = cur.fetchall()

    for row in rows:
        print(row)

    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    try:
        output = open("output/1.out", "w")

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + "\n")

        sql = """SELECT
                    c_nation,
                    COUNT(c_custkey)
                FROM
                    V1
                WHERE
                    c_region = 'MIDDLE EAST'
                GROUP BY
                    c_nation"""

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


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")

    cur = _conn.cursor()

    sql = "DROP VIEW IF EXISTS V2"

    cur.execute(sql)

    sql = """
    CREATE VIEW V2(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS
    SELECT
        o_orderkey,
        o_custkey,
        o_orderstatus,
        o_totalprice,
        strftime('%Y', o_orderdate) as o_orderyear,
        o_orderpriority,
        o_clerk,
        o_shippriority,
        o_comment
    FROM
        orders
    """

    cur.execute(sql)

    sql = "SELECT * FROM V2"
    cur.execute(sql)
    rows = cur.fetchall()

    for row in rows:
        print(row)

    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        output = open("output/2.out", "w")

        header = "{}|{}"
        output.write((header.format("customer", "cnt")) + "\n")

        sql = """
            SELECT
                c_name as customer,
                COUNT(DISTINCT o_orderkey) as cnt
            FROM
                V1,
                V2
            WHERE
                c_custkey = o_custkey
                AND c_nation = 'MOZAMBIQUE'
                AND o_orderyear = '1997'
            GROUP BY
                c_name
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


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        output = open("output/3.out", "w")

        header = "{}|{}"
        output.write((header.format("customer", "total_price")) + "\n")

        sql = """
            SELECT
                c_name as customer,
                total(o_totalprice) as total_price
            FROM
                V1,
                V2
            WHERE
                c_custkey = o_custkey
                AND c_nation = 'GERMANY'
                AND o_orderyear = '1992'
            GROUP BY
                c_name
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


def create_View4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V4")

    cur = _conn.cursor()

    sql = "DROP VIEW IF EXISTS V4"

    cur.execute(sql)

    sql = """
    CREATE VIEW V4(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS
    SELECT
        s_suppkey,
        s_name,
        s_address,
        s_phone,
        s_acctbal,
        s_comment,
        n_name as s_nation,
        r_name as s_region
    FROM
        supplier,
        nation,
        region
    WHERE
        s_nationkey = n_nationkey
        AND n_regionkey = r_regionkey
    """

    cur.execute(sql)

    sql = "SELECT * FROM V4"
    cur.execute(sql)
    rows = cur.fetchall()

    for row in rows:
        print(row)

    _conn.commit()

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        output = open("output/4.out", "w")

        header = "{}|{}"
        output.write((header.format("supplier", "cnt")) + "\n")

        sql = """
        SELECT
            s_name as supplier,
            COUNT(*) as cnt
        FROM
            V4,
            partsupp,
            part
        WHERE
            s_nation = 'RUSSIA'
            AND s_suppkey = ps_suppkey
            AND ps_partkey = p_partkey
            AND p_container LIKE '%CAN%'
        GROUP BY
            s_name
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


def q02a(model: str, quantity: int, _conn: sqlite3.Connection) -> None:
    print("++++++++++++++++++++++++++++++++++")

    if model == "":
        model = "None"

    if quantity < 0:
        quantity = 0

    sql = f"""
        INSERT VALUES INTO Inventory VALUES ({model}, {quantity})
    """

    cur = _conn.cursor()
    cur.execute(sql)
    _conn.commit()


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        output = open("output/5.out", "w")

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + "\n")

        sql = """
            SELECT
                s_nation,
                COUNT(s_suppkey) as cnt
            FROM
                V4
            WHERE
                s_nation IN ('JAPAN', 'CHINA')
            GROUP BY
                s_nation
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


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")

    try:
        output = open("output/6.out", "w")

        header = "{}|{}|{}"
        output.write((header.format("supplier", "priority", "parts")) + "\n")

        sql = """
            SELECT
                s_name as supplier,
                o_orderpriority as priority,
                COUNT(DISTINCT p_partkey) as parts
            FROM
                V4,
                V2,
                partsupp,
                lineitem,
                part
            WHERE
                s_suppkey = ps_suppkey
                AND ps_partkey = l_partkey
                AND l_orderkey = o_orderkey
                AND l_suppkey = s_suppkey
                AND s_nation = 'ARGENTINA'
                AND ps_partkey = p_partkey
            GROUP BY
                s_name,
                o_orderpriority
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


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")

    try:
        output = open("output/7.out", "w")

        header = "{}|{}|{}"
        output.write((header.format("country", "status", "orders")) + "\n")

        sql = """
            SELECT
                c_nation,
                o_orderstatus as status,
                COUNT(o_orderkey) as orders
            FROM
                V1,
                V2
            WHERE
                c_region = 'ASIA'
                AND c_custkey = o_custkey
            GROUP BY
                c_nation,
                o_orderstatus
            ORDER BY
                c_nation,
                o_orderstatus
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


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")

    try:
        output = open("output/8.out", "w")

        header = "{}"
        output.write((header.format("clerks")) + "\n")

        sql = """
            SELECT
                COUNT(DISTINCT o_clerk) as clerks
            FROM
                V2,
                V4,
                lineitem
            WHERE
                o_orderkey = l_orderkey
                AND l_suppkey = s_suppkey
                AND s_nation = 'IRAQ'
        """

        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")

    try:
        output = open("output/9.out", "w")

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + "\n")

        sql = """
            SELECT
                s_nation,
                COUNT(DISTINCT o_orderkey) as cnt
            FROM
                V4,
                V2,
                lineitem
            WHERE
                o_orderkey = l_orderkey
                AND l_suppkey = s_suppkey
                AND s_region = 'AMERICA'
                AND o_orderyear = '1994'
                AND o_orderstatus = 'F'
            GROUP BY
                s_nation
            HAVING
                cnt > 200
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


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")
    cur = _conn.cursor()

    sql = "DROP VIEW IF EXISTS V10"

    cur.execute(sql)

    sql = """
    CREATE VIEW V10(p_type, min_discount, max_discount) AS
    SELECT
        p_type,
        MIN(l_discount) as min_discount,
        MAX(l_discount) as max_discount
    FROM
        part,
        lineitem
    WHERE
        p_partkey = l_partkey
    GROUP BY
        p_type
    """

    cur.execute(sql)

    sql = "SELECT * FROM V10"
    cur.execute(sql)
    rows = cur.fetchall()

    for row in rows:
        print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")

    try:
        output = open("output/10.out", "w")

        header = "{}|{}|{}"
        output.write((header.format("part_type", "min_disc", "max_disc")) + "\n")

        sql = """
            SELECT
                p_type,
                min_discount,
                max_discount
            FROM
                v10
            WHERE
                p_type like '%MEDIUM%'
                OR p_type like '%TIN%'
            GROUP BY
                p_type
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


def create_View111(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V111")
    cur = _conn.cursor()

    sql = "DROP VIEW IF EXISTS V111"

    cur.execute(sql)

    sql = """
    CREATE VIEW V111(c_custkey, c_name, c_nationkey, c_acctbal) AS
    SELECT
        c_custkey,
        c_name,
        c_nationkey,
        c_acctbal
    FROM
        customer
    WHERE
        c_acctbal < 0
    """

    cur.execute(sql)

    sql = "SELECT * FROM V111"

    cur.execute(sql)

    rows = cur.fetchall()

    for row in rows:
        print(row)

    print("++++++++++++++++++++++++++++++++++")


def create_View112(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V112")
    cur = _conn.cursor()

    sql = "DROP VIEW IF EXISTS V112"

    cur.execute(sql)

    sql = """
    CREATE VIEW V112(s_suppkey, s_name, s_nationkey, s_acctbal) AS
    SELECT
        s_suppkey,
        s_name,
        s_nationkey,
        s_acctbal
    FROM
        supplier
    WHERE
        s_acctbal > 0
    """

    cur.execute(sql)

    sql = "SELECT * FROM V112"

    cur.execute(sql)

    rows = cur.fetchall()

    for row in rows:
        print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")

    try:
        output = open("output/11.out", "w")

        header = "{}"
        output.write((header.format("order_cnt")) + "\n")

        sql = """
            SELECT
                COUNT(DISTINCT o_orderkey) as order_cnt
            FROM
                V111,
                V112,
                lineitem,
                orders
            WHERE
                o_orderkey = l_orderkey
                AND l_suppkey = s_suppkey
                AND c_custkey = o_custkey
        """

        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")

    try:
        output = open("output/12.out", "w")

        header = "{}|{}"
        output.write((header.format("region", "max_bal")) + "\n")

        sql = """
            SELECT
                s_region,
                MAX(s_acctbal) as max_bal
            FROM
                V4
            GROUP BY
                s_region
            HAVING
                max_bal > 9000
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


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")

    try:
        output = open("output/13.out", "w")

        header = "{}|{}|{}"
        output.write((header.format("supp_region", "cust_region", "min_price")) + "\n")

        sql = """
        SELECT
            s_region as supp_region,
            c_region as cust_region,
            MIN(o_totalprice) as min_price
        FROM
            V4,
            V2,
            V1,
            lineitem
        WHERE
            l_suppkey = s_suppkey
            AND l_orderkey = o_orderkey
            AND o_custkey = c_custkey
            AND s_region <> c_region
        GROUP BY
            s_region,
            c_region
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


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")

    try:
        output = open("output/14.out", "w")

        header = "{}"
        output.write((header.format("items")) + "\n")

        sql = """
            SELECT
                COUNT(*) as items
            FROM
                V1,
                V2,
                V4,
                lineitem
            WHERE
                o_orderkey = l_orderkey
                AND o_custkey = c_custkey
                AND l_suppkey = s_suppkey
                AND c_nation = 'INDIA'
                AND s_region = 'EUROPE'
        """

        cur = _conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()

        for row in rows:
            print(row)
            output.write((header.format(row[0])) + "\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")

    try:
        output = open("output/15.out", "w")

        header = "{}|{}|{}"
        output.write((header.format("region", "supplier", "acct_bal")) + "\n")

        sql = """
            SELECT
                s_region as region,
                s_name as supplier,
                MAX(s_acctbal) as acct_bal
            FROM
                V4
            GROUP BY
                s_region
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


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    if conn:
        create_View1(conn)
        Q1(conn) # WRONG

        create_View2(conn)
        Q2(conn) # RIGHT

        Q3(conn) # RIGHT

        create_View4(conn)
        Q4(conn) # RIGHT

        Q5(conn) # RIGHT 
        Q6(conn) # RIGHT
        Q7(conn) # RIGHT
        Q8(conn) # RIGHT
        Q9(conn) # WRONG

        create_View10(conn)
        Q10(conn) # RIGHT

        create_View111(conn)
        create_View112(conn)
        Q11(conn) # RIGHT

        Q12(conn) # RIGHT
        Q13(conn) # WRONG
        Q14(conn) # RIGHT
        Q15(conn) # RIGHT

    closeConnection(conn, database)


if __name__ == "__main__":
    main()