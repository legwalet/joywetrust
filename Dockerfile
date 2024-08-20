# Use the official WordPress image as a base
FROM wordpress:latest

# Install dependencies and required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget \
    unzip \
    gnupg \
    supervisor \
    mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Configure MariaDB
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
RUN chmod 777 /var/run/mysqld
RUN sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize MariaDB (create the database and user)
RUN service mysql start && \
    mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;" && \
    mysql -e "CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';" && \
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';" && \
    mysql -e "FLUSH PRIVILEGES;"

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

# Configure Apache for WordPress
RUN echo '<Directory /var/www/html/>' > /etc/apache2/conf-available/wordpress.conf && \
    echo '    Options Indexes FollowSymLinks' >> /etc/apache2/conf-available/wordpress.conf && \
    echo '    AllowOverride All' >> /etc/apache2/conf-available/wordpress.conf && \
    echo '    Require all granted' >> /etc/apache2/conf-available/wordpress.conf && \
    echo '</Directory>' >> /etc/apache2/conf-available/wordpress.conf && \
    a2enconf wordpress

# Disable unnecessary modules
RUN a2dismod -f autoindex  # Use -f to force

# Add supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose HTTP port
EXPOSE 80

# Start supervisord to run both MariaDB and Apache
CMD ["/usr/bin/supervisord"]
