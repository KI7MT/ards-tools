""" Simple wrapper script to call adif.pgsql"""
import os
import subprocess

def init_adif():
    """ use subprocess to call adif.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U postgres -f initdb.pgsql", shell=True)
    os.chdir('../python')

if __name__ == '__main__':
    init_adif()
