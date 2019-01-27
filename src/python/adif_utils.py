""" Simple wrapper script to call adif.pgsql"""
import subprocess

def init_adif():
    """ use subprocess to call adif.pgsql"""
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -f resources/adif.pgsql", shell=True)

if __name__ == '__main__':
    init_adif()
