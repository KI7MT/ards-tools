import datetime
import sys

from builtins import input

from common import clear_screen
from common import pause
from db_utils import init_database
from db_utils import full_update
from db_utils import schema_info
from db_utils import db_schema_size
from db_utils import db_version

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
               
        if selection == '1':  # Init the database
            clear_screen()
            init_database()
            pause()
            main()
        elif selection == '2':  # Performs full update
            full_update()
            pause()
            main()
        elif selection == '3':  # print schema install info
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
            print("\nUnknown selection ({selection})\n".format(
                                                            selection=selection)
                                                            )
            pause()
            main()

if __name__ == "__main__":
    main()