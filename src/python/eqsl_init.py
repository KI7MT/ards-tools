""" Simple wrapper script to call eqsl.pgsql"""
import os
import subprocess

def init_eqsl():
    """ use subprocess to call eqsl.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f eqsl.pgsql", shell=True)
    os.chdir('../python')

if __name__ == '__main__':
    init_eqsl()
