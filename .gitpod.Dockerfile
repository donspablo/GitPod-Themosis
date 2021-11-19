FROM gitpod/workspace-mysql
USER gitpod
RUN     sudo su - && \
        apt-get update && \
        apt-get install -y \
        git \
        libzip-dev \
        libmemcached-dev \
        libz-dev \
        curl \
        libcurl4-gnutls-dev \
        libjpeg-dev \
        libssl-dev \
        libmcrypt-dev \
	&& apt-get clean \
	&& curl --version

RUN docker-php-ext-install \
        mbstring \
        curl \
        json \
        pdo_mysql \
        zip \
        opcache \
    && pecl install xdebug \
    && docker-php-ext-enable zip \
    && docker-php-ext-enable xdebug

#Install composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /var/lib/apt/lists/*
