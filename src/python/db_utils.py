import os
import subprocess
import sys
import psycopg2

from configparser import ConfigParser
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from config import config
from common import clear_screen

# setup the parser
parser = ConfigParser()

# Globals
_inifile='database.ini'
_section='postgres'
_ards_section='ards'


_file = ['adif', 'eqsl', 'fcc', 'jtalerts', 'lotw', 'wspr']

def set_pg_access(section):
    os.environ["PGUSER"] = get_dbuser(section)
    os.environ["PGPASSWORD"] = get_dbuser_pw(section)

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

def get_sqlfile(section):
    """Returns the pgsql file name"""
    parser.read(_inifile)
    return parser.get(section, 'sqlfile')

def get_enabled(section):
    """Returns if section is enabled"""
    parser.read(_inifile)
    return parser.get(section, 'enabled')

def schema_info():
    """Connect to the PostgreSQL database server"""
    conn = None
    try:
        # read connection parameters and create cursor, this one should be ARDS
        # Not Postgres via _section
        params = config(_inifile,_ards_section)
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

def db_schema_size():
    """Use subprocess to call utils.pgsql"""
    try:
        set_pg_access('ards')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -c \"SELECT * FROM ards.view_schema_size\"", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        sys.exit(1)

def db_total_size():
    """Use subprocess to call utils.pgsql"""
    try:
        set_pg_access('ards')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -c \"SELECT * FROM utils.view_db_size\"", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        sys.exit(1)

def db_version(section):
    """Connect to the PostgreSQL database server"""
    conn = None
    try:
        # read connection parameters
        params = config(_inifile,section)
 
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

def init_ards():
    """Use subprocess to call ards.pgsql"""
    try:
        set_pg_access('ards')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -f ards.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')

def init_adif():
    """Use subprocess to call adif.pgsql"""
    try:
        set_pg_access('ards')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -f adif.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')

def init_database():
    """Use subprocess to call initdb.pgsql"""
    try:
        set_pg_access('postgres')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U postgres -f initdb.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')
        print("\nFinishes Generating Databases\n")

def full_update():
    clear_screen()
    init_ards() # this should always go first before any other schemas
    init_adif()
    print("")
    db_schema_size()

if __name__ =='__main__':
    print("Nothing to do for main")