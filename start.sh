#!/bin/bash

# Why? so a volume can be declared
if [ ! -d /webapp ]; then
	mv /build /webapp
fi;

# TODO: check for DBTYPE env 

# Set the database to Sqlite
sed -i "s/'default' => 'mysql'/'default' => 'sqlite'/g" /webapp/app/config/database.php
# Create Sqlite database 
if [ ! -d /webapp/database ]; then
	mkdir /webapp/database 
	touch /webapp/database/production.sqlite 
	cd /webapp
	php artisan october:up
fi;
/etc/init.d/hhvm start
/usr/sbin/nginx



