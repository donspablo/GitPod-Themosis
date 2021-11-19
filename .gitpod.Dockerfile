FROM gitpod/workspace-mysql
USER gitpod

RUN sudo docker-php-ext-install mysqli
RUN sudo docker-php-ext-install mbstring

RUN sudo apt-get -y autoremove && sudo apt-get clean
RUN sudo apt-get install -y php5-apcu

RUN sudo a2enmod rewrite
RUN sudo a2enmod socache_shmcb || true

RUN sudo rm -Rf /etc/apache2/sites-available/*.conf
COPY apache/default.conf /etc/apache2/sites-available/
COPY apache/default-ssl.conf /etc/apache2/sites-available/

RUN sudo a2ensite default
RUN sudo a2ensite default-ssl

RUN sudo curl -sS https://getcomposer.org/installer | /usr/bin/php
RUN sudo mv composer.phar /usr/local/bin/composer

RUN sudo mkdir -p /var/www/project
RUN sudo chown www-data:www-data -R /var/www/project

ADD . /var/www/project

EXPOSE 80
EXPOSE 443

COPY scripts/setup.sh /
RUN sudo chmod +x /setup.sh
CMD ["/setup.sh"]

CMD ["/bin/rm", "-f", "/var/run/apache2/apache2.pid"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]