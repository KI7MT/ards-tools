import os
import sys
import csv
import datetime

from time import gmtime
from builtins import input

import ards_initdb as initdb
import ards_update as update
import ards_dbutils as dbutils

from ards_dbutils import _inifile
from ards_dbutils import _section

DATE_TIME = datetime.date.today()


#------------------------------------------------------------------ Clean Screen
def clear_screen():
    """Clear Screen Based On Platform Type"""
    if sys.platform == 'win32':
        os.system('cls')
    else:
        os.system('clear')


#---------------------------------------------------------------- Pause function
def pause():
    """Pause Statement"""
    input("Press [ ENTER ] to continue...")


#----------------------------------------------------- Under Development Message
def under_development():
    print("\n" + 45 * '-')
    print(" Under Development")
    print(45 * '-')
    print("\n This feature is currently under development.")
    print("")


#--------------------------------------------------------------------- Main Menu
def main_menu():
    """Prints The Main Menu"""
    cmon = DATE_TIME.strftime("%B")
    print(45 * "-")
    print(" ARDS Tools Setup Main Menu")
    print(45 * "-")
    print("\n   1. Initialize PostgreSQL Database")
    print("   2. Update Schema Data")
    print("   3. Print Schema Information")
    print("   4. Print Schema Disk Usage")
    print("   5. Print Database Version")
    print("   9. Exit")
    print("")

#----------------------------------------------------------- Main Menu Functions
def main():
    """Main Menu Functions"""
    
    clear_screen()

    while True:
        main_menu()
        selection = input("Selection: ")
               
        if selection == '1':  # update all archive files from WSPRnet
            clear_screen()
            initdb.create_database()
            pause()
            main()
        elif selection == '2':  # search all archives for call
            clear_screen()
            update.init_ards() # Always first after database creation
            update.init_adif()
            update.init_eqsl()
            update.init_fcc()
            update.init_utils()
            update.init_wspr()
            print("")
            dbutils.schema_info(_inifile,_section)
            print("")
            update.db_schema_size()
            pause()
            main()
        elif selection == '3':  # update current month from WSPRnet
            clear_screen()
            dbutils.schema_info(_inifile,_section)
            print("")    
            pause()
            main()
        elif selection == '4':  # update current month from WSPRnet
            clear_screen()
            update.db_schema_size()
            pause()
            main()
        elif selection == '5':  # search current month for a call
            clear_screen()
            dbutils.db_version(_inifile,_section)
            print('')
            pause()
            main()
        elif selection == '9': # Exit the menu
            now = datetime.datetime.now()
            print("Exiting Setup at : {0} ".format(now))
            sys.exit(0)
        else:
            print("\nUnknown selection ( {selection} )".format(
                                                            selection=selection)
                                                            )
            pause()
            main()

if __name__ == "__main__":
    main()