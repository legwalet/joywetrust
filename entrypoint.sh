#!/bin/bash

# Start MariaDB
mysqld_safe &
sleep 10  # Wait for MariaDB to initialize

# Initialize MariaDB database if not already set up
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -e "CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Start Apache
apache2ctl -D FOREGROUND
