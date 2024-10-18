FROM php:8.2-apache

COPY src/ /var/www/html

RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

RUN printf "AddType application/x-httpd-php .html\nAddType application/x-httpd-php .htm\n" >> /etc/apache2/apache2.conf

RUN a2enmod rewrite

RUN chown www-data: -R /var/www/html/

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

CMD apachectl -DFOREGROUND
