FROM gitpod/workspace-mysql
USER gitpod

RUN sudo apt-get update && \
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

RUN sudo php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /var/lib/apt/lists/*
