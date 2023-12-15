# Set host user and group id for all stages
ARG HOST_USER_UID=1001
ARG HOST_USER_GID=1001

FROM composer:2.0.9 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN /usr/bin/composer install --no-interaction --no-dev --no-scripts --no-progress --prefer-dist --optimize-autoloader


FROM php:8.0.2-cli AS cli

# Retrieve the host user and group id
ARG HOST_USER_UID
ARG HOST_USER_GID

# Add the user that will be expected, sharing a user and group id with the host
RUN addgroup --gid ${HOST_USER_GID} nginx
RUN adduser --system --no-create-home --uid $HOST_USER_UID --ingroup nginx webuser

# Copy the application files
COPY --chown=webuser:nginx ./. /app/

# Copy the vendor folder from the composer image
COPY --chown=webuser:nginx --from=vendor /app/vendor /app/vendor

# # Copy composer from the composer image
# COPY --from=vendor /usr/bin/composer /usr/bin/composer

# Install the required dependencies for composer and laravel
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip

RUN docker-php-ext-install zip \
    pdo \
    pdo_mysql \
    bcmath \
    sockets \
    pcntl

COPY ./docker/php/php.ini /usr/local/etc/php/
RUN pear config-set php_ini /usr/local/etc/php/php.ini

WORKDIR /app

FROM php:8.0.2-fpm AS fpm

ARG HOST_USER_UID
ARG HOST_USER_GID

# Add the user that will be expected, sharing a user and group id with the host
RUN addgroup --gid ${HOST_USER_GID} nginx
RUN adduser --system --no-create-home --uid $HOST_USER_UID --ingroup nginx webuser

# Copy the application files
COPY --chown=webuser:nginx ./. /app/

# Copy the vendor folder from the composer image
COPY --chown=webuser:nginx --from=vendor /app/vendor /app/vendor

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib\
    deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib\
    deb http://mirrors.aliyun.com/debian-security buster/updates main\
    deb-src http://mirrors.aliyun.com/debian-security buster/updates main\
    deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\
    deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\
    deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib\
    deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" >  /etc/apt/sources.list\
    && apt-get update\ 
    && apt-get install -y git\
    && install-php-extensions gd pdo_mysql zip

COPY ./docker/php/php.ini /usr/local/etc/php/php.ini
COPY ./docker/php/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN pear config-set php_ini /usr/local/etc/php/php.ini

RUN find . -type f -exec chmod 644 {} \; && \
    find . -type d -exec chmod 755 {} \; && \
    chown -R webuser:nginx /app

RUN chgrp -R nginx /app/storage /app/bootstrap/cache && \
    chmod -R ug+rwx /app/storage /app/bootstrap/cache

CMD ["/usr/local/bin/docker-php-entrypoint","php-fpm","-F"]