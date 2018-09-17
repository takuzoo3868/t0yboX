#!/usr/bin/python

import os, sys


# get input
while True:
    i = input('Would you remove all files and folders ?(y/n):')
    if i == 'y' or i == 'Y':
        break
    elif i == 'n' or i == 'N':
        exit()

# set variable
VOLUME = 'volume'
FOLDER = '.t0yboX'
TOYBOX = 't0yboX'
HOME = os.path.expanduser('~')
TOYBOX_DIRECTORY_PATH = HOME + '/' + FOLDER
TOYBOX_PATH = TOYBOX_DIRECTORY_PATH + '/' + TOYBOX

# remove files and folders
cmd = 'sudo rm -rf {0}'.format(TOYBOX_DIRECTORY_PATH)
os.system(cmd)

# get shell's rc file name
shell = os.environ['SHELL']
if shell == '/bin/bash':
    shellrc_path = HOME + '/.bashrc'
else:
    sys.stderr.write('shell not supported => {}'.format(shell))
    exit()

# restart shell
os.system(shell)
