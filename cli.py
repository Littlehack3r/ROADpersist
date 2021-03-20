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
subparser = parser.add_subparsers(dest='command')
addUser = subparser.add_parser('addUser', help='AddUser required flags -Password -DisplayName -NickName -PrincipalName')
test = subparser.add_parser('test')

# AddUser -Password -DisplayName -NickName -PrincipalName 
# Try to take first DisplayName and make it the PrincipalName @ email we pull from database 
# See if we can copy naming conventino of envuronment automatically  

addUser.add_argument('--Password', type=str, required=True)
addUser.add_argument('--DisplayName', type=str, required=True)
addUser.add_argument('--PrincipalName', type=str, required=True)
addUser.add_argument('--NickName', type=str, required=True)

args = parser.parse_args() 

# Parse each flag and check if it is present later. 
# Example:
    # if arg.adduser & arg.Display name & NickName & PrincipalName & Password then run ELSE run error message 

#if args.AddUser and (args.password is None or args.NickName is None args.displayname is None or args.PrincipalName is None):
#    parser.error("--AddUser requires -Password -DisplayName -NickName -PrincipalName.")

if args.command == 'addUser':
    print("Run Script with args:", args.Password, args.NickName)

elif args.command == 'test':
    print("other option")