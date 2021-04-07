'''
cli.py

Command Line Interface for ROADpersist. 
Allows user to run scripts that manipulate an Azure Environment  
Current scripts: AddUser (powershell)

Author: Shannon McHale 

'''


#!/usr/bin/env python3

import argparse
import subprocess

parser = argparse.ArgumentParser(description='ROADpersist automates small actions in AzureAD that create persistence')
subparser = parser.add_subparsers(dest='command')
addUser = subparser.add_parser('addUser', help='AddUser required flags -Password -DisplayName -NickName -PrincipalName')
test = subparser.add_parser('test')

# AddUser -Password -DisplayName -NickName -PrincipalName 
# Try to take first DisplayName and make it the PrincipalName @ email we pull from database 
# See if we can copy naming conventino of envuronment automatically  

addUser.add_argument('--Password', '-p', type=str, required=True)
addUser.add_argument('--DisplayName','-dn', type=str, required=True)
addUser.add_argument('--PrincipalName', '-pn', type=str, required=True)
addUser.add_argument('--NickName', '-nn', type=str, required=True)

args = parser.parse_args() 

# Parse each flag and check if it is present later. 
# Example:
    # if arg.adduser & arg.Display name & NickName & PrincipalName & Password then run ELSE run error message 

#if args.AddUser and (args.password is None or args.NickName is None args.displayname is None or args.PrincipalName is None):
#    parser.error("--AddUser requires -Password -DisplayName -NickName -PrincipalName.")

if args.command == 'addUser':
   # p = subprocess.Popen(['powershell.exe', './test.ps1', args.Password, args.DisplayName, args.NickName, args.PrincipalName])
    print(args.Password)
    p = subprocess.Popen(['powershell.exe', './adduser1.ps1', args.Password, args.DisplayName, args.NickName, args.PrincipalName])
 #   print("Run Script with args:", args.Password, args.NickName)
    

elif args.command == 'test':
    p = subprocess.Popen(['powershell.exe', './test.ps1 foo'])
    print("other option")