#!/bin/bash

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/bin --filename=composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
cd /workspace/themosis
composer composer update
cp .env.sample .env
mysql -u root -e "create database homestead"
sudo  sed -i "s|APP_URL=|APP_URL=${GITPOD_WORKSPACE_URL}|g" .env
sudo  sed -i "s|APP_URL=https://|APP_URL=https://3306-|g" .env
sudo  php vendor/bin/homestead make
sudo  vagrant box update
sudo  ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
composer install --ignore-platform-reqs
composer update --ignore-platform-reqs