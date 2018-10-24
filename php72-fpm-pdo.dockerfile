FROM php:7.2-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev mysql-client
RUN docker-php-ext-install pdo pdo_mysql

# execute command: docker build -f php72-fpm-pdo.dockerfile -t php:7.2-fpm-pdo .
