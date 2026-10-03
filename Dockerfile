FROM php:8.3-fpm

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx git unzip libicu-dev libzip-dev \
    && docker-php-ext-install pdo pdo_mysql intl zip opcache \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER=1 APP_ENV=prod

COPY . .

RUN if [ ! -f .env ]; then printf 'APP_ENV=prod\nAPP_DEBUG=0\n' > .env; fi
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts
RUN php bin/console importmap:install --no-interaction || true
RUN php bin/console asset-map:compile --no-interaction || true
RUN mkdir -p var && chown -R www-data:www-data /app

COPY nginx-main.conf /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/conf.d/* /etc/nginx/sites-enabled /etc/nginx/sites-available
COPY nginx.conf /etc/nginx/conf.d/symfony.conf

COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]