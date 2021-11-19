FROM gitpod/workspace-mysql
USER gitpod
RUN sudo apt-get update -y
RUN sudo apt-get install -y parallel
RUN sudo parallel apt-get install -y apt-utils
RUN sudo parallel apt-get update 
RUN sudo parallel apt-get install -y git libzip-dev libmemcached-dev libz-dev curl libcurl4-gnutls-dev libjpeg-dev libssl-dev libmcrypt-dev curl   zip
RUN sudo parallel apt-get clean
RUN sudo parallel curl --version
RUN sudo parallel apt upgrade -y
RUN sudo parallel add-apt-repository ppa:ondrej/php
RUN sudo parallel apt-get update
RUN sudo parallel apt-get install php7.1
RUN sudo parallel apt-get install php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-zip php7.1-fpm php7.1-intl php7.1-simplexml
RUN sudo parallel a2dismod php8.0
RUN sudo parallel a2enmod php7.1
RUN sudo parallel service apache2 restart
RUN sudo parallel update-alternatives --set php /usr/bin/php7.1
RUN sudo parallel update-alternatives --set phar /usr/bin/phar7.1
RUN sudo parallel update-alternatives --set phar.phar /usr/bin/phar.phar7.1
RUN sudo parallel update-alternatives --set phpize /usr/bin/phpize7.1
RUN sudo parallel update-alternatives --set php-config /usr/bin/php-config7.1
RUN sudo parallel cp .env.sample .env
RUN sudo parallel mysql -u root -e "create database homestead"
RUN sudo parallel sed -i "s|APP_URL=|APP_URL=${GITPOD_WORKSPACE_URL}|g" .env
RUN sudo parallel sed -i "s|APP_URL=https://|APP_URL=https://3306-|g" .env
RUN sudo parallel php vendor/bin/homestead make
RUN sudo parallel vagrant box update
RUN sudo parallel apt-get -y autoremove
RUN sudo parallel apt-get clean
RUN sudo parallel a2ensite default
RUN sudo parallel a2ensite default-ssl
RUN sudo parallel apt-get install
RUN sudo parallel systemctl enable zip
RUN sudo parallel systemctl start zip

COPY scripts/.gitpod-init.sh /
RUN sudo chmod +x /gitpod-init.sh
CMD ["/setup.sh"]
CMD ["/bin/rm", "-f", "/var/run/apache2/apache2.pid"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
