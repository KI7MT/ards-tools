import psycopg2
from config import config

_inifile='database.ini'
_section='postgres'

def db_version(_inifile,_section):
    """Connect to the PostgreSQL database server"""
    conn = None
    try:
        # read connection parameters
        params = config(_inifile,_section)
 
        # connect to PostgreSQL
        print("\n* Connecting to the PostgreSQL database")
        conn = psycopg2.connect(**params)
 
        # create a cursor
        cur = conn.cursor()
        
        # execute a statement
        print("* PostgreSQL database version: \n")
        cur.execute('SELECT version()')
 
        # display the PostgreSQL database server version
        db_version = cur.fetchone()
        print(str(db_version))
       
     # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('\n* Database connection closed.')

if __name__ =='__main__':
    db_version(_inifile,_section)