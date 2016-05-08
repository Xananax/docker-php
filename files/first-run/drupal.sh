VERSION=8.1.1
rm -rf /var/www/html/index.php
cd /var/www/html
curl "https://ftp.drupal.org/files/projects/drupal-$VERSION.tar.gz" | tar --strip-components=1 -xvzf -
rm "/var/www/drupal-$VERSION.tar.gz"