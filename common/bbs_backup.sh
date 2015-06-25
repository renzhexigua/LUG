#!/usr/bin/env bash

# Created on Thu Jun 25 14:30:29 2015
#
# @author: rjx


date=`date +"%Y%m%d%H%M"`
DATELIMIT='+7'
BACKUPDIR='/home/backupdir/data/'
BACKUPSQL=$BACKUPDIR${date}.sql
COMPRESSFILE=$BACKUPDIR${date}.tgz
BAIDUYUNDIR=/bbs/`date +"%Y-%m-%d"`

#Step1. rm old(older than $DATELIMIT days) data.
echo "Removing old data ..."
find $BACKUPDIR -name "201*" -mtime $DATELIMIT -exec rm {} \;

#Step2. backup mysql
echo "Dumping bbs Database ..."
mysqldump -uUserName DatabaseName > $BACKUPSQL

#Step3. backup file
echo "Compressing bbs files ..."
tar -C /var/www/dir/ -cf - subdir1 subdir2 subdir3 | \
   pv -s $(du -csb /var/www/dir/{subdir1,subdir2,subdir3} | grep total | awk '{print $1}') | \
      gzip > $COMPRESSFILE

#Step4. upload BaiduYun
bp(){
   /usr/bin/python2.7 /home/xxxx/pan.baidu.com.py  $@
}

# test login status
bp ls || exit 1
echo "Uploading BaiduYun ..."
bp upload ${BACKUPSQL} ${BAIDUYUNDIR} \
   &&  bp upload ${COMPRESSFILE} ${BAIDUYUNDIR} || exit 1