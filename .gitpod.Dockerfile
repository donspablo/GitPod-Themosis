FROM gitpod/workspace-mysql
USER gitpod

RUN sudo  apt-get update && \
RUN sudo  apt-get install -y \
git \
libzip-dev \
libmemcached-dev \
libz-dev \
curl \
libcurl4-gnutls-dev \
libjpeg-dev \
libssl-dev \
libmcrypt-dev \
&& RUN sudo  apt-get clean \
&& RUN sudo  curl --version
RUN sudo  RUN sudo  apt upgrade -y
RUN sudo  add-apt-repository ppa:ondrej/php
RUN sudo  apt-get update
RUN sudo  apt-get install php7.1
RUN sudo  apt-get install php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring  php7.1-zip php7.1-fpm php7.1-intl php7.1-simplexml
RUN sudo  a2dismod php8.0
RUN sudo  a2enmod php7.1
RUN sudo  service apache2 restart
RUN sudo  update-alternatives --set php /usr/bin/php7.1
RUN sudo  update-alternatives --set phar /usr/bin/phar7.1
RUN sudo  update-alternatives --set phar.phar /usr/bin/phar.phar7.1
RUN sudo  update-alternatives --set phpize /usr/bin/phpize7.1
RUN sudo  update-alternatives --set php-config /usr/bin/php-config7.1
RUN sudo  cp .env.sample .env
RUN sudo  ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
RUN sudo  mysql -u root -e "create database homestead"
RUN sudo  sed -i "s|APP_URL=|APP_URL=${GITPOD_WORKSPACE_URL}|g" .env
RUN sudo  sed -i "s|APP_URL=https://|APP_URL=https://3306-|g" .env
RUN sudo  composer install  --ignore-platform-reqs
RUN sudo  composer update
RUN sudo  php vendor/bin/homestead make
RUN sudo  vagrant box update
RUN sudo  apt-get -y autoremove && RUN sudo  apt-get clean
RUN sudo  a2ensite default
RUN sudo  a2ensite default-ssl
RUN sudo  apt-get install \
        mbstring \
        curl \
        json \
        pdo_mysql \
        zip \
        opcache \
    && pecl install xdebug
RUN sudo  systemctl enable zip
RUN sudo  systemctl start zip
RUN systemctl enable xdebug
RUN sudo  systemctl start xdebug

RUN sudo  php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /var/lib/apt/lists/*

ADD . /var/www/project

EXPOSE 80
EXPOSE 443

COPY scripts/.gitpod-init.sh /
RUN sudo  chmod +x /setup.sh
CMD ["/setup.sh"]

CMD ["/bin/rm", "-f", "/var/run/apache2/apache2.pid"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]