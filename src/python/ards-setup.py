import datetime
import sys

from builtins import input
from ards_common import clear_screen
from ards_common import pause
from ards_dbutils import create_database
from ards_dbutils import full_update
from ards_dbutils import schema_info
from ards_dbutils import db_schema_size
from ards_dbutils import db_version

DATE_TIME = datetime.date.today()

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
            create_database()
            pause()
            main()
        elif selection == '2':  # search all archives for call
            full_update()
            pause()
            main()
        elif selection == '3':  # update current month from WSPRnet
            clear_screen()
            schema_info()
            print("")    
            pause()
            main()
        elif selection == '4':  # update current month from WSPRnet
            clear_screen()
            db_schema_size()
            pause()
            main()
        elif selection == '5':  # search current month for a call
            clear_screen()
            db_version()
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