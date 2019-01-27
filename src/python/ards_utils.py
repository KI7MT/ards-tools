""" Simple wrapper script to call ards.pgsql"""
import subprocess

def init_ards():
    """ use subprocess to call ards.pgsql"""
    subprocess.call("psql -v ON_ERROR_STOP=1 -U postgres -d postgres -f resources/ards.pgsql", shell=True)

if __name__ == '__main__':
    init_ards()
