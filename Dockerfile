# Use the official WordPress image as a base
FROM wordpress:latest

# Install dependencies and required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget \
    unzip \
    gnupg \
    supervisor \
    openssl && \
    rm -rf /var/lib/apt/lists/*

# Install MySQL server separately
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && \
    rm -rf /var/lib/apt/lists/*

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

# Create a self-signed SSL certificate (for development/testing purposes)
RUN mkdir /etc/apache2/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/apache2/ssl/apache.key \
    -out /etc/apache2/ssl/apache.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=localhost"

# Enable SSL and headers module, and configure Apache
RUN a2enmod ssl
RUN a2enmod headers
RUN a2ensite default-ssl

# Copy Apache SSL configuration
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

# Add supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose both HTTP and HTTPS ports
EXPOSE 80 443

# Start supervisord to run both MySQL and Apache
CMD ["/usr/bin/supervisord"]
