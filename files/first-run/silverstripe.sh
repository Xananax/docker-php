rm -rf /var/www/html/index.php
cd /var/www/html
composer create-project silverstripe/installer ./ 3.3.1
composer require silverstripe/sqlite3 1.4.*-dev && \
composer require "silverstripe/siteconfig:*"
composer require undefinedoffset/sortablegridfield
composer require "silverstripe/googlesitemaps"
composer require silverstripe/tagfield dev-master
composer require ajshort/silverstripe-gridfieldextensions dev-master
composer require silverstripe/taxonomy dev-master