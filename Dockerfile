FROM php:8-alpine

ARG APP_USER_UID=1000
ARG APP_USER_GID=1000
ARG APP_USER_NAME=appuser
ENV PHP_CLI_SERVER_WORKERS=2

# Install required PHP extensions (SQLite3, JSON1 (both already in image), ctype, opcache, session)
RUN docker-php-ext-install -j "$(nproc)" ctype opcache session; \
    mkdir -p /var/www/server/data
WORKDIR /var/www/
COPY server /var/www/server/

VOLUME ["/var/www/server/data"]

EXPOSE 8080

# Create and switch to a non-root user for security
RUN addgroup -S -g ${APP_USER_GID} ${APP_USER_NAME} && \
    adduser -S -u ${APP_USER_UID} -G ${APP_USER_NAME} -D ${APP_USER_NAME} && \
    chown -R ${APP_USER_NAME}:${APP_USER_NAME} /var/www/server/data

USER appuser

HEALTHCHECK CMD wget --no-verbose --tries=1 --output-document=/dev/null http://0.0.0.0:8080/ &> /dev/null || exit 1

# Run the php dev server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "server", "server/index.php"]
