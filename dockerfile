FROM php:8.1-apache

COPY src/ /var/www/html

RUN apt-get update && apt-get install -y msmtp && rm -rf /var/cache/apt/lists

COPY msmtprc /etc/msmtprc

RUN chmod 600 /etc/msmtprc && chown www-data: /etc/msmtprc

RUN mkdir /var/www/html/pictures

RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

RUN printf "AddType application/x-httpd-php .html\nAddType application/x-httpd-php .htm\n" >> /etc/apache2/apache2.conf

RUN a2enmod rewrite

RUN chown www-data: -R /var/www/html/

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

RUN echo "sendmail_path = /usr/bin/msmtp -t" >> /usr/local/etc/php/php.ini-development

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

CMD apachectl -DFOREGROUND