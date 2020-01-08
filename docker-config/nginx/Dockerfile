FROM nginx:1.15

COPY ./docker-config/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --chown=www-data:www-data ./craft/web /var/www/html/web