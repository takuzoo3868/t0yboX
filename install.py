#!/usr/bin/python

import os, sys

# set variable
VOLUME = 'volume'
FOLDER = '.t0yboX'
TOYBOX = 't0yboX'
HOME = os.path.expanduser('~')
TOYBOX_DIRECTORY_PATH = HOME + '/' + FOLDER
TOYBOX_PATH = TOYBOX_DIRECTORY_PATH + '/' + TOYBOX

# clone ctf-TOYBOX
os.chdir(HOME)
cmd = 'git clone https://github.com/takuzoo3868/t0yboX/ {}'.format(FOLDER)
os.system(cmd)

# make volume folder
cmd = 'mkdir {0}/{1}'.format(TOYBOX_DIRECTORY_PATH, VOLUME)
os.system(cmd)

# get shell's rc file name
shell = os.environ['SHELL']
if shell == '/bin/bash':
    shellrc_path = HOME + '/.bashrc'
else:
    sys.stderr.write('shell not supported => {}'.format(shell))
    exit()

# set permission
cmd = 'sudo chmod +x {0}'.format(TOYBOX_PATH)
os.system(cmd)

# set alias(command)
f = open(shellrc_path, 'a')
alias = '\nalias t0yboX=\'{0}\''.format(TOYBOX_PATH)
f.write(alias)
f.close()

# restart shell
os.system(shell)
