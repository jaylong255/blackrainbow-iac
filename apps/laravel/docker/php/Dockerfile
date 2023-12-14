# Set host user and group id for all stages
ARG HOST_USER_UID=1001
ARG HOST_USER_GID=1001

FROM composer:2.0.9 AS vendor

FROM php:8.0.2-cli AS cli

ARG HOST_USER_UID
ARG HOST_USER_GID

# Add the user that will be expected, sharing a user and group id with the host
RUN addgroup --gid ${HOST_USER_GID} nginx
RUN adduser --system --no-create-home --uid $HOST_USER_UID --ingroup nginx webuser

# Copy the application files
COPY --chown=webuser:nginx ./. /app/

# Copy composer from the composer image
COPY --from=vendor /usr/bin/composer /usr/bin/composer

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
