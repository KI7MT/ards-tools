""" Simple wrapper script to call fcc.pgsql"""
import subprocess

def init_fcc():
    """ use subprocess to call fcc.pgsql"""
    subprocess.call("psql -v ON_ERROR_STOP=1 -U ards -f resources/fcc.pgsql", shell=True)

if __name__ == '__main__':
    init_fcc()
