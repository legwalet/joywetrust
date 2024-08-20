# Use the official WordPress image as a base
FROM wordpress:latest

# Install required packages and plugins
RUN apt-get update -y && apt-get install -y wget unzip

# Copy custom wp-config.php into the container
COPY wp-config.php /var/www/html/wp-config.php

# Hostname
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Download and install WordPress plugins
RUN wget -O /tmp/wordpress-seo.zip https://downloads.wordpress.org/plugin/wordpress-seo.latest-stable.zip \
    && unzip /tmp/wordpress-seo.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/wordpress-seo.zip

RUN wget -O /tmp/contact-form-7.zip https://downloads.wordpress.org/plugin/contact-form-7.latest-stable.zip \
    && unzip /tmp/contact-form-7.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/contact-form-7.zip

#
RUN chown -R www-data:www-data /var/www/html
RUN find /var/www/html -type d -exec chmod 755 {} \;
RUN find /var/www/html -type f -exec chmod 644 {} \;

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html/wp-content/plugins

# Expose port 443
EXPOSE 443

# Start WordPress
CMD ["apache2-foreground"]
