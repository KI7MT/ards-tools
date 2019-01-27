import os
import sys
import time
import psycopg2
from config import config

DIR_PATH = os.getcwd()
FILE = os.path.join(DIR_PATH,'wspr','wsprspots-2008-03.csv')

def delete_data():
    conn = None
    try:
        # read connection parameters
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
 
        # create a cursor
        cur = conn.cursor()

        # execute command
        print('Deleting Data from wspr.raw_csv...')
        cur.execute('DELETE FROM wspr.raw_csv;')
        
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


def test1():
    conn = None
    try:
        # read connection parameters
        params = config()

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


def line_count():
    return len(FILE.readlines())


if __name__ =='__main__':
    delete_data()
    start = time.time()
    test1()
    print("\nTime ..: {:.2f} sec\n".format(time.time() - start))
