# Docker-php

A docker container for running php stuff.  
Based off the [Official Ubuntu PHP Container](https://hub.docker.com/_/php/)

Build with the "build" script  
copy the `container` directory wherever you want your files to reside; rename it to whatever
cd into it and run './run'

## Environment Variables:

- `$DB_USER`: default user for mySQL or pgSQL (defaults to `root`)
- `$DB_PASSWORD`: password for the default user (defaults to `password`)
- `$NAME`: name of the container; used when controlling with docker (defaults to `test`)
- `$WWW_ROOT`: root of your php/html documents. Relative to the current directory. Will be created if it doesn't exist (defaults to `./www`)
- `$COMPOSER`: root of your composer cache. Relative to the current directory. Will be created if it doesn't exist (defaults to `./composer`)
- `$DATA_DIR`: root of your database storage. Relative to the current directory. Will be created if it doesn't exist (defaults to `./data`)
- `$LOG_DIR`: root of your logs. Relative to the current directory. Will be created if it doesn't exist (defaults to `./logs`)
- `$PORT`: port that will expose the container's `80` port (defaults to `3000`)
- `$USE_MYSQL`: set it to true if you're using a mySQL storage. Maps mySQL's storage directory to the local `$DATA_DIR` directory


## Tools available:

- php 5.6
- composer (available on the $PATH as "composer")
- php-pear
- apache
- wget
- curl
- imagemagick
- gd
- git

PHP Extensions available:

- iconv
- mcrypt
- sqlite (PDO)
- mySQL (PDO & mysqli)
- pgsql (PDO)
- curl
- mbstring
- tidy
- gd
- openSSL

-----

## Examples

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
cd /var/www/html && \
composer create-project silverstripe/installer ./ 3.3.1 && \
composer require silverstripe/sqlite3 1.4.*-dev && \
composer require "silverstripe/siteconfig:*"
```

------

In the shell, run 

```
sudo service apache2 start
```

