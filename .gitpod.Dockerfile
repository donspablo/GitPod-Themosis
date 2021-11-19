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

#Install composer
RUN sudo php -r "readfile('http://getcomposer.org/installer');" | sudo php -- --install-dir=/usr/bin/ --filename=composer \
    && sudo rm -rf /var/lib/apt/lists/*
