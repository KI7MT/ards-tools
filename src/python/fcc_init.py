""" Simple wrapper script to call fcc.pgsql"""
import os
import subprocess

def init_fcc():
    """ use subprocess to call fcc.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f fcc.pgsql", shell=True)
    os.chdir('../python')

if __name__ == '__main__':
    init_fcc()
