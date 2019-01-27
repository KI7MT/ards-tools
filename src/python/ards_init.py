""" Simple wrapper script to call ards.pgsql"""
import os
import subprocess

def init_ards():
    """ use subprocess to call ards.pgsql"""
    os.chdir('../pgsql')
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -d ards -f ards.pgsql", shell=True)
    os.chdir('../python')

if __name__ == '__main__':
    init_ards()
