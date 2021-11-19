#!/bin/bash
sudo  ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
composer install --ignore-platform-reqs
composer update --ignore-platform-reqs