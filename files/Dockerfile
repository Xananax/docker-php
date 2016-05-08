FROM php:5.6-apache
RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y debconf-utils
# for PHP extension GD
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libfreetype6-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libjpeg62-turbo-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libpng12-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libjpeg-dev
# php extension mcrypt,tidy,zip,ssl,zlib
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libmcrypt-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libtidy-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libzip-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zlib1g-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libpq-dev

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ucf
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick

# tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl libcurl4-gnutls-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php-pear
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php5-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y automake
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libtool
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y m4
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo

# Allow Sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Compile PHP
RUN docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql mysqli mcrypt mbstring tidy zip gd
# cleanup
RUN apt-get clean
RUN apt-get autoremove
RUN rm -rf /var/lib/apt/lists/*

# Allow mod_rewrite on apache
RUN a2enmod rewrite

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
RUN php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '92102166af5abdb03f49ce52a40591073a7b859a86e8ff13338cf7db58a19f7844fbc0bb79b2773bf30791e935dbd938') { echo 'Installer verified';  } else { echo 'Installer corrupt'; unlink('composer-setup.php');  } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
# Clean up
RUN php -r "unlink('composer-setup.php');"

# Add www-data to sudoers
RUN adduser www-data sudo
WORKDIR /var/www
EXPOSE 80
CMD ["apache2-foreground"]
