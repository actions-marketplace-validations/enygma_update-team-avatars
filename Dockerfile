# Container image that runs your code
FROM php:7.4-cli

# Install git
RUN apt-get -y update
RUN apt-get -y install git zip unzip libzip-dev && docker-php-ext-install zip

# Copy over Composer so we can use it
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
