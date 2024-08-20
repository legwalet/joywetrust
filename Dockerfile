# Use the official WordPress image as the base image
FROM wordpress:latest

# Install necessary packages
RUN apt-get update -y && apt-get install -y \
    wget \
    unzip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Install and configure Apache
RUN apt-get update -y && apt-get install -y \
    apache2 \
    apache2-utils \
    && rm -rf /var/lib/apt/lists/*

# Enable necessary Apache modules
RUN a2enmod rewrite

# Copy custom Apache configuration for HTTP
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Copy WordPress configuration file
COPY wp-config.php /var/www/html/wp-config.php

# Set file permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["sh", "-c", "service apache2 start && tail -F /var/log/apache2/access.log /var/log/apache2/error.log"]
