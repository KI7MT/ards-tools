import os
import sys


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

