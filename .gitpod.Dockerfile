FROM gitpod/workspace-mysql
USER gitpod
RUN     sudo apt-get update && \
        sudo apt-get install -y \
        git \
        libzip-dev \
        libmemcached-dev \
        libz-dev \
        curl \
        libcurl4-gnutls-dev \
        libjpeg-dev \
        libssl-dev \
        libmcrypt-dev \
	&& sudo apt-get clean \
	&& curl --version

RUN docker-php-ext-install \
        mbstring \
        curl \
        json \
        pdo_mysql \
        zip \
        opcache \
    && sudo pecl install xdebug \
    && docker-php-ext-enable zip \
    && docker-php-ext-enable xdebug

#Install composer
RUN sudo php -r "readfile('http://getcomposer.org/installer');" | sudo php -- --install-dir=/usr/bin/ --filename=composer \
    && sudo rm -rf /var/lib/apt/lists/*
