# Use the official WordPress image as a base
FROM wordpress:latest

# Install required packages and MySQL server
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    mysql-server \
    supervisor

# Configure MySQL
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
RUN chmod 777 /var/run/mysqld
RUN sed -i 's/^bind-address/#bind-address/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Copy custom wp-config.php into the container
COPY wp-config.php /var/www/html/wp-config.php

# Download and install WordPress plugins
RUN wget -O /tmp/wordpress-seo.zip https://downloads.wordpress.org/plugin/wordpress-seo.latest-stable.zip \
    && unzip /tmp/wordpress-seo.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/wordpress-seo.zip

RUN wget -O /tmp/contact-form-7.zip https://downloads.wordpress.org/plugin/contact-form-7.latest-stable.zip \
    && unzip /tmp/contact-form-7.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/contact-form-7.zip

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html
RUN find /var/www/html -type d -exec chmod 755 {} \;
RUN find /var/www/html -type f -exec chmod 644 {} \;

# Configure Apache to avoid server name warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80
EXPOSE 80

# Start supervisord to run both MySQL and Apache
CMD ["/usr/bin/supervisord"]
