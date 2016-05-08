# Docker-php

A docker container for running php stuff.  
Based off the [Official Ubuntu PHP Container](https://hub.docker.com/_/php/)

Optionally uses [MariaDB](https://hub.docker.com/_/mariadb/) and/or [PostGresSQL](https://hub.docker.com/_/postgres/)

## How to Use

### Quick start:

```sh
git clone github.com:Xananax/docker-php && \
cd docker-php && \
USE_MYSQL=true USE_PGSQL=true PROJECT=wordpress ./build
```
Then:
```sh
docker-compose up
```

Then open your browser and point it to [localhost:3000](http://localhost:3000).

Edit files in `wordpress/container/www/html`.

------

### Slower Start:

The process of running `./build` will create a directory `./container`. This directory will contain:

- `$PROJECT_NAME`: Whatever you named the `$PROJECT` environment variable
  - `docker-compose.yml`: generated file to bring your container up or down
  - `connect_*`: generated files for quick access into the containers. There'll be at least `connect_server`; `connect_mysql` and/or `connect_pgsql` are generated if you select the respective databases to be included in the build.
  - `run_server_install`: An installation file that can be created if an install script is found for the `$PROJECT_NAME` provided. See below for more details.
  - `container/`: Contains everything related to the different containers
    - `composer/`: The `composer` cache, exposed as a volume so it can be reused
    - `data/`: Will hold that Postgres/MariaDB databases
      - `pgsql/`: Contains Postgres Databases
      - `mysql/`: Contains MariaDB Databases
    - `log/`: Will hold Postgres/MariaDB/Apache logs
      - `pgsql/`: Contains Postgres logs
      - `mysql/`: Contains MariaDB logs
      - `apache/`: Contains Apache logs
    - `www/`: Server root
      - `html/`: Document root
        - `index.php`: A generated index.php with `<?php info()?>` and other useful diagnostics.

This directory is portable; once generated, you're free to tuck it wherever is more convenient

Many environment variables are available to control where and how all of this fits.  

Other available environment variables are:

- *Main Settings*
  - `PROJECT`: The name of the project. Defaults to `"wordpress"`
  - `LOCAL_DIR`: Where files will be built. Defaults to `$PROJECT`
  - `PORT`: Port mapped to the container's port `80`. Defaults to `3000`
  - `USE_MYSQL`: Sets MariaDB usage on. Defaults to `false`
  - `USE_PGSQL`: Sets Postgres usage on. Defaults to `false`
  - `DB_USER`: Default database user. Defaults to `"user"`
  - `DB_PASSWORD`: Default database password. Defaults to `"password"`
  - `DB_NAME`: Default database name. Defaults to `$PROJECT`
- *Directories*
  - `LOCAL_DIR`: The base directory where all the directory structure gets built, relative to `$LOCAL_DIR`. Defaults to `./container`
  - `SERVER_DATA_DIR`: Name of the server root, relative to `$LOCAL_DIR`. Defaults to `www`
  - `DOCUMENT_DIR`: Name of the document root, relative to `$SERVER_DATA_DIR`. Defaults to `html`
  - `COMPOSER_CACHE_DIR`: Name of the directory where composer files are cached, relative to `$LOCAL_DIR`. Defaults to `composer`
  - `DATA_DIR`:Name of the directory containing databases, relative to `$LOCAL_DIR`. Defaults to `data`
  - `PGSQL_DATA_DIR`: Name of the directory containing Postgres databases, relative to `$DATA_DIR`. Defaults to `pgsql`
  - `MYSQL_DATA_DIR`: Name of the directory containing MariaDB databases, relative to `$DATA_DIR`. Defaults to `mysql`
  - `LOG_DIR`: Directory containing logs, relative to `$LOCAL_DIR`. Defaults to `logs`
- *Docker Management Settings*
  - `BASE_IMAGE`: The base image you're building. Expected to be able to run PHP and a server. Defaults to `xananax/php`
  - `PGSQL_IMAGE`: The name of the Postgres Image you're building from. Defaults to `postgres`
  - `MYSQL_IMAGE`: The base MySQL image you're building from. Default to `mariadb`
  - `CONTAINER_NAME`: Name of the main container you're building. Defaults to `$PROJECT`
  - `MYSQL_CONTAINER_NAME`: The name of the created MySQL container. Defaults to `"database_mysql"`
  - `PGSQL_CONTAINER_NAME`: The name of the created Postgres container. Defaults to `"database_postgres"`
- *MariaDB Settings*
  - `MYSQL_USER`: Default MariaDB user. Defaults to `$DB_USER`
  - `MYSQL_PASSWORD`: Default MariaDB password. Defaults to `$DB_PASSWORD`
  - `MYSQL_ROOT_PASSWORD`: Default MariaDB root password. Defaults to `$MYSQL_PASSWORD`
  - `MYSQL_DATABASE`: Default MariaDB database (will be created upon first instanciation). Defaults to `$DB_NAME`
- *Postgres Settings*
  - `PGSQL_USER`: Default Postgres user. Defaults to `$DB_USER`
  - `PGSQL_PASSWORD`: Default Postgres password. Defaults to `$DB_PASSWORD`
  - `PGSQL_DATABASE`: The default Postgres database. Default to `$DB_NAME`

----

## Install Scripts

if the `$PROJECT` variable matches the name of an installer in `./files/first-run`, this installer will be setup and ready to run from inside the container:

```sh
cd PROJECT_NAME
./run_server_install
```

These install scripts remove any `index.php` present inside the document root.

Currently, two install scripts are available:

- `wordpress`: A standard wordpress installation. Set up to work with MySQL
- `silverstripe`: A silverstripe installation through composer, with support for sqlite3 and some plugins. Check the file for more information.
- `drupal`: A bare-bones drupal installation (no drush, no drupal console, no automated settings.php generation)

----


## The xananax/php Docker Image:


Tools Available:

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

## Some Tips:

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
If you wanted to map it to the local 80 port, swap `listen 3000` with `listen 80`.

------

Another example, map the 3000 port to a url in apache

```apache
<VirtualHost localhost:3000>
  ServerName www.example.com
  DocumentRoot /www
</VirtualHost>
```

------

If you run the container in interactive, in the container's shell you'll need to run

```sh
sudo service apache2 start
```

To get Apache to start


## License

MIT
