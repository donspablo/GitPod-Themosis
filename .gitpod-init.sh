#!/bin/bash
 sudo cp .env.sample .env
 sudo ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1 
 sudo mysql -u root -e "create database homestead"  
 sudo sed -i "s|APP_URL=|APP_URL=${GITPOD_WORKSPACE_URL}|g" .env 
 sudo sed -i "s|APP_URL=https://|APP_URL=https://3306-|g" .env  
 sudo composer install  --ignore-platform-reqs 
 sudo composer update 
 sudo php vendor/bin/homestead make 
 sudo vagrant box update 

 
 sudo add-apt-repository ppa:ondrej/php
 sudo apt-get update
 sudo apt-get install php7.1
 sudo apt-get install php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring  php7.1-zip php7.1-fpm php7.1-intl php7.1-simplexml php7.1-bcmath php7.1-dev
 sudo a2dismod php8.0
 sudo a2enmod php7.3
 sudo a2enmod php7.1
 sudo service apache2 restart
 sudo service nginx restart
    sudo update-alternatives --set php /usr/bin/php7.1
    sudo update-alternatives --set phar /usr/bin/phar7.1
    sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.1
    sudo update-alternatives --set phpize /usr/bin/phpize7.1
    sudo update-alternatives --set php-config /usr/bin/php-config7.1
    fastcgi_pass unix:/var/run/php/php7.1-fpm.sock;