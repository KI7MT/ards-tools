import os
import sys
import csv
import datetime
from time import gmtime
from builtins import input

import ards_initdb as initdb
import ards_update_schema as update_schema
import ards_schema_info as schema_info
import ards_version_check as version_check

from ards_version_check import _inifile
from ards_version_check import _section

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
    input("\nPress [ ENTER ] to continue...")


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
    print(" ARDS Tools Main Menu")
    print(45 * "-")
    print("\n DATABASE FUNCTIONS")    
    print("   1. Initial PostgreSQL Database")
    print("   2. Update Schema Data")
    print("   3. Print Schema Information")
    print("   4. Database Version Check")
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
            update_schema.init_ards() # Always first after database creation
            update_schema.init_adif()
            update_schema.init_eqsl()
            update_schema.init_fcc()
            update_schema.init_utils()
            update_schema.init_wspr()
            print("")
            update_schema.schema_info()
            print("")
            update_schema.db_size_info()
            pause()
            main()
        elif selection == '3':  # update current month from WSPRnet
            clear_screen()
            schema_info.schema_info()
            pause()
            main()
        elif selection == '4':  # search current month for a call
            clear_screen()
            version_check.db_version(_inifile,_section)
            pause()
            main()
        elif selection == '9': # Exit the menu
            sys.exit(0)
        else:
            print("\nUnknown selection ( {selection} )".format(
                                                            selection=selection)
                                                            )
            pause()
            main()

if __name__ == "__main__":
    main()