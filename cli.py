'''
cli.py

Command Line Interface for ROADpersist. 
Allows user to run scripts that manipulate an Azure Environment  
Current scripts: AddUser (powershell)

Author: Shannon McHale 

'''


#!/usr/bin/env python3

import argparse
import sys

parser = argparse.ArgumentParser(description='ROADpersist automates small actions in AzureAD that create persistence')
group = parser.add_mutually_exclusive_group(required=True) # one action at a time

# AddUser -Password -DisplayName -NickName -PrincipalName 
# Try to take first DisplayName and make it the PrincipalName @ email we pull from database 
# See if we can copy naming conventino of envuronment automatically  

group.add_argument('-AddUser', '-au', dest='addUser', action="store_true", help='AddUser required flags -Password -DisplayName -NickName -PrincipalName')


args = parser.parse_args() 

# Parse each flag and check if it is present later. 
# Example:
    # if arg.adduser & arg.Display name & NickName & PrincipalName & Password then run ELSE run error message 

if args.AddUser and (args.password is None or args.NickName is None args.displayname is None or args.PrincipalName is None):
    parser.error("--AddUser requires -Password -DisplayName -NickName -PrincipalName.")