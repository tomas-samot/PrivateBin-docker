#!/bin/bash
# Add --test-cert to the certbot command if you are testing
# Add -m youremail@example.com instead of --register-unsafely-without-email for important account notifications

DOMAIN="example.com"

if [ ! -f /firstcertgen ]; then
  touch /firstcertgen
  # certbot --apache --noninteractive --rsa-key-size 4096 --agree-tos --register-unsafely-without-email --redirect --hsts --uir -d "${DOMAIN}"
  certbot --authenticator webroot --webroot-path /var/www/html --installer apache --noninteractive --rsa-key-size 4096 --agree-tos --register-unsafely-without-email --redirect --hsts --uir -d "${DOMAIN}"
else
  echo "File found! /firstcertgen"
fi
