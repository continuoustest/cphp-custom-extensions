#!/bin/bash

set -x
set -e

phpExt=`find /home/cphp/.phpbrew/php/*/var -name '*.ini' | head -n1`
phpDirExt=`dirname $phpExt`

sudo git clone https://anonscm.debian.org/cgit/pkg-php/php-memcache.git /usr/local/src/memcache
sudo chown -R cphp:cphp /usr/local/src/memcache

cd /usr/local/src/memcache/memcache-3.0.9
git checkout debian/3.0.9_20160311.4991c2f-5

phpize
./configure
make
make install
echo "extension=memcache.so" > $phpDirExt/memcache.ini

php -m | grep memcache
php -i | grep memcache
