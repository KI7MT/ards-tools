""" Simple wrapper script to call all pgsql files"""
import os
import subprocess

# TODO: consolitation sub functions into one

# this must be first
def init_db():
    """ use subprocess to call adif.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U postgres -f initdb.pgsql", shell=True)
    os.chdir('../python')

# must be second
def init_ards():
    """ use subprocess to call ards.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f ards.pgsql", shell=True)
    os.chdir('../python')

def init_adif():
    """ use subprocess to call adif.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f adif.pgsql", shell=True)
    os.chdir('../python')

def init_eqsl():
    """ use subprocess to call eqsl.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f eqsl.pgsql", shell=True)
    os.chdir('../python')

def init_fcc():
    """ use subprocess to call fcc.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f fcc.pgsql", shell=True)
    os.chdir('../python')

if __name__ == '__main__':
    init_db()
    init_ards()
    init_adif()
    init_eqsl()
    init_fcc()

