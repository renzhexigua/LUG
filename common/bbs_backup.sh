#!/bin/bash

date=`date +"%Y%m%d%H%M"`

#Step1. backup mysql
echo "Dumping bbs Database ..."
mysqldump -uUserName DatabaseName> /home/dir/${date}.sql

#Step2. backup file
echo "Compressing bbs files ..."
tar -C /var/www/dir -cf - subdir1 subdir2 subdir3| \
   pv -s $(du -csb /var/www/dir/{subdir1,subdir2,subdir3} | grep total | awk '{print $1}') | \
      gzip > /home/dir/${date}.tgz
