import psycopg2

from ards_config import config

# the database config file
_inifile='ards_database.ini'

def schema_info():
    """Connect to the PostgreSQL database server"""
    conn = None
    try:
        # read connection parameters and create cursor
        params = config(_inifile,'ards')
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        
        # execute a statement
        print("Database Schema Information\n")
        cur.execute('SELECT * FROM ards.view_schema_info')
        rows = cur.fetchall()
        
        # print the header
        print('-' * 60)
        print('{:<10s}{:>4s}{:>7s}{:>16s}'.format('Schema','Version','Adif','Date-Time'))
        print('-' * 60)

        # print the rows
        for i in range(len(rows)):
            schema = str(rows[i][0])
            version = str(rows[i][1])
            adif = str(rows[i][2])
            datet = str(rows[i][3])
            print('{:<10s}{:>4s}{:>10s}{:>25s}'.format(schema,version,adif,datet))

        # close the cursor      
        cur.close()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

if __name__ == '__main__':
    schema_info()