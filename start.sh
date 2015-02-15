#!/bin/bash
if [ !-d /webapp ]; then
	mkdir /webapp
fi;
if [ !$(ls -A /webapp) ]; then
	mv -R /build/* /webapp
	rm /build
fi;

# Set the database to Sqlite
sed -i "s/'default' => 'mysql'/'default' => 'sqlite'/g" /webapp/app/config/database.php
# Create Sqlite database 
if [ !-d /webapp/database ]; then
	mkdir /webapp/database 
	touch /webapp/database/production.sqlite 
	php artisan october:up
fi;


