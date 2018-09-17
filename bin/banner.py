#!/usr/bin/python
import sys, os
import platform
import time
import datetime
import subprocess

class Color(object):
    GREEN = '\033[92m'
    ORANGE = '\033[33m'
    RED = '\033[91m'
    BOLD = '\033[1m'
    END = '\033[0m'

# set variable
TOYBOX_VER = "v0.0.2 Beta"
BANNER = """
████████╗ ██████╗ ██╗   ██╗██████╗  ██████╗ ██╗  ██╗
╚══██╔══╝██╔═████╗╚██╗ ██╔╝██╔══██╗██╔═══██╗╚██╗██╔╝
   ██║   ██║██╔██║ ╚████╔╝ ██████╔╝██║   ██║ ╚███╔╝ 
   ██║   ████╔╝██║  ╚██╔╝  ██╔══██╗██║   ██║ ██╔██╗ 
   ██║   ╚██████╔╝   ██║   ██████╔╝╚██████╔╝██╔╝ ██╗
   ╚═╝    ╚═════╝    ╚═╝   ╚═════╝  ╚═════╝ ╚═╝  ╚═╝
"""

# RUN CTF DOCKER TOOL!!!
print(BANNER)
print('\033[1m\033[34mDocker for CTF toolbox ' + TOYBOX_VER + '\033[0m\n')
print("OS: " + platform.system())
print("Platform: " + platform.platform())
