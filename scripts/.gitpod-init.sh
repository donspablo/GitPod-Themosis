#!/bin/bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/bin --filename=composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

sudo  ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
composer install --ignore-platform-reqs
composer update --ignore-platform-reqs