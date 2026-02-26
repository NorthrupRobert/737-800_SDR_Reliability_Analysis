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