#!/bin/bash
sudo  php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
sudo  ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
composer install --ignore-platform-reqs
composer update --ignore-platform-reqs