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
	&& sudo apt-get clean \
	&& sudo curl --version \
    \
RUN sudo sudo apt upgrade -y
RUN sudo sudo apt install python-software-properties -y
RUN sudo sudo add-apt-repository ppa:ondrej/php -y
RUN sudo sudo apt install php7.1 -y
RUN sudo sudo a2dismod php7.1$ a2enmod php7.0
RUN sudo service apache2 restart
RUN sudo update-alternatives --set php /usr/bin/php7.2 -y
RUN sudo service nginx restart
RUN sudo cp .env.sample .env
RUN sudo ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
RUN sudo mysql -u root -e "create database homestead"
RUN sudo sed -i "s|APP_URL=|APP_URL=${GITPOD_WORKSPACE_URL}|g" .env
RUN sudo sed -i "s|APP_URL=https://|APP_URL=https://3306-|g" .env
RUN sudo composer install  --ignore-platform-reqs
RUN sudo composer update
RUN sudo php vendor/bin/homestead make
RUN sudo vagrant box update
RUN sudo apt-get -y autoremove && sudo apt-get clean
RUN sudo a2ensite default
RUN sudo a2ensite default-ssl
RUN sudo apt-get install \
        mbstring \
        curl \
        json \
        pdo_mysql \
        zip \
        opcache \
    && pecl install xdebug
RUN sudo systemctl enable zip
RUN sudo systemctl start zip
RUN systemctl enable xdebug
RUN sudo systemctl start xdebug

RUN sudo php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /var/lib/apt/lists/*

ADD . /var/www/project

EXPOSE 80
EXPOSE 443

COPY scripts/.gitpod-init.sh /
RUN sudo chmod +x /setup.sh
CMD ["/setup.sh"]

CMD ["/bin/rm", "-f", "/var/run/apache2/apache2.pid"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]