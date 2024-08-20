# Use the official WordPress image as a base
FROM wordpress:latest

# Install required packages
RUN apt-get update -y && apt-get install -y \
    wget \
    unzip \
    mysql-server \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Download and install WordPress plugins
RUN wget -O /tmp/wordpress-seo.zip https://downloads.wordpress.org/plugin/wordpress-seo.latest-stable.zip \
    && unzip /tmp/wordpress-seo.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/wordpress-seo.zip

RUN wget -O /tmp/contact-form-7.zip https://downloads.wordpress.org/plugin/contact-form-7.latest-stable.zip \
    && unzip /tmp/contact-form-7.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/contact-form-7.zip

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html/wp-content/plugins

# Add supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80 3306

# Initialize the database and start services
RUN service mysql start && \
    mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;" && \
    mysql -e "CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';" && \
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';" && \
    mysql -e "FLUSH PRIVILEGES;"

# Start supervisord to manage services
CMD ["/usr/bin/supervisord"]
