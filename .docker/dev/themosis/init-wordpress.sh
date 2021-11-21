#!/bin/bash
USER_PASS=`openssl rand -base64 8`

cd /var/www/htdocs

if ! $(wp core is-installed --allow-root); then
  echo >&2 "Switching Wordpress on..."
  wp core config --dbname=_MYSQL_DATABASE_ \
                 --dbuser=_MYSQL_USER_ \
                 --dbpass=_MYSQL_PASSWORD_ \
                 --allow-root
  wp core install --url=http://_WP_HOME_/cms/ \
                  --title=Themosis \
                  --admin_user=admin \
                  --admin_password=$USER_PASS \
                  --admin_email=admin@example.com \
                  --allow-root
  echo >&2 "Done!"
  echo >&2 "========================="
  echo >&2 "User: admin"
  echo >&2 "Pass: $USER_PASS"
  echo >&2 "========================="
else
  echo >&2 "Wordpress installed. Carrying on..."
fi

#echo >&2 "Switching default theme on..."
#wp theme activate $WP_THEME --allow-root

cd /