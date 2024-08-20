#!/bin/bash

# Start MariaDB
service mysql start

# Check if the database needs to be initialized
if ! mysql -e "USE wordpress;" 2>/dev/null; then
    echo "Database not found. Initializing..."
    mysql -e "CREATE DATABASE wordpress;"
    mysql -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';"
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
else
    echo "Database already initialized."
fi

# Start Apache
apache2ctl -D FOREGROUND
