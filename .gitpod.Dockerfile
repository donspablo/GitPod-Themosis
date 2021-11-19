FROM gitpod/workspace-mysql
USER gitpod

RUN sudo apt-get update && \
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
mbstring \
curl \
json \
pdo_mysql \
zip \
opcache \
&& sudo apt-get clean \
&& sudo curl --version \
&& sudo RUN sudo apt upgrade -y \
&& sudo add-apt-repository ppa:ondrej/php \
&& sudo apt-get update \
&& sudo apt-get install php7.1 \
&& sudo apt-get install php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-zip php7.1-fpm php7.1-intl php7.1-simplexml \
&& sudo a2dismod php8.0 \
&& sudo a2enmod php7.1 \
&& sudo service apache2 restart \
&& sudo update-alternatives --set php /usr/bin/php7.1 \
&& sudo update-alternatives --set phar /usr/bin/phar7.1 \
&& sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.1 \
&& sudo update-alternatives --set phpize /usr/bin/phpize7.1 \
&& sudo update-alternatives --set php-config /usr/bin/php-config7.1 \
&& sudo cp .env.sample .env \
&& sudo ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1 \
&& sudo mysql -u root -e "create database homestead" \
&& sudo sed -i "s|APP_URL=|APP_URL=${GITPOD_WORKSPACE_URL}|g" .env \
&& sudo sed -i "s|APP_URL=https://|APP_URL=https://3306-|g" .env \
&& composer install --ignore-platform-reqs \
&& composer update --ignore-platform-reqs \
&& sudo php vendor/bin/homestead make \
&& sudo vagrant box update \
&& sudo apt-get -y autoremove && sudo apt-get clean \
&& sudo a2ensite default \
&& sudo a2ensite default-ssl \
&& sudo apt-get install \
&& pecl install xdebug \
&& sudo systemctl enable zip \
&& sudo systemctl start zip \
&& systemctl enable xdebug \
&& sudo systemctl start xdebug \
&& sudo php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
&& rm -rf /var/lib/apt/lists/*

COPY scripts/.gitpod-init.sh /
RUN sudo chmod +x /setup.sh
CMD ["/setup.sh"]
CMD ["/bin/rm", "-f", "/var/run/apache2/apache2.pid"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
