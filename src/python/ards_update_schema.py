"""Simple wrapper script to call all pgsql files"""
import os
import subprocess
import sys

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

from configparser import ConfigParser

from ards_config import config
from ards_schema_info import schema_info


# the database config file
_inifile='ards_database.ini'

# setup the parser
parser = ConfigParser()


def clear_screen():
    """Clear screen based on platform."""
    if sys.platform == 'win32':
        os.system('cls')
    else:
        os.system('clear')


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


# this function must be called first, after database initialization
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

if __name__ == '__main__':
    clear_screen()
    init_ards() # Always first after database creation
    init_adif()
    init_eqsl()
    init_fcc()
    init_utils()
    init_wspr()
    schema_info()
    print("")
    db_schema_size()