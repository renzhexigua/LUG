#!/bin/sh

date=`date +"%Y%m%d%H%M"`

#Step1. backup mysql
mysqldump -uUserName DatabaseName > /home/dir/${date}.sql

#Step2. backup file
tar -zcf /home/dir/${date}.tgz -C /var/www/dir subdir1 subdir2
