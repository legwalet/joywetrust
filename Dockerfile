# Use the official WordPress image as a base
FROM wordpress:latest
# Install required packages and plugins
RUN apt-get update -y && apt-get install -y wget unzip 
RUN apt-get mysql-server -y
# Download and install WordPress plugins
RUN wget -O /tmp/wordpress-seo.zip https://downloads.wordpress.org/plugin/wordpress-seo.latest-stable.zip \
    && unzip /tmp/wordpress-seo.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/wordpress-seo.zip
RUN wget -O /tmp/contact-form-7.zip https://downloads.wordpress.org/plugin/contact-form-7.latest-stable.zip \
    && unzip /tmp/contact-form-7.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/contact-form-7.zip
# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html/wp-content/plugins
# Expose port 80
EXPOSE 80
# Start WordPress
CMD ["apache2-foreground"]

