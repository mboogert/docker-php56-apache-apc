FROM php:5.6-apache
MAINTAINER Marcel Boogert <marcel@mtdb.nl>

RUN \
    apt-get update && \
    apt-get install libz-dev -y && \
    apt-get install libjpeg-dev -y && \
    apt-get install libpng-dev -y && \
    apt-get install libpng12-dev -y && \
    apt-get install libfreetype6-dev -y && \
    apt-get install libjpeg62-turbo-dev -y && \
    apt-get install libmcrypt-dev -y && \
    apt-get install libicu-dev -y && \
    apt-get install php5-gd -y && \
    apt-get install php5-xcache -y && \
    apt-get install php-apc -y && \
    apt-get install mcrypt -y && \
    apt-get install zip -y && \
    apt-get install ssmtp -y && \
    apt-get clean all

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install \
    zip \
    pdo \
    pdo_mysql \
    mcrypt \
    intl \
    bcmath \
    mbstring

RUN \
    a2enmod rewrite && \
    a2enmod expires && \
    a2enmod headers
