#!/bin/bash
set -euo pipefail

if ! [ -e /var/www/html/htdocs/index.php ]; then
	# Install Composer		
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar /usr/local/bin/composer
	alias composer='/usr/local/bin/composer'

	# Install Themosis	
	composer create-project themosis/themosis /var/www/html

	# Configure environment settings
	cat > /var/www/html/.env.local <<-'EOF'
		DB_NAME = "wordpress"
		DB_USER = "wordpress"
		DB_PASSWORD = "wordpress"
		DB_HOST = "db:3306"
		WP_HOME = "http://localhost"
		WP_SITEURL = "http://localhost/cms"
	EOF

	cat > /var/www/html/config/environment.php <<-'EOF'
		<?php

		/*----------------------------------------------------*/
		// Define environment type
		/*----------------------------------------------------*/
		return [
		    'local' => '*',
		    'production' => 'INSERT-HOSTNAME'
		];
	EOF

fi

exec "$@"