# Docker-php

A docker container for running php stuff.  
Based off the [Official Ubuntu PHP Container](https://hub.docker.com/_/php/)

Build with the "build" script
Run with "run" script.

once the script has run, run `service apache2 start` in it to start apache

The run script automatically:

- deletes the container on exit
- maps the *container's* 80 port to the *host's* 3000 port.
- maps the *host's* "./src" directory to the container's /var/www/html directory (e.g., files get served from ./src)
- maps “./composer/” to composer’s cache


Tools available:

- php 5.6
- composer (available on the $PATH as "composer")
- php-pear
- apache
- node & npm
- wget
- curl
- imagemagick
- gd
- git

PHP Extensions available:

- iconv
- mcrypt
- sqlite (PDO)
- curl
- tidy
- gd
- openSSL

-----

To map the 3000 port to a local 3000 port with nginx:

```nginx
    server {
      listen 3000;
      server_name localhost;
      location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
      }
    }
```

------

to install silverstripe, run in the docker shell:
```sh
composer create-project silverstripe/installer ./ 3.3.1 && \
composer require silverstripe/sqlite3 1.4.*-dev && \
composer require "silverstripe/siteconfig:*"
```
