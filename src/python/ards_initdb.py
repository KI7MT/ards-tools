""" Simple wrapper script to call all pgsql files"""
import os
import sys
import subprocess

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

from configparser import ConfigParser

from ards_config import config
from ards_schema_info import schema_info


# the database config file
_inifile='ards_database.ini'

# setup the config parser
parser = ConfigParser()


def clear_screen():
    """Clear screen based on platform."""
    if sys.platform == 'win32':
        os.system('cls')
    else:
        os.system('clear')


def get_dbuser(section):
    """Returns database user name from ards_database.ini file"""
    parser.read(_inifile)
    return parser.get(section, 'user')


def get_dbuser_pw(section):
    """Returns database user password from database ini file"""
    parser.read(_inifile)
    return parser.get(section, 'password')


def get_dbname(section):
    """Returns database name from ards_database.ini file"""
    parser.read(_inifile)
    return parser.get(section, 'database')


def set_pg_access(section):
    """Section of ards_database.ini to parse """
    os.environ["PGUSER"] = get_dbuser(section)
    os.environ["PGPASSWORD"] = get_dbuser_pw(section)    


def create_database():
    """Initialize the Database and Role"""
    conn = None
    try:
        # Get the database user and password from _inifile
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
        
        # terminate any users
        cur.execute("SELECT pg_terminate_backend (pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '%s'" % dbuser)
        print("  * Terminated connections")

        # drop the database is exists
        cur.execute("DROP DATABASE IF EXISTS %s" % dbuser)
        print("  * Dropped database")

        # drop user if exists
        cur.execute("DROP USER IF EXISTS %s" % dbuser)
        print("  * Dropped user")

        # create the new user "ards"
        cur.execute("CREATE USER %s WITH LOGIN SUPERUSER CREATEDB CREATEROLE INHERIT REPLICATION CONNECTION LIMIT -1 PASSWORD '%s'" % (dbuser,dbuser_pw))
        print("  * Created role: ( %s ) with password: ( %s ) " % (dbuser,dbuser_pw))

        # add comment on user
        cur.execute("COMMENT ON ROLE %s IS 'Role for ARDS Tools'" % dbuser)
        print("  * Added comment for role: ( %s )" % dbuser)

        # create the ards database
        cur.execute("CREATE DATABASE %s WITH OWNER = %s ENCODING = 'UTF8' CONNECTION LIMIT = -1" % (dbname,dbuser))
        print("  * Created database: ( %s )" % dbname)

        # add comments on new database
        cur.execute("COMMENT ON DATABASE %s IS 'Databases for ARDS Tools'" % dbname)
        print("  * Added comment on database: ( %s )" % dbname)

        # grant permissions to dbuser
        cur.execute("GRANT ALL ON DATABASE %s TO %s" % (dbname,dbuser))
        print("  * Granted permissions on database: ( %s ) for role: ( % s )" % (dbname,dbuser))

        # close PostgreSQL connection
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        sys.exit(1)
    finally:
        if conn is not None:
            conn.close()
            print("  * Finished, connection closed.")
            print("*" * 70)
            print("")

if __name__ == '__main__':
    clear_screen()
    create_database() # this is the only method that should be called