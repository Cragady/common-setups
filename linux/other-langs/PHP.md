# PHP

Just look up what you need to install it. This is what I have grepping for php against my installed packages, but I'm certain there were more things that I needed for what I wanted. 

NOTE: THE PACKAGES LISTED IN THIS SECTION INCLUDES BOTH AUTOMATIC AND MANUAL INSTALLS. I may update later to make a distinction. There also be missing packages, in which case just a touch of research should go into finding out the correct packages to install as well. This stack is so widely known, it's not super necessary to be precise here, as finding a setup shouldn't be that difficult.

* libapache2-mod-php8.1
* libapache2-mod-php
* php-common
* php-mysql
* php8.1-cli
* php8.1-common
* php8.1-mysql
* php8.1-opcache
* php8.1-readline
* php8.1
* php

To use PHP, configure Nginx or Apache, and follow tutorials to see a hello world program, and then go from there. After those, might as well go after MySQL for LAMP.

## Nginx

Same thing as PHP with the installs, but here's what I had:


* libnginx-mod-http-geoip2
* libnginx-mod-http-image-filter
* libnginx-mod-http-xslt-filter
* libnginx-mod-mail
* libnginx-mod-stream-geoip2
* libnginx-mod-stream
* nginx-common
* nginx-core
* nginx

## Apache

I think this is pre-installed? If not, same as PHP & Nginx:


* apache2-bin
* apache2-data
* apache2-utils
* apache2
* libapache-pom-java
* libapache2-mod-php8.1
* libapache2-mod-php

## MySQL

* mysql-server
* default-libmysqlclient-dev

## After Note

Nginx and Apache like to fight with how I have them set up. If you are better at these than I am, then you can have them both enabled and have the best of both worlds. What I usually like to do is do a little switcharoo between which one I want to use with systemctl.

