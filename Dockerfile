FROM php:5.6-apache
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        nodejs \
        npm \
        sudo \
        libsqlite3-0 \
        libsqlite3-dev \
        ucf \
        imagemagick \
        wget \
        curl \
        libcurl4-gnutls-dev \
        git \
        libtidy-dev \
        libzip-dev \
        libssl-dev \
        zlib1g-dev \
        php-pear \
        php5-dev \
        autoconf \
        automake \
        libtool \
        m4
RUN docker-php-ext-install -j$(nproc) \
        mcrypt \
        tidy \
        zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
RUN apt-get clean \
    && apt-get autoremove
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
    && php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified';  } else { echo 'Installer corrupt'; unlink('composer-setup.php');  } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"
RUN a2enmod rewrite
RUN adduser www-data sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
