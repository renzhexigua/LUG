#!/bin/sh
# Sometimes the ssh disconnected via various reasons.Those sessions became inact
#ive but the account's status is displayed still online in system.You have to 
#kick them out one by one.This script can help you automatically complete these
#repetitive work.
#
# Correlative command is pkill
#     eg. pkill -t pts/n
#
# Usage:
#     Just run it!
#
# Author: Jesse Ren
# E-mail: renzhexigua@163.com
# Last-modified: 2014/12/12

current_user=$USER
current_tty=${SSH_TTY##/dev/}
process_list=`ps -ef | grep "sshd: $current_user@pts" |                       \
                       grep -v "grep\|$current_tty" | awk '{print $2}'`
for target in $process_list
do
    kill -9 $target
done
