AUTH_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
SECURE_AUTH_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
LOGGED_IN_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
NONCE_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
AUTH_SALT=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
SECURE_AUTH_SALT=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
LOGGED_IN_SALT=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
NONCE_SALT=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
rm -rf /var/www/html/index.php
cd /var/www
curl https://wordpress.org/latest.tar.gz | tar -xvzf -
shopt -s dotglob nullglob
mv /var/www/wordpress/* /var/www/html/
rm -rf /var/www/wordpress
printf "<?php \
define('DB_NAME', '%MYSQL_DATABASE%');\n\
define('DB_USER', '%MYSQL_USER%');\n\
define('DB_PASSWORD', '%MYSQL_PASSWORD%');\n\
define('DB_HOST', '%MYSQL_CONTAINER_NAME%:3306');\n\
define('DB_CHARSET', 'utf8');\n\
define('DB_COLLATE', '');\n\
\n\
define('AUTH_KEY',         '$AUTH_KEY');\n\
define('SECURE_AUTH_KEY',  '$SECURE_AUTH_KEY');\n\
define('LOGGED_IN_KEY',    '$LOGGED_IN_KEY');\n\
define('NONCE_KEY',        '$NONCE_KEY');\n\
define('AUTH_SALT',        '$AUTH_SALT');\n\
define('SECURE_AUTH_SALT', '$SECURE_AUTH_SALT');\n\
define('LOGGED_IN_SALT',   '$LOGGED_IN_SALT');\n\
define('NONCE_SALT',       '$NONCE_SALT');\n\
\n\
\$table_prefix  = 'wp_';\n\
define('WPLANG', '');\n\
define('WP_DEBUG', false);\n\
\n\
if ( !defined('ABSPATH') )\n\
  define('ABSPATH', dirname(__FILE__) . '/');\n\
\n\
require_once(ABSPATH . 'wp-settings.php');\n\
?>" > /var/www/html/wp-config.php
