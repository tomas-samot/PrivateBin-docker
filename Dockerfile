FROM php:7.0-apache
EXPOSE 80
EXPOSE 443

ENV PRIVATEBIN_URL https://github.com/PrivateBin/PrivateBin/archive/master.zip
ENV DOMAIN example.com

ADD cert.sh /cert.sh
RUN chmod a+x /cert.sh

RUN sed -i "/#ServerName www.example.com/c\ServerName $DOMAIN" /etc/apache2/sites-available/000-default.conf

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        wget \
        zip \
        unzip; \
    # php-gd config
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
docker-php-ext-install -j$(nproc) gd;

RUN apt-get install -y wget
RUN apt-get install -y unzip

RUN set -x \
  && cd /var/www/html \
  && rm -rf *

RUN cd /tmp \
    && wget $PRIVATEBIN_URL \
    && unzip master.zip \
    && cd PrivateBin-master \
    && mv * /var/www/html \
    && cd /var/www/html \
    && rm *.md

RUN echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y python-certbot-apache -t jessie-backports

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get --purge autoremove -y unzip
RUN apt-get --purge autoremove -y wget

RUN echo "Don't forget to edit & run /cert.sh"
