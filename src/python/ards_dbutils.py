import os

import psycopg2
from ards_config import config

from configparser import ConfigParser

# Note
_inifile='ards_database.ini'
_section='postgres'

# setup the parser
parser = ConfigParser()

def get_dbuser(section):
    """Returns database user name from ini file"""
    parser.read(_inifile)
    return parser.get(section, 'user')


def get_dbuser_pw(section):
    """Returns database user password from database ini file"""
    parser.read(_inifile)
    return parser.get(section, 'password')


def get_dbname(section):
    """Returns database name from database ini file"""
    parser.read(_inifile)
    return parser.get(section, 'database')


def set_pg_access(section):
    os.environ["PGUSER"] = get_dbuser(section)
    os.environ["PGPASSWORD"] = get_dbuser_pw(section)  


def schema_info(_inifile,_section):
    """Connect to the PostgreSQL database server"""
    conn = None
    try:
        # read connection parameters and create cursor, this one should be ARDS
        # Not Postgres via _section
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
        cur.execute('SELECT version()')
 
        # display the PostgreSQL database server version
        db_version = cur.fetchone()

        # Print Version information
        print("* Database version : ", str(db_version))
        #print(str(db_version))
       
     # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('* Database connection closed.')

if __name__ =='__main__':
    db_version(_inifile,_section)