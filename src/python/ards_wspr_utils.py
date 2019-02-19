import os
import sys
import time
import psycopg2
from ards_config import config

# TODO: Add argparse arg to provide the file name to import

DIR_PATH = "D:\WSPR-ANA\csvd"
FILE = os.path.join(DIR_PATH, 'wsprspots-2008-03.csv')
INIFILE='ards_database.ini'

# For testing, delete data in the ards.raw_csv table
def delete_data():
    conn = None
    try:
        # read connection parameters
        params = config(INIFILE,'ards')
 
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
 
        # create a cursor
        cur = conn.cursor()

        # execute command : use truncate, not delete as it's much faster
        print('Deleting Data from wspr.raw_csv...')
        cur.execute('TRUNCATE TABLE wspr.raw_csv;')
        
        # commit the changes
        conn.commit
         # close PostgreSQL connection
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        sys.exit(1)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')


def add_csv():
    conn = None
    try:
        # read connection parameters
        params = config(INIFILE,'ards')

        # connect to the PostgreSQL server
        conn = psycopg2.connect(**params)

        # create a cursor
        cur = conn.cursor()

        # open and read the CSV file
        print("Start Import of CSV")
        try:
            with open(FILE, 'r') as f:
                cur = conn.cursor()
                cur.copy_from(f, 'wspr.raw_csv', sep=',')
        except IOError as error:
            print(error)
        finally:
            cur.close()
            conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        sys.exit(1)
    finally:
        if conn is not None:
            conn.close()

# get file line count: this is slow, it would be better to use wc -l
def line_count():
    return len(FILE.readlines())


if __name__ =='__main__':
    start = time.time()
    add_csv()
    delete_data() # delete raw csv data after processing
    print("\nTime ..: {:.2f} sec\n".format(time.time() - start))

