import psycopg2
import pandas as pd

def q_to_df(query):
    db_connection = psycopg2.connect(database='vectra',
                                     host='localhost',
                                     user='robb',
                                     password='thek3yisK#')
    cur = db_connection.cursor()

    # Execute and fetch
    cur.execute(query)
    records = cur.fetchall()

    #build table
    col_names = [desc[0] for desc in cur.description]
    df = pd.DataFrame(data=records, columns=col_names)

    #close
    cur.close()
    db_connection.close()

    return df




# Lets make a simple function to print our queries from the db, using psycopg2 . . .
def vectra_view(my_query):
    # connect to db
    db_connection = psycopg2.connect(dbname = 'vectra',
                                    host='localhost',
                                    user='robb',
                                    password='thek3yisK#')
    cur = db_connection.cursor()

    # return results
    cur.execute(my_query)
    rows = cur.fetchall()
    for row in rows:
        print(row)

    # close
    cur.close()
    db_connection.close()



def vectra_commit(my_query):
    # connect to db
    db_connection = psycopg2.connect(dbname = 'vectra',
                                     host='localhost',
                                     user='robb',
                                     password='thek3yisK#')
    cur = db_connection.cursor()

    # excecute
    cur.execute(my_query)
    db_connection.commit()

    # close
    cur.close()
    db_connection.close()



# Generalized, so should work for any table . . .
def vectra_insert_df(df, table_name, conflict_cols):
    """
    Insert a pandas DataFrame into a PostgreSQL table using psycopg2.
    Handles arbitrary columns and conflict keys.
    """

    # Connect
    conn = psycopg2.connect(
        dbname='vectra',
        host='localhost',
        user='robb',
        password='thek3yisK#'
    )
    cur = conn.cursor()

    # Column list
    cols = list(df.columns)
    col_names = ", ".join(cols)

    # Placeholder for VALUES (%s, %s, %s...)
    placeholders = ", ".join(["%s"] * len(cols))

    # Conflict target
    conflict_target = ", ".join(conflict_cols)

    # Build SET col = EXCLUDED.col for all non-conflict columns
    update_assignments = ", ".join(
        [f"{col} = EXCLUDED.{col}" for col in cols if col not in conflict_cols]
    )

    # Build final SQL
    query = f"""
        INSERT INTO {table_name} ({col_names})
        VALUES %s
        ON CONFLICT ({conflict_target}) DO UPDATE
        SET {update_assignments};
    """

    # Convert DataFrame to list of tuples
    values = [tuple(row) for row in df.to_numpy()]

    # Bulk insert
    execute_values(cur, query, values)

    conn.commit()
    cur.close()
    conn.close()

    print(f"Inserted/updated {len(df)} rows into {table_name}.")
