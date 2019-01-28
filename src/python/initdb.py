""" Simple wrapper script to call all pgsql files"""
import os
import subprocess
import sys

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

from config import config
from configparser import ConfigParser

# the database config file
_inifile='database.ini'

# setup the parser
parser = ConfigParser()


# database Role / User
def get_dbuser(section):
    parser.read(_inifile)
    return parser.get(section, 'user')

# db user passwd
def get_dbuser_pw(section):
    parser.read(_inifile)
    return parser.get(section, 'password')

# database name
def get_dbname(section):
    parser.read(_inifile)
    return parser.get(section, 'database')


# section onf ini to parse
def set_pg_access(section):
    os.environ["PGUSER"] = get_dbuser(section)
    os.environ["PGPASSWORD"] = get_dbuser_pw(section)    


# must be second
def init_ards():
    """ use subprocess to call ards.pgsql"""
    set_pg_access('ards')
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f ards.pgsql", shell=True)
    os.chdir('../python')

def init_adif():
    """ use subprocess to call adif.pgsql"""
    set_pg_access('ards')
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f adif.pgsql", shell=True)
    os.chdir('../python')

def init_eqsl():
    """ use subprocess to call eqsl.pgsql"""
    set_pg_access('ards')
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f eqsl.pgsql", shell=True)
    os.chdir('../python')

def init_fcc():
    """ use subprocess to call fcc.pgsql"""
    set_pg_access('ards')
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f fcc.pgsql", shell=True)
    os.chdir('../python')

# Crop DB and User if exists and re-create
def create_database():
    conn = None
    try:
        # Get the database user and pw from _inifile
        print("*" * 70)
        print("Initializing Database")
        dbuser = get_dbuser('ards')
        dbuser_pw = get_dbuser_pw('ards')
        dbname = get_dbname('ards')

        # read connection parameters and create cursor
        params = config(_inifile,'postgres')
        conn = psycopg2.connect(**params)

        # set isolation ot auto on the connection due to block error potential
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT) 
        cur = conn.cursor()
        
        # Terminate any users
        print("  * Terminating Connections")
        cur.execute("SELECT pg_terminate_backend (pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '%s'" % dbuser)

        # Drop the database is exists
        print("  * Drop DB")
        cur.execute("DROP DATABASE IF EXISTS %s" % dbuser)

        # Drop user if exists
        print("  * Drop User")
        cur.execute("DROP USER IF EXISTS %s" % dbuser)

        # Create the new user "ards"
        print("  * Create Role: ( %s ) with Password: ( %s ) " % (dbuser,dbuser_pw))
        cur.execute("CREATE USER %s WITH LOGIN SUPERUSER CREATEDB CREATEROLE INHERIT REPLICATION CONNECTION LIMIT -1 PASSWORD '%s'" % (dbuser,dbuser_pw))
      
        # add comment on user
        print("  * Add Comment For Role: ( %s )" % dbuser)
        cur.execute("COMMENT ON ROLE %s IS 'Role for ARDS Tools'" % dbuser)

        # Create the ards database
        print("  * Create Database: ( %s )" % dbname)
        cur.execute("CREATE DATABASE %s WITH OWNER = %s ENCODING = 'UTF8' CONNECTION LIMIT = -1" % (dbname,dbuser))
        
        # Comments on new database
        print("  * Comment on Database: ( %s )" % dbname)
        cur.execute("COMMENT ON DATABASE %s IS 'Databases for ARDS Tools'" % dbname)

        # Grant permissions to dbuser
        print("  * Grant permissions on Database: ( %s ) for Role: ( % s )" % (dbname,dbuser))
        cur.execute("GRANT ALL ON DATABASE %s TO %s" % (dbname,dbuser))

        # close PostgreSQL connection
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        sys.exit(1)
    finally:
        if conn is not None:
            conn.close()
            print("Finished, connection closed.")
            print("*" * 70)

if __name__ == '__main__':
    create_database() # this is always first
    #init_ards() # this should always follow database creation
    #init_adif()
    #init_eqsl()
    #init_fcc()