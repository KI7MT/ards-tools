import os
import subprocess
import sys
import psycopg2

from configparser import ConfigParser
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from config import config
from common import clear_screen

# Globals - this should really be in ards_config
_inifile='database.ini'
_section='postgres'
_ards_section='ards'

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
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -c \"SELECT * FROM utils.view_schema_size\"", check=True, shell=True)
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

def db_version():
    """Connect to the PostgreSQL database server"""
    conn = None
    try:
        # read connection parameters
        params = config(_inifile,_ards_section)
 
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

def init_adif_pas():
    """Use subprocess to call adif-pas.pgsql"""
    try:
        set_pg_access('ards')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -f adif-pas.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')

def init_adif_sas():
    """Use subprocess to call adif-sas.pgsql"""
    try:
        set_pg_access('ards')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -f adif-sas.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')

def init_eqsl():
    """Use subprocess to call eqsl.pgsql"""
    try:
        set_pg_access('ards')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -f eqsl.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')

def init_fcc():
    """Use subprocess to call fcc.pgsql"""
    try:
        set_pg_access('ards')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -f fcc.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')

def init_utils():
    """Use subprocess to call utils.pgsql"""
    try:
        set_pg_access('ards')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -f utils.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')

def init_wspr():
    """Use subprocess to call wspr.pgsql"""
    try:
        set_pg_access('ards')
        os.chdir('../pgsql')
        subprocess.run("psql -v ON_ERROR_STOP=1 -U ards -d ards -f wspr.pgsql", check=True, shell=True)
    except subprocess.CalledProcessError as error:
        print(error)
        os.chdir('../python')
        sys.exit(1)
    finally:
        os.chdir('../python')

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

def full_update():
    clear_screen()
    init_ards() # Always first after database creation
    init_adif()
    init_adif_pas()
    init_adif_sas()
    init_eqsl()
    init_fcc()
    init_utils()
    init_wspr()
    schema_info()
    print("")
    db_schema_size()

if __name__ =='__main__':
    db_version()