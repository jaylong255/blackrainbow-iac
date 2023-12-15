# Set host user and group id for all stages
ARG HOST_USER_UID=1001
ARG HOST_USER_GID=1001

FROM nginx:alpine

ARG HOST_USER_UID
ARG HOST_USER_GID
ARG UPSTREAM

# RUN apk add --upgrade brotli-libs

# Copy nginx config from files we packaged in
# COPY ./docker/nginx/nginx.conf /etc/nginx/
# COPY ./docker/nginx/default.conf /etc/nginx/conf.d
# COPY ./docker/nginx/${UPSTREAM}.conf /etc/nginx/conf.d
# COPY ./docker/nginx/entrypoint.sh /usr/local/bin/entrypoint.sh

# Add the user that will be expected, sharing a user and group id with the host
RUN adduser --system --no-create-home --uid $HOST_USER_UID --ingroup nginx webuser

# Copy the application files
# WORKDIR /var/www/html/public
# COPY --chown=webuser:nginx ./. /app/

# Copy just the files that we need and leave the surreal stage behind for the push
# WORKDIR /var/www/html/public
# COPY --chown=webuser:nginx ./public/index.php /var/www/html/public/index.php

# RUN echo "test" > /var/www/html/public/index.php && \
#     chown -R webuser:nginx /var/www/html/public
