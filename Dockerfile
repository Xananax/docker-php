FROM php:5.6-apache
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y debconf-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libfreetype6-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libjpeg62-turbo-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libmcrypt-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libpng12-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y npm
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libsqlite3-0
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libsqlite3-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ucf
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libcurl4-gnutls-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libtidy-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libzip-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zlib1g-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php-pear
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php5-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y automake
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libtool
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y m4
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql postgresql-contrib postgresql-server-dev-all 
RUN echo "mysql-server mysql-server/root_password password root_pass" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password root_pass" | debconf-set-selections && \
    sudo apt-get -y install mysql-server libmysqlclient-dev
RUN echo "root:root" | chpasswd
RUN adduser www-data sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    pdo_pgsql \
    mcrypt \
    tidy \
    zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
RUN apt-get clean
RUN apt-get autoremove
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
    && php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified';  } else { echo 'Installer corrupt'; unlink('composer-setup.php');  } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"
RUN a2enmod rewrite
RUN postgres createuser --superuser www-data
