#!/bin/sh
set -e

php bin/console doctrine:migrations:migrate --no-interaction
chown -R www-data:www-data var

php-fpm -D
exec nginx -g 'daemon off;'